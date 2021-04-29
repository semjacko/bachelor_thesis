package.path = package.path..'../src'

local port = os.getenv('LUAWS_WSTEST_PORT') or 8081
local url = 'ws://localhost:'..port

local client = require'websocket.client'

describe(
  'The client module',
  function()
    local wsc
    it(
      'exposes the correct interface',
      function()
        assert.is_same(type(client),'table')
        assert.is_same(type(client.new),'function')
        assert.is_equal(client.new,client.sync)
      end)
    
    it(
      'can be constructed',
      function()
        wsc = client.new()
      end)
    
    it(
      'can connect (requires external websocket server)',
      function()
        assert.is_same(type(wsc.connect),'function')
        wsc:connect(url,'echo-protocol')
      end)
    
    it(
      'returns error on non-ws protocol',
      function()
        local c = client.new()
        local ok,err = c:connect('wsc://localhost:'..port,'echo-protocol')
        assert.is_falsy(ok)
        assert.is_equal(err,'bad protocol')
      end)
    
    it(
      'forwards socket errors',
      function()
        local c = client.new()
        local ok,err = c:connect('ws://localhost:8189','echo-protocol')
        assert.is_falsy(ok)
        assert.is_equal(err,'connection refused')
        
        local ok,err = c:connect('ws://notexisting:8089','echo-protocol')
        assert.is_falsy(ok)
        assert.is_equal(err,'host not found')
      end)
    
    it(
      'returns error when sending in non-open state (requires external websocket server @port 8081)',
      function()
        local c = client.new()
        local ok,err = c:send('test')
        assert.is_falsy(ok)
        assert.is_equal(err,'wrong state')
        
        c:connect(url,'echo-protocol')
        c:close()
        local ok,err = c:send('test')
        assert.is_falsy(ok)
        assert.is_equal(err,'wrong state')
      end)
    
    it(
      'returns error when connecting twice (requires external websocket server @port 8081)',
      function()
        local c = client.new()
        local ok,err = c:connect(url,'echo-protocol')
        assert.is_truthy(ok)
        assert.is_nil(err)
        
        local ok,err = c:connect(url,'echo-protocol')
        assert.is_falsy(ok)
        assert.is_equal(err,'wrong state')
      end)
    
    it(
      'can send (requires external websocket server @port 8081)',
      function()
        assert.is_same(type(wsc.send),'function')
        wsc:send('Hello again')
      end)
    
    it(
      'can receive (requires external websocket server @port 8081)',
      function()
        assert.is_same(type(wsc.receive),'function')
        local echoed = wsc:receive()
        assert.is_same(echoed,'Hello again')
      end)
    
    local random_text = function(len)
      local chars = {}
      for i=1,len do
        chars[i] = string.char(math.random(33,126))
      end
      return table.concat(chars)
    end
    
    it(
      'can send with payload 127 (requires external websocket server @port 8081)',
      function()
        local text = random_text(127)
        wsc:send(text)
        local echoed = wsc:receive()
        assert.is_same(text,echoed)
      end)
    
    it(
      'can send with payload 0xffff-1 (requires external websocket server @port 8081)',
      function()
        local text = random_text(0xffff-1)
        assert.is_same(#text,0xffff-1)
        wsc:send(text)
        local echoed = wsc:receive()
        assert.is_same(#text,#echoed)
        assert.is_same(text,echoed)
      end)
    
    it(
      'can send with payload 0xffff+1 (requires external websocket server @port 8081)',
      function()
        local text = random_text(0xffff+1)
        assert.is_same(#text,0xffff+1)
        wsc:send(text)
        local echoed = wsc:receive()
        assert.is_same(#text,#echoed)
        assert.is_same(text,echoed)
      end)
    
    it(
      'can close cleanly (requires external websocket server @port 8081)',
      function()
        local was_clean,code,reason = wsc:close()
        assert.is_true(was_clean)
        assert.is_true(code >= 1000)
        assert.is_string(reason)
      end)
    
  end)
