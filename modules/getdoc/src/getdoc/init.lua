-- getdoc module, by Peter Mendel, 05/2014

local gdu = require 'getdoc.util'
local lfs = require 'lfs'
local io = require 'io'

local type, pairs, print, assert, table, string, package, require = type, pairs, print, assert, table, string, package, require
local create = true
local address

module ('getdoc')

--- Function creates table of parsed comments of lua files from given path
-- @name createTableStructure
-- @param path string path to analyze *.lua files
-- @return root created table
function createTableStructure(path)
	local root = {}

	if (string.find(path, "%.lua") ~= nil) then

	    root[path] = gdu.createTableOfComments(gdu.getAstFromFile(path))

	else
	    for file in lfs.dir(path) do
	        if file ~= "." and file ~= ".." then
	            local f = path..'/'..file
	            local attr = lfs.attributes (f)
	            assert (type(attr) == "table")
	            if attr.mode == "directory" then
	                root[f] = createTableStructure (f)
	            else
	            	if string.find(file, "%.lua") ~= nil then
	                	root[f] = gdu.createTableOfComments(gdu.getAstFromFile(f), file)
	            	end
	            end
	        end
	    end
	end
    return root
end

--- Function creates file structure as it is in given path
-- @name createFileStructure
-- @param path string path
-- @param address path of /_getdoc directory, can be nil
function createFileStructure(path, address)

	if (create == true) then
		if address ~= nil then

			lfs.mkdir(address .. "/_getdoc")
			address = address .. "/_getdoc"
		else
			lfs.mkdir("_getdoc")
			address = lfs.currentdir() .. "/_getdoc"

		end

	 	if(string.find(path, "%.lua") ~= nil) then
			local file = string.match(path, "%/%a+%.lua")
		    local ast = createTableStructure(path)

			address = address .. file
			file = io.open(address, "w")
			file:write(gdu.generateReturnTable(ast))
			file:close()
			return
		end
	end
	    for file in lfs.dir(path) do
	        if file ~= "." and file ~= ".." then

	            local f = path..'/'..file
	            local attr = lfs.attributes (f)

	            assert (type(attr) == "table")
	            if attr.mode == "directory" then
					local dir_address = address .. "/dir_" .. file .. ".lua"
					local dir_ast = createTableStructure(f)
	 				local dir_file = io.open(dir_address, "w")
					dir_file:write(gdu.generateReturnTable(dir_ast,file))
					dir_file:close()

					address = address .. "/" ..file
					lfs.mkdir(address)
	 				create = false

	                createFileStructure (f, address)
	                address = address .. "/.."
	            else
	               	if string.find(file, "%.lua") ~= nil then			--matching all *.lua files
	            		local add = address .. "/" .. file
	            		local path2 = path
	            		path = path .. "/" .. file
	            		local ast = createTableStructure(path)
	            		path = path2

	            		file = io.open(add, "w")
						file:write(gdu.generateReturnTable(ast,nil))
						file:close()
	            	end
	            end
	        end
	    end
end

--- Function to execute getdoc require statement and return table of required element
-- @name getdocRequire
-- @param req require statement; syntax directory.file.function.element
-- @return f required element table
function getdocRequire(req, getdoc_path)
	local path = {}
	local final_path = ""
	local final_req = "_getdoc."
	local f
	local pp = package.path

	for part in string.gmatch(req, "([^.]+)") do
		table.insert(path,part)
	end

	if gdu.searchFile(getdoc_path) == "directory" then
		final_path = getdoc_path .. "/"
	elseif gdu.searchFile(lfs.currentdir() .. "/_getdoc") == "directory" then
		final_path = lfs.currentdir() .. "/_getdoc/"
	elseif gdu.searchFile(lfs.currentdir() .. "/../_getdoc") == "directory" then
		final_path = lfs.currentdir() .. "/../_getdoc/"
	elseif gdu.searchFile(lfs.currentdir() .. "/../lib/lua/_getdoc") == "directory" then
		final_path = lfs.currentdir() .. "/../lib/lua/_getdoc/"
	elseif gdu.searchFile(lfs.currentdir() .. "/../share/_getdoc") == "directory" then
		final_path = lfs.currentdir() .. "/../share/_getdoc/"
	else
		return
	end

	local i = 1

	while i <= table.getn(path) do

		if gdu.searchFile(final_path .. "/" .. path[i]) == "directory" then
			final_path = final_path .. path[i] .. "/"
			final_req = final_req .. path[i] .. "."
		elseif (gdu.searchFile(final_path .. "/" .. path[i] ..".lua")) == "file" then
			final_req = final_req .. path[i]
			final_path = final_path .. "/" .. path[i] ..".lua"

			package.path = package.path .. ";" .. final_path

			f = require(final_req)
			break
		else
			return
		end
		i = i + 1
	end

	while i <= table.getn(path) do
		i = i + 1

		for k,v in pairs(f) do
			if k == path[i] then
				f = v
			end
		end
	end

	package.path = pp
	return f
end
