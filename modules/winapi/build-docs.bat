REM building documentation with ldoc
REM http://github.com/stevedonovan/LDoc
ldoc winapi.l.c -o api && lua markdown.lua readme.md -s doc.css -l 
