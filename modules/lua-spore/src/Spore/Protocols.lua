
--
-- lua-Spore : <http://fperrad.github.com/lua-Spore>
--

local assert = assert
local pairs = pairs
local pcall = pcall
local require = require
local unpack = require 'table'.unpack or unpack
local io = require 'io'
local math = require 'math'
local string = require 'string'
local ltn12 = require 'ltn12'
local mime = require 'mime'
local url = require 'socket.url'
local tconcat = require 'table'.concat
math.randomseed(os.time())


_ENV = nil
local m = {}

local r, https = pcall(require, 'ssl.https')
if not r then
    https = nil
end
local protocol = {
    http    = require 'socket.http',
    https   = https,
}

local function slurp (name)
    local uri = url.parse(name)
    if not uri.scheme or uri.scheme == 'file' then
        local f, msg = io.open(uri.path)
        assert(f, msg)
        local content = f:read '*a'
        f:close()
        return content
    else
        local res = m.request{
            env = {
                spore = {
                    url_scheme = uri.scheme,
                    debug = require'Spore'.debug,
                },
            },
            method = 'GET',
            url = name,
        }
        assert(res.status == 200, res.status .. " not expected")
        return res.body
    end
end
m.slurp = slurp

local function boundary (size)
    local t = {}
    for i = 1, 3 * size do
        t[#t+1] = math.random(256) - 1
    end
    local b = mime.b64(string.char(unpack(t))):gsub('%W', 'X')
    return b
end

local function _form_data (data)
    local p = {}
    for k, v in pairs(data) do
        if v:sub(1, 1) == '@' then
            local fname = v:sub(2)
            local content = slurp(fname)
            p[#p+1] = 'content-disposition: form-data; name="' .. k .. '"; filename="' .. fname ..'"\r\n'
                   .. 'content-type: application/octet-stream\r\n\r\n'
                   .. content
        else
            p[#p+1] = 'content-disposition: form-data; name="' .. k .. '"\r\n\r\n' .. v
        end
    end

    local b = boundary(10)
    local t = {}
    for i = 1, #p do
        t[#t+1] = '--'
        t[#t+1] = b
        t[#t+1] = '\r\n'
        t[#t+1] = p[i]
        t[#t+1] = '\r\n'
    end
    t[#t+1] = '--'
    t[#t+1] = b
    t[#t+1] = '--'
    t[#t+1] = '\r\n'
    return tconcat(t), b
end

local function request (req)
    local spore = req.env.spore
    local prot = protocol[spore.url_scheme]
    assert(prot, "not protocol " .. spore.url_scheme)

    local form_data = spore.form_data
    if form_data then
        local content, boundary = _form_data(form_data)
        req.source = ltn12.source.string(content)
        req.headers['content-length'] = content:len()
        req.headers['content-type'] = 'multipart/form-data; boundary=' .. boundary
    end

    local payload = spore.payload
    if payload then
        if payload:sub(1, 1) == '@' then
            local fname = payload:sub(2)
            payload = slurp(fname)
        end
        req.source = ltn12.source.string(payload)
        req.headers['content-length'] = payload:len()
        req.headers['content-type'] = req.headers['content-type'] or 'application/x-www-form-urlencoded'
    end

    if req.method == 'POST' and not req.headers['content-length'] then
        req.headers['content-length'] = 0
    end

    local t = {}
    req.sink = ltn12.sink.table(t)

    if spore.debug then
        spore.debug:write(req.method, " ", req.url, "\n")
        for k, v in pairs(req.headers) do
            spore.debug:write(k, ": ", v, "\n")
        end
    end
    local r, status, headers, line = prot.request(req)
    if spore.debug then
        spore.debug:write(line or status, "\n")
    end
    return {
        request = req,
        status = status,
        headers = headers,
        body = tconcat(t),
    }
end
m.request = request

return m
--
-- Copyright (c) 2010-2011 Francois Perrad
--
-- This library is licensed under the terms of the MIT/X11 license,
-- like Lua itself.
--
