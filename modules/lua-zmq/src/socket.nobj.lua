-- Copyright (c) 2011 by Robert G. Jakabosky <bobby@sharedrealm.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-------------------------------------------------------------------------------------
--
-- Generate ZeroMQ socket option code customized for each version of zmq (2.0,2.1,3.x)
--
-------------------------------------------------------------------------------------

local OPT_TYPES = {
NONE   = "NONE",
INT    = "int",
UINT32 = "uint32_t",
UINT64 = "uint64_t",
INT64  = "int64_t",
BLOB   = "const char *",
FD     = "int",
}
local get_set_prefix = {
rw = { c_get = "lzmq_socket_", get='', c_set = "lzmq_socket_set_", set='set_' },
r = { c_get = "lzmq_socket_", get='' },
w = { c_set = "lzmq_socket_", set='' },
}

local socket_options = {
	{ ver_def = 'VERSION_2_0', major = 2, minor = 0,
		[1] =  { name="hwm",               otype="UINT64", mode="rw", ltype="int" },
		[2] =  { },
		[3] =  { name="swap",              otype="INT64",  mode="rw", ltype="int" },
		[4] =  { name="affinity",          otype="UINT64", mode="rw", ltype="uint64_t" },
		[5] =  { name="identity",          otype="BLOB",   mode="rw", ltype="const char *" },
		[6] =  { name="subscribe",         otype="BLOB",   mode="w",  ltype="const char *" },
		[7] =  { name="unsubscribe",       otype="BLOB",   mode="w",  ltype="const char *" },
		[8] =  { name="rate",              otype="INT64",  mode="rw", ltype="int" },
		[9] =  { name="recovery_ivl",      otype="INT64",  mode="rw", ltype="int" },
		[10] = { name="mcast_loop",        otype="INT64",  mode="rw", ltype="int" },
		[11] = { name="sndbuf",            otype="UINT64", mode="rw", ltype="int" },
		[12] = { name="rcvbuf",            otype="UINT64", mode="rw", ltype="int" },
		[13] = { name="rcvmore",           otype="INT64",  mode="r",  ltype="int" },
	},
	{ ver_def = 'VERSION_2_1', major = 2, minor = 1,
		[14] = { name="fd",                otype="FD",     mode="r",  ltype="int" },
		[15] = { name="events",            otype="UINT32", mode="r",  ltype="int" },
		[16] = { name="type",              otype="INT",    mode="r",  ltype="int" },
		[17] = { name="linger",            otype="INT",    mode="rw", ltype="int" },
		[18] = { name="reconnect_ivl",     otype="INT",    mode="rw", ltype="int" },
		[19] = { name="backlog",           otype="INT",    mode="rw", ltype="int" },
		[20] = { name="recovery_ivl_msec", otype="INT64",  mode="rw", ltype="int64_t" },
		[21] = { name="reconnect_ivl_max", otype="INT",    mode="rw", ltype="int" },
	},
	{ ver_def = 'VERSION_3_0', major = 3, minor = 0,
		[1] =  { name="hwm",               otype="INT",    mode="rw",
custom = [[
ZMQ_Error lzmq_socket_set_hwm(ZMQ_Socket *sock, int value) {
	int val;
	int rc;
	val = (int)value;
	rc = zmq_setsockopt(sock, ZMQ_SNDHWM, &value, sizeof(value));
	if(-1 == rc) return rc;
	val = (int)value;
	return zmq_setsockopt(sock, ZMQ_RCVHWM, &value, sizeof(value));
}
ZMQ_Error lzmq_socket_hwm(ZMQ_Socket *sock, int *value) {
	size_t val_len;
	int rc;
	val_len = sizeof(value);
	rc = zmq_getsockopt(sock, ZMQ_SNDHWM, value, &val_len);
	if(-1 == rc) return rc;
	val_len = sizeof(value);
	return zmq_getsockopt(sock, ZMQ_RCVHWM, value, &val_len);
}

]] },
		[2] =  { },
		[3] =  { },
		[4] =  { name="affinity",          otype="UINT64", mode="rw", ltype="uint64_t" },
		[5] =  { name="identity",          otype="BLOB",   mode="rw", ltype="const char *" },
		[6] =  { name="subscribe",         otype="BLOB",   mode="w",  ltype="const char *" },
		[7] =  { name="unsubscribe",       otype="BLOB",   mode="w",  ltype="const char *" },
		[8] =  { name="rate",              otype="INT",    mode="rw", ltype="int" },
		[9] =  { name="recovery_ivl",      otype="INT",    mode="rw", ltype="int" },
		[10] =  { },
		[11] = { name="sndbuf",            otype="INT",    mode="rw", ltype="int" },
		[12] = { name="rcvbuf",            otype="INT",    mode="rw", ltype="int" },
		[13] = { name="rcvmore",           otype="INT",    mode="r",  ltype="int" },
		[14] = { name="fd",                otype="FD",     mode="r",  ltype="int" },
		[15] = { name="events",            otype="INT",    mode="r",  ltype="int" },
		[16] = { name="type",              otype="INT",    mode="r",  ltype="int" },
		[17] = { name="linger",            otype="INT",    mode="rw", ltype="int" },
		[18] = { name="reconnect_ivl",     otype="INT",    mode="rw", ltype="int" },
		[19] = { name="backlog",           otype="INT",    mode="rw", ltype="int" },
		[20] = { },
		[21] = { name="reconnect_ivl_max", otype="INT",    mode="rw", ltype="int" },
		[22] = { name="maxmsgsize",        otype="INT64",  mode="rw", ltype="int64_t" },
		[23] = { name="sndhwm",            otype="INT",    mode="rw", ltype="int" },
		[24] = { name="rcvhwm",            otype="INT",    mode="rw", ltype="int" },
		[25] = { name="multicast_hops",    otype="INT",    mode="rw", ltype="int" },
		[26] = { },
		[27] = { name="rcvtimeo",          otype="INT",    mode="rw", ltype="int" },
		[28] = { name="sndtimeo",          otype="INT",    mode="rw", ltype="int" },
		[29] =  { },
		[30] =  { },
		[31] = { name="ipv4only",          otype="INT",    mode="rw", ltype="int" },
	},
}
local max_options = 50

local function foreach_opt(func)
	for i=1,#socket_options do
		local ver_opts = socket_options[i]
		for num=1,max_options do
			local opt = ver_opts[num]
			if opt then
				func(num, opt, ver_opts)
			end
		end
	end
end
local add=function(t,val) return table.insert(t,val) end
local function template(data, templ)
	return templ:gsub("%${(.-)}", data)
end

local socket_methods = {}
local ffi_opt_names = {}
local max_methods = 0
local function get_methods(opt, ver)
	local num = opt.num
	-- check if methods have been created
	local methods = socket_methods[num]

	if not methods then
		add(ffi_opt_names, "\t\t[".. num .. "] = '" .. opt.name .. "',\n")
		-- need to create methods info.
		methods = {
			num=num,
			name=opt.name,
			get=opt.get, set=opt.set, c_get=opt.c_get, c_set=opt.c_set,
			ltype=opt.ltype, otype=opt.otype, mode=opt.mode,
			versions = {},
		}

		-- initialize all version as not-supported.
		for i=1,#socket_options do
			local ver_opts = socket_options[i]
			methods[ver_opts.ver_def] = false
		end

		if num > max_methods then max_methods = num end

		socket_methods[num] = methods
	end

	-- mark this version as supporting the option.
	methods[ver.ver_def] = true
	add(methods.versions, ver)

	return methods
end

-- do pre-processing of options.
foreach_opt(function(num, opt, ver)
	opt.num = num
	if not opt.name then
		opt.name = 'none'
		opt.otype = 'NONE'
		opt.DEF = 'unused'
		return
	end
	-- track max option number for each version.
	if not ver.max_opt or ver.max_opt < num then
		ver.max_opt = num
	end
	opt.DEF = "ZMQ_" .. opt.name:upper()
	-- ctype & ffi_type
	local ctype = OPT_TYPES[opt.otype]
	opt.ctype = ctype
	if opt.otype == 'BLOB' then
		opt.ffi_type = 'string'
		opt.set_len_param = ', size_t value_len'
		opt.set_val_name = 'value'
		opt.set_len_name = 'value_len'
	elseif ctype ~= 'NONE' then
		opt.ffi_type = ctype .. '[1]'
		opt.set_len_param = ''
		opt.set_val_name = '&value'
		opt.set_len_name = 'sizeof(value)'
	end
	-- getter/setter names
	for meth,prefix in pairs(get_set_prefix[opt.mode]) do
		opt[meth] = prefix .. opt.name
	end
	-- create common list of option get/set methods.
	local methods = get_methods(opt, ver)
end)

local options_c_code = {}
local opt_types = {}

local function if_def(def)
	local code = "#if " .. def .. "\n"
	add(options_c_code, code)
	add(opt_types, code)
end
local function endif(def)
	local code = "#endif /* #if " .. def .. " */\n"
	add(options_c_code, code)
	add(opt_types, code)
end

-- build C code for socket options setters/getters
local last_ver
foreach_opt(function(num, opt, ver)
	if ver ~= last_ver then
		if last_ver then
			endif(last_ver.ver_def)
		end
		last_ver = ver
		if_def(ver.ver_def)
		add(opt_types, template(ver,[[
#define ${ver_def}_MAX_OPT ${max_opt}
]]))
	end
	add(opt_types, template(opt,[[
  OPT_TYPE_${otype},  /* ${num} ${DEF} */
]]))
	if opt.name == 'none' then return end
	-- generate setter
	local set = ''
	local get = ''
	if opt.c_set then
		if opt.otype == 'BLOB' then
			set = [[
ZMQ_Error ${c_set}(ZMQ_Socket *sock, const char *value, size_t str_len) {
	return zmq_setsockopt(sock, ${DEF}, value, str_len);
]]
		elseif opt.ctype == opt.ltype then
			set = [[
ZMQ_Error ${c_set}(ZMQ_Socket *sock, ${ltype} value) {
	return zmq_setsockopt(sock, ${DEF}, &value, sizeof(value));
]]
		else
			set = [[
ZMQ_Error ${c_set}(ZMQ_Socket *sock, ${ltype} value) {
	${ctype} val = (${ctype})value;
	return zmq_setsockopt(sock, ${DEF}, &val, sizeof(val));
]]
		end
		set = set .. "}\n\n"
	end
	-- generate getter
	if opt.c_get then
		if opt.otype == 'BLOB' then
			get = [[
ZMQ_Error ${c_get}(ZMQ_Socket *sock, char *value, size_t *len) {
	return zmq_getsockopt(sock, ${DEF}, value, len);
]]
		elseif opt.ctype == opt.ltype then
			get = [[
ZMQ_Error ${c_get}(ZMQ_Socket *sock, ${ltype} *value) {
	size_t val_len = sizeof(${ltype});
	return zmq_getsockopt(sock, ${DEF}, value, &val_len);
]]
		else
			get = [[
ZMQ_Error ${c_get}(ZMQ_Socket *sock, ${ltype} *value) {
	${ctype} val;
	size_t val_len = sizeof(val);
	int rc = zmq_getsockopt(sock, ${DEF}, &val, &val_len);
	*value = (${ltype})val;
	return rc;
]]
		end
		get = get .. "}\n\n"
	end
	local templ
	if opt.custom then
		templ = opt.custom
	else
		templ = set .. get
	end
	add(options_c_code, template(opt,templ))
end)
endif(last_ver.ver_def)

add(opt_types, [[
#if VERSION_3_0
#  define MAX_OPTS VERSION_3_0_MAX_OPT
#else
#  if VERSION_2_1
#    define MAX_OPTS VERSION_2_1_MAX_OPT
#  else
#    define MAX_OPTS VERSION_2_0_MAX_OPT
#  endif
#endif
};

]])

options_c_code = table.concat(options_c_code)
opt_types = table.concat(opt_types)
ffi_opt_names = table.concat(ffi_opt_names)

local function tunpack(tab, idx, max)
	if idx == max then return tab[idx] end
	return tab[idx], tunpack(tab, idx + 1, max)
end

local function build_meth_if_def(meth)
	local v = {}
	for i=1,#socket_options do
		local ver_opts = socket_options[i]
		if meth[ver_opts.ver_def] then
			v[#v+1] = ver_opts.ver_def
		end
	end
	return v
end

local function build_option_methods()
	local m = {}

	for i=1,max_methods do
		local meth = socket_methods[i]
		if meth then
			local ltype = meth.ltype
			local name
			-- get list of version defs for this method.
			local if_defs = build_meth_if_def(meth)
			-- generate getter method.
			name = meth.get
			if name then
				local args = { ltype, "&value" }
				local val_out = { ltype, "&value" }
				if meth.otype == 'BLOB' then
					val_out = { 'char *', "value", has_length = true }
					args = { 'char *', "value", "size_t", "&#value" }
				end
				m[#m+1] = method (name) { if_defs = if_defs,
					var_out(val_out),
					c_method_call "ZMQ_Error" (meth.c_get) (args),
				}
			end
			-- generate setter method.
			name = meth.set
			if name then
				local args = { ltype, "value" }
				if meth.otype == 'BLOB' then
					args = { ltype, "value", "size_t", "#value" }
				end
				m[#m+1] = method (name) { if_defs = if_defs,
					c_method_call "ZMQ_Error" (meth.c_set) (args),
				}
			end
		end
	end

	return tunpack(m, 1, #m)
end

-------------------------------------------------------------------------------------
--
-- ZeroMQ socket object.
--
-------------------------------------------------------------------------------------

object "ZMQ_Socket" {
	error_on_null = "get_zmq_strerror()",
	ffi_source [[
-- detect zmq version
local VERSION_2_0 = true
local VERSION_2_1 = false
local VERSION_3_0 = false
local zver = _M.version()
if zver[1] == 3 then
	VERSION_2_0 = false
	VERSION_3_0 = true
elseif zver[1] == 2 and zver[2] == 1 then
	VERSION_2_1 = true
end
]],
	c_source ([[

/* detect really old ZeroMQ 2.0.x series. */
#if !defined(ZMQ_RCVMORE)
#  error "Your version of ZeroMQ is too old.  Please upgrade to version 2.1 or to the latest 2.0.x"
#endif

typedef struct ZMQ_Socket ZMQ_Socket;

#ifdef _WIN32
#include <winsock2.h>
typedef SOCKET socket_t;
#else
typedef int socket_t;
#endif

#if VERSION_2_0
#  define zmq_sendmsg      zmq_send
#  define zmq_recvmsg      zmq_recv
#endif

/* socket option types. */
#define OPT_TYPE_NONE		0
#define OPT_TYPE_INT		1
#define OPT_TYPE_UINT32	2
#define OPT_TYPE_UINT64	3
#define OPT_TYPE_INT64	4
#define OPT_TYPE_BLOB		5
#define OPT_TYPE_FD			6

static const int opt_types[] = {
  OPT_TYPE_NONE,    /*  0 unused */
]] .. opt_types .. options_c_code),

	destructor "close" {
		c_method_call "ZMQ_Error"  "zmq_close" {}
	},
	method "bind" {
		c_method_call "ZMQ_Error"  "zmq_bind" { "const char *", "addr" }
	},
	method "connect" {
		c_method_call "ZMQ_Error"  "zmq_connect" { "const char *", "addr" }
	},
	ffi_cdef[[
int zmq_setsockopt (void *s, int option, const void *optval, size_t optvallen);
int zmq_getsockopt (void *s, int option, void *optval, size_t *optvallen);
]],
	ffi_source([[
local option_gets = {}
local option_sets = {}

do
	local opt_name
	local methods = _meth.${object_name}
	setmetatable(option_gets,{__index = function(tab,opt)
		local opt_name = opt_name[opt]
		if not opt_name then return nil end
		local method = methods[opt_name]
		rawset(tab, opt, method)
		return method
	end})
	setmetatable(option_sets,{__index = function(tab,opt)
		local opt_name = opt_name[opt]
		if not opt_name then return nil end
		local method = methods[opt_name] or methods['set_' .. opt_name]
		rawset(tab, opt, method)
		return method
	end})
	opt_name = {
]] .. ffi_opt_names .. [[}
end

]]),
	method "setopt" {
		var_in{ "uint32_t", "opt" },
		var_in{ "<any>", "val" },
		var_out{ "ZMQ_Error", "err" },
		c_source[[
	size_t val_len;
	const void *val;

#if VERSION_2_1
	socket_t fd_val;
#endif
	int int_val;
	uint32_t uint32_val;
	uint64_t uint64_val;
	int64_t int64_val;

#if VERSION_3_0
	/* 3.0 backwards compatibility support for HWM. */
	if(${opt} == ZMQ_HWM) {
		int_val = luaL_checklong(L, ${val::idx});
		val = &int_val;
		val_len = sizeof(int_val);
		${err} = zmq_setsockopt(${this}, ZMQ_SNDHWM, val, val_len);
		if(-1 != ${err}) {
			${err} = zmq_setsockopt(${this}, ZMQ_RCVHWM, val, val_len);
		}
		goto finished;
	}
#endif

	if(${opt} > MAX_OPTS) {
		return luaL_argerror(L, ${opt::idx}, "Invalid socket option.");
	}

	switch(opt_types[${opt}]) {
#if VERSION_2_1
	case OPT_TYPE_FD:
		fd_val = luaL_checklong(L, ${val::idx});
		val = &fd_val;
		val_len = sizeof(fd_val);
		break;
#endif
	case OPT_TYPE_INT:
		int_val = luaL_checklong(L, ${val::idx});
		val = &int_val;
		val_len = sizeof(int_val);
		break;
	case OPT_TYPE_UINT32:
		uint32_val = luaL_checklong(L, ${val::idx});
		val = &uint32_val;
		val_len = sizeof(uint32_val);
		break;
	case OPT_TYPE_UINT64:
		uint64_val = luaL_checklong(L, ${val::idx});
		val = &uint64_val;
		val_len = sizeof(uint64_val);
		break;
	case OPT_TYPE_INT64:
		int64_val = luaL_checklong(L, ${val::idx});
		val = &int64_val;
		val_len = sizeof(int64_val);
		break;
	case OPT_TYPE_BLOB:
		val = luaL_checklstring(L, ${val::idx}, &(val_len));
		break;
	default:
		printf("Invalid socket option type, this shouldn't happen.\n");
		abort();
		break;
	}
	${err} = zmq_setsockopt(${this}, ${opt}, val, val_len);
finished:
]],
		ffi_source[[
	local set = option_sets[${opt}]
	if set then
		return set(${this},${val})
	else
		error("Invalid socket option.")
	end
]],
	},
		ffi_source[[
local tmp_val_len = ffi.new('size_t[1]', 4)
]],
	method "getopt" {
		var_in{ "uint32_t", "opt" },
		var_out{ "<any>", "val" },
		var_out{ "ZMQ_Error", "err" },
		c_source[[
	size_t val_len;

#if VERSION_2_1
	socket_t fd_val;
#endif
	int int_val;
	uint32_t uint32_val;
	uint64_t uint64_val;
	int64_t int64_val;
#define STR_MAX 255
	char str_val[STR_MAX];

	if(${opt} > MAX_OPTS) {
		lua_pushnil(L);
		lua_pushliteral(L, "Invalid socket option.");
		return 2;
	}

	switch(opt_types[${opt}]) {
#if VERSION_2_1
	case OPT_TYPE_FD:
		val_len = sizeof(fd_val);
		${err} = zmq_getsockopt(${this}, ${opt}, &fd_val, &val_len);
		if(0 == ${err}) {
			lua_pushinteger(L, (lua_Integer)fd_val);
			return 1;
		}
		break;
#endif
	case OPT_TYPE_INT:
		val_len = sizeof(int_val);
		${err} = zmq_getsockopt(${this}, ${opt}, &int_val, &val_len);
		if(0 == ${err}) {
			lua_pushinteger(L, (lua_Integer)int_val);
			return 1;
		}
		break;
	case OPT_TYPE_UINT32:
		val_len = sizeof(uint32_val);
		${err} = zmq_getsockopt(${this}, ${opt}, &uint32_val, &val_len);
		if(0 == ${err}) {
			lua_pushinteger(L, (lua_Integer)uint32_val);
			return 1;
		}
		break;
	case OPT_TYPE_UINT64:
		val_len = sizeof(uint64_val);
		${err} = zmq_getsockopt(${this}, ${opt}, &uint64_val, &val_len);
		if(0 == ${err}) {
			lua_pushinteger(L, (lua_Integer)uint64_val);
			return 1;
		}
		break;
	case OPT_TYPE_INT64:
		val_len = sizeof(int64_val);
		${err} = zmq_getsockopt(${this}, ${opt}, &int64_val, &val_len);
		if(0 == ${err}) {
			lua_pushinteger(L, (lua_Integer)int64_val);
			return 1;
		}
		break;
	case OPT_TYPE_BLOB:
		val_len = STR_MAX;
		${err} = zmq_getsockopt(${this}, ${opt}, str_val, &val_len);
		if(0 == ${err}) {
			lua_pushlstring(L, str_val, val_len);
			return 1;
		}
#undef STR_MAX
		break;
	default:
		printf("Invalid socket option type, this shouldn't happen.\n");
		abort();
		break;
	}
	lua_pushnil(L);
]],
		ffi_source[[
	local get = option_gets[${opt}]
	if get then
		return get(${this})
	else
		error("Invalid socket option.")
	end
]],
	},
	--
	-- zmq_send
	--
	method "send_msg" {
		c_export_method_call "ZMQ_Error" "zmq_sendmsg" { "zmq_msg_t *", "msg", "int", "flags?" },
	},
	-- create helper function for `zmq_send`
	c_source[[
ZMQ_Error simple_zmq_send(ZMQ_Socket *sock, const char *data, size_t data_len, int flags) {
	ZMQ_Error err;
	zmq_msg_t msg;
	/* initialize message */
	err = zmq_msg_init_size(&msg, data_len);
	if(0 == err) {
		/* fill message */
		memcpy(zmq_msg_data(&msg), data, data_len);
		/* send message */
		err = zmq_sendmsg(sock, &msg, flags);
		/* close message */
		zmq_msg_close(&msg);
	}
	return err;
}
]],
	method "send" {
		c_method_call "ZMQ_Error" "simple_zmq_send"
			{ "const char *", "data", "size_t", "#data", "int", "flags?"}
	},
	--
	-- zmq_recv
	--
	method "recv_msg" {
		c_export_method_call "ZMQ_Error" "zmq_recvmsg" { "zmq_msg_t *", "msg", "int", "flags?" },
	},
	ffi_source[[
local tmp_msg = ffi.new('zmq_msg_t')
]],
	method "recv" {
		var_in{ "int", "flags?" },
		var_out{ "const char *", "data", has_length = true },
		var_out{ "ZMQ_Error", "err" },
		c_source[[
	zmq_msg_t msg;
	/* initialize message */
	${err} = zmq_msg_init(&msg);
	if(0 == ${err}) {
		/* receive message */
		${err} = zmq_recvmsg(${this}, &msg, ${flags});
		if(0 == ${err}) {
			${data} = zmq_msg_data(&msg);
			${data_len} = zmq_msg_size(&msg);
		}
	}
]],
		c_source "post" [[
	/* close message */
	zmq_msg_close(&msg);
]],
		ffi_source[[
	local msg = tmp_msg
	-- initialize blank message.
	if C.zmq_msg_init(msg) < 0 then
		return nil, get_zmq_strerror()
	end

	-- receive message
	${err} = zmq_recvmsg(${this}, msg, ${flags})
	if 0 == ${err} then
		local data = ffi.string(C.zmq_msg_data(msg), C.zmq_msg_size(msg))
		-- close message
		C.zmq_msg_close(msg)
		return data
	end
]],
		ffi_source "ffi_post" [[
	-- close message
	C.zmq_msg_close(msg)
]],
	},

	-- build option set/get methods.  THIS MUST BE LAST.
	build_option_methods(),
}

