require "config"
require "tools"

local local_run_test = lunit and function() end or run_test
local lunit = require "lunit"
local arg = {...}

local _ENV = TEST_CASE'Value test'

function setup()
end

function teardown()
end

local types = {
  'ubigint', 'sbigint', 'utinyint', 'stinyint', 'ushort', 'sshort', 
  'ulong', 'slong', 'float', 'double', 'date', 'time', 'timestamp',
  'bit', 'char', 'binary', 'wchar'
}

local tsize = {
  ubigint  = 8,
  sbigint  = 8,
  ulong    = 4,
  slong    = 4,
  ushort   = 2,
  sshort   = 2, 
  utinyint = 1,
  stinyint = 1,
  bit      = 1,

  float    = 8,
  double   = 8,
  date     = 6,
  time     = 6,
  char     = nil,
  binary   = nil,
  wchar    = nil,
}

function test_ctor()
  local val;
  for i, tname in ipairs(types)do 
    val = odbc[tname]()    assert_true(val:is_null())
    val = odbc[tname](nil) assert_true(val:is_null())
    if(tname ~= 'bit')then
      assert_error('fail empty assign to ' .. tname, function() val:set() end)
      assert_error('fail nil   assign to ' .. tname, function() val:set(nil) end)
    else
      val:set(true) val:set()    assert_false(val:get())
      val:set(true) val:set(nil) assert_false(val:get())
      val:set(true) val:set(0)   assert_false(val:get())
      val:set(true) val:set(1)   assert_true (val:get())
    end
    local sz = tsize[tname]
    if sz then assert_equal(sz, val:size()) end
  end
end

function test_buf()
  for _, tname in ipairs{"binary","char"} do
    local val = odbc[tname](10)
    assert_equal(10, val:size())
    assert_equal(0,  val:length())
    assert_true(val:is_null())
    val:set("")
    assert_equal(0, val:length())
    assert_false(val:is_null())
    val:set(("\0"):rep(2*val:size()))
    assert_equal(val:size(), val:length())
  end
end

function test_date()
  val = assert_not_nil(odbc.date())
  assert_true(val:is_null())
  val:set("1995-05-08")
  assert_false(val:is_null())
  assert_equal("1995-05-08", val:get())
  val:set("1999a-08-a08")
  assert_equal("1995-05-08", val:get())
  val:set("1999-8-7")
  assert_equal("1999-08-07", val:get())
end

function test_time()
  val = assert_not_nil(odbc.time())
  assert_true(val:is_null())
  val:set("5:8:9")
  assert_false(val:is_null())
  assert_equal("05:08:09", val:get())
  val:set("aa:bb:cc")
  assert_equal("05:08:09", val:get())
  val:set("06:07:08")
  assert_equal("06:07:08", val:get())
end

function test_timestamp()
  val = assert_not_nil(odbc.timestamp())
  assert_true(val:is_null())
  val:set("1995-2-01 5:8:9.123")
  assert_false(val:is_null())
  assert_equal("1995-02-01 05:08:09.123", val:get())
  val:set("1995-2-01 5:8:9.0")
  assert_equal("1995-02-01 05:08:09", val:get())
  val:set("1995-3-02 7:9:5")
  assert_equal("1995-03-02 07:09:05", val:get())
end

local _ENV = TEST_CASE'Select into value test'

local TEST_ROWS = 1
local env, cnn, stmt
local TEST_BIN_VAL  = ("\0"):rep(50)
local TEST_STR_VAL = ("A"):rep(50)

local function fin_table()
  assert_equal(DROP_TABLE_RETURN_VALUE, drop_table(cnn))
  assert_false(table_exists(cnn))
end

local function init_table()
  assert_boolean(table_exists(cnn))
  assert_equal(CREATE_TABLE_RETURN_VALUE, ensure_table(cnn))
  assert_true(table_exists(cnn))
  stmt = assert(cnn:statement())
  assert_true(cnn:setautocommit(false))
  assert_true(stmt:prepare("insert into " .. TEST_TABLE_NAME .. "(f1,f2) values(?,?)"))
  for i = 1, TEST_ROWS do
    assert_true(stmt:bindbin(1, TEST_BIN_VAL))
    assert_true(stmt:bindstr(2, TEST_STR_VAL))
    assert_equal(1, stmt:execute())
    assert_true(stmt:closed())
  end
  assert_true( cnn:commit()   )
  assert_true( stmt:reset()   )
  assert_true(cnn:setautocommit(true))
  assert_equal(TEST_ROWS, stmt:execute("select count(*) from " .. TEST_TABLE_NAME):fetch() )
  assert_true( stmt:destroy() )
  stmt = nil
end

function teardown()
  if cnn and cnn:connected() then fin_table() end
  if stmt then stmt:destroy() end
  if cnn  then cnn:destroy()  end
  if env  then env:destroy()  end
  stmt = nil
  cnn  = nil
  env  = nil
end

function setup()
  env, cnn = do_connect()
  assert_not_nil(env, cnn)
  init_table()
  stmt = assert(cnn:statement())
end

function test_overflow()
  local binVal = assert_userdata(odbc.binary(10):bind_col(stmt, 1))
  local strVal = assert_userdata(odbc.char(10):bind_col(stmt, 2))

  assert_equal(stmt, stmt:execute("select f1, f2 from " .. TEST_TABLE_NAME))
  assert_true(stmt:vfetch())

  assert_equal(binVal:size(), binVal:length())
  assert_equal(strVal:size(), strVal:length())

  local subBin = string.sub(TEST_BIN_VAL, 1, binVal:length())
  local subStr = string.sub(TEST_STR_VAL, 1, strVal:length())
  assert_equal(subBin, binVal:get())
  assert_equal(subStr, strVal:get())
end


local_run_test(arg)