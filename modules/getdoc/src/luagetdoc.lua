-- getdoc launcher, by Peter Mendel, 05/2014


local gd = require "getdoc"
local print = print
local path = ""
local address = ""
-- Print usage message.

local function print_help ()
print ("Usage: "..arg[0]..[[ 
Generate files which contain parsed comments in table data structure of given files. 
Available options are:
  -p path                      input directory or file path
  -t path                      output directory path, ./getdoc if empty
  -h, --help                   print this help and exit]])
end

-------------------------------------------------------------------------------
-- Process options.
-- @class table
-- @name OPTIONS

local OPTIONS = {
	p = function (arg, i)
		local dir = arg[i+1]

		if string.sub (dir, -2) ~= "/" then
			dir = dir..'/'
		end
		path = dir
		return 1
	end,
	t = function (arg, i)
		local dir = arg[i+1]
		if string.sub (dir, -2) ~= "/" then
			dir = dir..'/'
		end
		address = dir
		return 1
	end,
	h = print_help,
	help = print_help,
}

-------------------------------------------------------------------------------

local function process_options (arg)

	local i = 1
	while i < #arg or i == #arg do

		local argi = arg[i]

		if string.sub (argi, 1, 1) == '-' then

			local opt = string.sub (argi, 2)

			if string.sub (opt, 1, 1) == '-' then
				opt = string.gsub (opt, "%-", "")

			end
			if OPTIONS[opt] then
				if OPTIONS[opt] (arg, i) then
					i = i + 1
				end
			end
		end
		i = i+1
	end
end 

-- Main function. Process command-line parameters and call getdoc createFileStructure function.

function main (arg)

	local argc = #arg
	if argc < 1 then
		print_help ()
		return
	end
	process_options (arg)
	if address == "" then
		address = nil
	end
	if path ~= "" then

		return getdoc.createFileStructure(path, address)
	end
end

main(arg)
