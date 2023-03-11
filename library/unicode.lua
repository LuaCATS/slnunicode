---@meta

---
---`slnunicode`, from the `selene` libraries, http://luaforge.net/projects/sln. This library has been slightly extended
---so that the `unicode.utf8.*` functions also accept the first 256 values
---of plane 18. This is the range *LuaTeX* uses for raw binary output, as
---explained above. We have no plans to provide more like this because you can
---basically do all that you want in *Lua*.

unicode = {}

unicode.ascii = {}

function unicode.ascii.byte() end
function unicode.ascii.char() end
function unicode.ascii.dump() end
function unicode.ascii.find() end
function unicode.ascii.format() end
function unicode.ascii.gfind() end
function unicode.ascii.gmatch() end
function unicode.ascii.gsub() end
function unicode.ascii.len() end
function unicode.ascii.lower() end
function unicode.ascii.match() end
function unicode.ascii.rep() end
function unicode.ascii.reverse() end
function unicode.ascii.sub() end
function unicode.ascii.upper() end



unicode.grapheme = {}

function unicode.grapheme.byte() end
function unicode.grapheme.char() end
function unicode.grapheme.dump() end
function unicode.grapheme.find() end
function unicode.grapheme.format() end
function unicode.grapheme.gfind() end
function unicode.grapheme.gmatch() end
function unicode.grapheme.gsub() end
function unicode.grapheme.len() end
function unicode.grapheme.lower() end
function unicode.grapheme.match() end
function unicode.grapheme.rep() end
function unicode.grapheme.reverse() end
function unicode.grapheme.sub() end
function unicode.grapheme.upper() end



unicode.latin1 = {}

function unicode.latin1.byte() end
function unicode.latin1.char() end
function unicode.latin1.dump() end
function unicode.latin1.find() end
function unicode.latin1.format() end
function unicode.latin1.gfind() end
function unicode.latin1.gmatch() end
function unicode.latin1.gsub() end
function unicode.latin1.len() end
function unicode.latin1.lower() end
function unicode.latin1.match() end
function unicode.latin1.rep() end
function unicode.latin1.reverse() end
function unicode.latin1.sub() end
function unicode.latin1.upper() end



unicode.utf8 = {}

function unicode.utf8.byte() end
function unicode.utf8.char() end
function unicode.utf8.dump() end
function unicode.utf8.find() end
function unicode.utf8.format() end
function unicode.utf8.gfind() end
function unicode.utf8.gmatch() end
function unicode.utf8.gsub() end
function unicode.utf8.len() end
function unicode.utf8.lower() end
function unicode.utf8.match() end
function unicode.utf8.rep() end
function unicode.utf8.reverse() end
function unicode.utf8.sub() end
function unicode.utf8.upper() end
