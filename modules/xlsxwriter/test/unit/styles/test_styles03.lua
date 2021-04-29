----
-- Tests for the xlsxwriter.lua styles class.
--
-- Copyright 2014, John McNamara, jmcnamara@cpan.org
--

require "Test.More"
require "Test.LongString"

plan(1)

----
-- Tests setup.
--
local expected
local got
local caption
local Styles   = require "xlsxwriter.styles"
local Workbook = require "xlsxwriter.workbook"
local styles
local workbook

-- Remove extra whitespace in the formatted XML strings.
function _clean_xml_string(s)
  return (string.gsub(s, ">%s+<", "><"))
end

----
-- Test the _write_styles() method.
--
caption = " \tStyles: Styles: _assemble_xml_file()"
expected = _clean_xml_string([[
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <numFmts count="1">
    <numFmt numFmtId="164" formatCode="0.0"/>
  </numFmts>
  <fonts count="2">
    <font>
      <sz val="11"/>
      <color theme="1"/>
      <name val="Calibri"/>
      <family val="2"/>
      <scheme val="minor"/>
    </font>
    <font>
      <b/>
      <sz val="11"/>
      <color theme="1"/>
      <name val="Calibri"/>
      <family val="2"/>
      <scheme val="minor"/>
    </font>
  </fonts>
  <fills count="2">
    <fill>
      <patternFill patternType="none"/>
    </fill>
    <fill>
      <patternFill patternType="gray125"/>
    </fill>
  </fills>
  <borders count="1">
    <border>
      <left/>
      <right/>
      <top/>
      <bottom/>
      <diagonal/>
    </border>
  </borders>
  <cellStyleXfs count="1">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0"/>
  </cellStyleXfs>
  <cellXfs count="4">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
    <xf numFmtId="2" fontId="0" fillId="0" borderId="0" xfId="0" applyNumberFormat="1"/>
    <xf numFmtId="2" fontId="1" fillId="0" borderId="0" xfId="0" applyNumberFormat="1" applyFont="1"/>
    <xf numFmtId="164" fontId="0" fillId="0" borderId="0" xfId="0" applyNumberFormat="1"/>
  </cellXfs>
  <cellStyles count="1">
    <cellStyle name="Normal" xfId="0" builtinId="0"/>
  </cellStyles>
  <dxfs count="0"/>
  <tableStyles count="0" defaultTableStyle="TableStyleMedium9" defaultPivotStyle="PivotStyleLight16"/>
</styleSheet>]])

styles   = Styles:new()
workbook = Workbook:new("test.xlsx")



local format1 = workbook:add_format{num_format = 2}
local format2 = workbook:add_format{num_format = 2, bold = true}
local format3 = workbook:add_format{num_format = '0.0'}

workbook:_set_default_xf_indices()
workbook:_prepare_format_properties()

local properties = {}
properties["xf_formats"]       = workbook.xf_formats
properties["palette"]          = workbook.palette
properties["font_count"]       = workbook.font_count
properties["num_format_count"] = workbook.num_format_count
properties["border_count"]     = workbook.border_count
properties["fill_count"]       = workbook.fill_count
properties["custom_colors"]    = workbook.custom_colors
properties["dxf_formats"]      = workbook.dxf_formats

styles:_set_style_properties(properties)

styles:_set_filehandle(io.tmpfile())

styles:_assemble_xml_file()

got = _clean_xml_string(styles:_get_data())

is_string(got, expected, caption)
