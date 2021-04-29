----
-- Test cases for xlsxwriter.lua.
--
-- Test the creation of a simple xlsxwriter.lua file with hyperlinks.
-- This example doesn't have any link formatting and tests the relationship
-- linkage code.
--
-- Copyright 2014, John McNamara, jmcnamara@cpan.org
--

local Workbook = require "xlsxwriter.workbook"

local workbook  = Workbook:new("test_hyperlink07.xlsx")
local worksheet = workbook:add_worksheet()

worksheet:write_url("A1", [[external:\\VBOXSVR\share\foo.xlsx]], nil, [[J:\foo.xlsx]])
worksheet:write_url("A3", "external:foo.xlsx")

workbook:close()

