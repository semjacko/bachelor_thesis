module "moonscript.compile", package.seeall

util = require "moonscript.util"
dump = require "moonscript.dump"

require "moonscript.compile.format"
require "moonscript.compile.statement"
require "moonscript.compile.value"

transform = require "moonscript.transform"

import NameProxy, LocalName from transform
import Set from require "moonscript.data"
import ntype from require "moonscript.types"

import concat, insert from table
import pos_to_line, get_closest_line, trim from util

mtype = util.moon.type

export tree, value, format_error
export Block, RootBlock

local Line, Lines

-- a buffer for building up lines
class Lines
  new: =>
    @posmap = {}

  mark_pos: (pos, line=#@) =>
    @posmap[line] = pos unless @posmap[line]

  -- append a line or lines to the buffer
  add: (item) =>
    switch mtype item
      when Line
        item\render self
      when Block
        item\render self
      else
        @[#@ + 1] = item
    @

  flatten_posmap: (line_no=0, out={}) =>
    posmap = @posmap
    for i, l in ipairs @
      switch type l
        when "table"
          _, line_no = l\flatten_posmap line_no, out
        when "string"
          line_no += 1
          out[line_no] = posmap[i]

    out, line_no

  flatten: (indent=nil, buffer={}) =>
    for i = 1, #@
      l = @[i]
      switch type l
        when "string"
          insert buffer, indent if indent
          insert buffer, l

          -- insert breaks between ambiguous statements
          if "string" == type @[i + 1]
            lc = l\sub(-1)
            if (lc == ")" or lc == "]") and @[i + 1]\sub(1,1) == "("
              insert buffer, ";"

          insert buffer, "\n"
          last = l
        when "table"
           l\flatten indent and indent .. indent_char or indent_char, buffer
    buffer

  __tostring: =>
    -- strip non-array elements
    strip = (t) ->
      if "table" == type t
        [strip v for v in *t]
      else
        t

    "Lines<#{util.dump(strip @)\sub 1, -2}>"

-- Buffer for building up a line
-- A plain old table holding either strings or Block objects.
-- Adding a line to a line will cause that line to be merged in.
class Line
  pos: nil

  _append_single: (item) =>
    if Line == mtype item
      -- print "appending line to line", item.pos, item
      @pos = item.pos unless @pos -- bubble pos if there isn't one
      @_append_single value for value in *item
    else
      insert self, item
    nil

  append_list: (items, delim) =>
    for i = 1,#items
      @_append_single items[i]
      if i < #items then insert self, delim
    nil

  append: (...) =>
    @_append_single item for item in *{...}
    nil

  -- todo: try to remove concats from here
  render: (buffer) =>
    current = {}

    add_current = ->
      buffer\add concat current
      buffer\mark_pos @pos

    for chunk in *@
      switch mtype chunk
        when Block
          for block_chunk in *chunk\render Lines!
            if "string" == type block_chunk
              insert current, block_chunk
            else
              add_current!
              buffer\add block_chunk
              current = {}
        else
          insert current, chunk

    if #current > 0
      add_current!

    buffer

  __tostring: =>
    "Line<#{util.dump(@)\sub 1, -2}>"

class Block
  header: "do"
  footer: "end"

  export_all: false
  export_proper: false

  __tostring: =>
    h = if "string" == type @header
      @header
    else
      unpack @header\render {}

    "Block<#{h}> <- " .. tostring @parent

  new: (@parent, @header, @footer) =>
    @_lines = Lines!

    @_names = {}
    @_state = {}
    @_listeners = {}

    with transform
      @transform = {
        value: .Value\bind self
        statement: .Statement\bind self
      }

    if @parent
      @root = @parent.root
      @indent = @parent.indent + 1
      setmetatable @_state, { __index: @parent._state }
      setmetatable @_listeners, { __index: @parent._listeners }
    else
      @indent = 0

  set: (name, value) =>
    @_state[name] = value

  get: (name) =>
    @_state[name]

  listen: (name, fn) =>
    @_listeners[name] = fn

  unlisten: (name) =>
    @_listeners[name] = nil

  send: (name, ...) =>
    if fn = @_listeners[name]
      fn self, ...

  declare: (names) =>
    undeclared = for name in *names
      is_local = false
      real_name = switch mtype name
        when LocalName
          is_local = true
          name\get_name self
        when NameProxy then name\get_name self
        when "string" then name

      real_name if is_local or real_name and not @has_name real_name

    @put_name name for name in *undeclared
    undeclared

  whitelist_names: (names) =>
    @_name_whitelist = Set names

  put_name: (name, ...) =>
    value = ...
    value = true if select("#", ...) == 0

    name = name\get_name self if NameProxy == mtype name
    @_names[name] = value

  has_name: (name, skip_exports) =>
    if not skip_exports
      return true if @export_all
      return true if @export_proper and name\match"^[A-Z]"

    yes = @_names[name]
    if yes == nil and @parent
      if not @_name_whitelist or @_name_whitelist[name]
        @parent\has_name name, true
    else
      yes

  free_name: (prefix, dont_put) =>
    prefix = prefix or "moon"
    searching = true
    name, i = nil, 0
    while searching
      name = concat {"", prefix, i}, "_"
      i = i + 1
      searching = @has_name name, true

    @put_name name if not dont_put
    name

  init_free_var: (prefix, value) =>
    name = @free_name prefix, true
    @stm {"assign", {name}, {value}}
    name

  -- add a line object
  add: (item) =>
    @_lines\add item
    item

  -- todo: pass in buffer as argument
  render: (buffer) =>
    buffer\add @header
    buffer\mark_pos @pos

    if @next
      buffer\add @_lines
      @next\render buffer
    else
      -- join an empty block into a single line
      if #@_lines == 0 and "string" == type buffer[#buffer]
        buffer[#buffer] ..= " " .. (unpack Lines!\add @footer)
      else
        buffer\add @_lines
        buffer\add @footer
        buffer\mark_pos @pos

    buffer

  block: (header, footer) =>
    Block self, header, footer

  line: (...) =>
    with Line!
      \append ...

  is_stm: (node) =>
    line_compile[ntype node] != nil

  is_value: (node) =>
    t = ntype node
    value_compile[t] != nil or t == "value"

  -- line wise compile functions
  name: (node) => @value node
  value: (node, ...) =>
    node = @transform.value node
    action = if type(node) != "table"
      "raw_value"
    else
      node[1]

    fn = value_compile[action]
    error "Failed to compile value: "..dump.value node if not fn

    out = fn self, node, ...

    -- store the pos, creating a line if necessary
    if type(node) == "table" and node[-1]
      if type(out) == "string"
        out = with Line! do \append out
      out.pos = node[-1]

    out

  values: (values, delim) =>
    delim = delim or ', '
    with Line!
      \append_list [@value v for v in *values], delim

  stm: (node, ...) =>
    return if not node -- skip blank statements
    node = @transform.statement node

    result = if fn = line_compile[ntype(node)]
      fn self, node, ...
    else
      -- coerce value into statement
      if has_value node
        @stm {"assign", {"_"}, {node}}
      else
        @value node

    if result
      if type(node) == "table" and type(result) == "table" and node[-1]
        result.pos = node[-1]
      @add result

    nil

  stms: (stms, ret) =>
    error "deprecated stms call, use transformer" if ret
    @stm stm for stm in *stms
    nil

  splice: (fn) =>
    lines = {"lines", @_lines}
    @_lines = Lines!
    @stms fn lines

class RootBlock extends Block
  new: (@options) =>
    @root = self
    super!

  __tostring: => "RootBlock<>"

  root_stms: (stms) =>
    unless @options.implicitly_return_root == false
      stms = transform.Statement.transformers.root_stms self, stms
    @stm s for s in *stms

  render: =>
    -- print @_lines
    buffer = @_lines\flatten!
    buffer[#buffer] = nil if buffer[#buffer] == "\n"
    table.concat buffer

format_error = (msg, pos, file_str) ->
  line = pos_to_line file_str, pos
  line_str, line = get_closest_line file_str, line
  line_str = line_str or ""
  concat {
    "Compile error: "..msg
    (" [%d] >>    %s")\format line, trim line_str
  }, "\n"

value = (value) ->
  out = nil
  with RootBlock!
    \add \value value
    out = \render!
  out

tree = (tree, options={}) ->
  assert tree, "missing tree"

  scope = (options.scope or RootBlock) options

  runner = coroutine.create ->
    scope\root_stms tree

  success, err = coroutine.resume runner
  if not success
    error_msg = if type(err) == "table"
      error_type = err[1]
      if error_type == "user-error"
        err[2]
      else
        error "Unknown error thrown", util.dump error_msg
    else
      concat {err, debug.traceback runner}, "\n"

    nil, error_msg, scope.last_pos
  else
    lua_code = scope\render!
    posmap = scope._lines\flatten_posmap!
    lua_code, posmap

