local utils = require "luacheck.utils"

describe("utils", function()
   describe("read_file", function()
      it("returns contents of a file", function()
         assert.match("contents\r?\n", utils.read_file("spec/folder/foo"))
      end)

      it("removes UTF-8 BOM", function()
         assert.match("foo\r?\nbar\r?\n", utils.read_file("spec/folder/bom"))
      end)

      it("returns nil for non-existent paths", function()
         assert.is_nil(utils.read_file("spec/folder/non-existent"))
      end)

      it("returns nil for directories", function()
         assert.is_nil(utils.read_file("spec/folder"))
      end)
   end)

   describe("load", function()
      it("loads function in an environment", function()
         local f = utils.load("return g", {g = "foo"})
         assert.is_function(f)
         assert.is_equal("foo", f())
      end)

      it("returns nil on syntax error", function()
         assert.is_nil(utils.load("return return", {}))
      end)
   end)

   describe("load_config", function()
      it("loads config from a file and returns it", function()
         assert.same({foo = "bar"}, (utils.load_config("spec/folder/config")))
      end)

      it("passes second argument as environment", function()
         local function bar() return "bar" end
         assert.same({
            foo = "bar",
            bar = bar
         }, (utils.load_config("spec/folder/env_config", {bar = bar})))
      end)

      it("returns nil, \"I/O\" for non-existent paths", function()
         local ok, err = utils.load_config("spec/folder/non-existent")
         assert.is_nil(ok)
         assert.equal("I/O", err)
      end)

      it("returns nil, \"syntax\" for configs with syntax errors", function()
         local ok, err = utils.load_config("spec/folder/bad_config")
         assert.is_nil(ok)
         assert.equal("syntax", err)
      end)

      it("returns nil, \"runtime\" for configs with run-time errors", function()
         local ok, err = utils.load_config("spec/folder/env_config")
         assert.is_nil(ok)
         assert.equal("runtime", err)
      end)
   end)

   describe("array_to_set", function()
      it("converts array to set and returns it", function()
         assert.same({foo = 3, bar = 2}, utils.array_to_set({"foo", "bar", "foo"}))
      end)
   end)

   describe("concat_arrays", function()
      it("returns concatenated arrays", function()
         assert.same({1, 2, 3, 4}, utils.concat_arrays({{}, {1}, {2, 3, 4}, {}}))
      end)
   end)

   describe("update", function()
      it("updates first table with entries from second", function()
         local t1 = {k1 = 1, k2 = 2}
         local t2 = {k2 = 3, k3 = 4}
         local ret = utils.update(t1, t2)
         assert.same({k1 = 1, k2 = 3, k3 = 4}, t1)
         assert.equal(t1, ret)
      end)
   end)

   describe("class", function()
      it("returns an object creator", function()
         local cl = utils.class()
         assert.is_table(cl)
         cl.field = "foo"
         local obj = cl()
         assert.is_table(obj)
         obj.field2 = "bar"
         assert.equal("foo", obj.field)
         assert.is_nil(cl.field2)
      end)

      it("calls __init on object creation", function()
         local cl = utils.class()
         cl.__init = spy.new(function() end)
         local obj = cl("foo", "bar")
         assert.spy(cl.__init).was_called(1)
         assert.spy(cl.__init).was_called_with(obj, "foo", "bar")
      end)
   end)

   describe("Stack", function()
      it("supports push/pop operations and top/size fields", function()
         local stack = utils.Stack()
         assert.equal(0, stack.size)
         assert.is_nil(stack.top)

         stack:push(7)
         stack:push(8)
         assert.equal(2, stack.size)
         assert.equal(8, stack.top)

         assert.equal(8, stack:pop())
         assert.equal(1, stack.size)
         assert.equal(7, stack.top)

         stack:push(4)
         assert.equal(2, stack.size)
         assert.equal(4, stack.top)

         assert.equal(4, stack:pop())
         assert.equal(7, stack:pop())
         assert.equal(0, stack.size)
         assert.is_nil(stack.top)
      end)
   end)

   describe("pcall", function()
      it("calls f with arg", function()
         assert.equal(3, utils.pcall(math.sqrt, 9))
      end)

      it("returns nil, table if f throws a table", function()
         local t = {"foo"}
         local res, err = utils.pcall(function(x)
            if x == 9 then
               error(t)
            else
               return true
            end
         end, 9)
         assert.is_nil(res)
         assert.is_equal(t, err)
      end)

      it("rethrows if f crashes (throws not a table)", function()
         local ok, err = pcall(utils.pcall, error, "msg")
         assert.is_false(ok)
         assert.matches("msg\nstack traceback:", err)
      end)
   end)

   describe("ripairs", function()
      it("returns reversed ipairs", function()
         local arr = {foo = "bar", 5, 6, 7}
         local iterated = {}

         for i, v in utils.ripairs(arr) do
            table.insert(iterated, {i, v})
         end

         assert.same({{3, 7}, {2, 6}, {1, 5}}, iterated)
      end)
   end)

   describe("after", function()
      it("returns substring after match", function()
         assert.equal("foo bar: baz", utils.after("bar: foo bar: baz", "bar:%s*"))
      end)

      it("returns nil when there is no match", function()
         assert.is_nil(utils.after("bar: foo bar: baz", "baz:%s*"))
      end)
   end)

   describe("strip", function()
      it("returns string without whitespace on ends", function()
         assert.equal("foo bar", utils.strip("\tfoo bar\n   "))
      end)
   end)

   describe("split", function()
      it("without separator, returns non-whitespace substrings", function()
         assert.same({"foo", "bar", "baz"}, utils.split(" foo    bar\n baz  "))
      end)

      it("with separator, returns substrings between them", function()
         assert.same({"", "foo", " bar", "", " baz "}, utils.split(",foo, bar,, baz ", ","))
      end)
   end)

   describe("map", function()
      it("maps function over an array", function()
         assert.same({3, 1, 2}, utils.map(math.sqrt, {9, 1, 4}))
      end)
   end)
end)
