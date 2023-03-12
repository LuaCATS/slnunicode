---@meta
---
---`slnunicode`, from the `selene` libraries, http://luaforge.net/projects/sln. This library has been slightly extended
---so that the `unicode.utf8.*` functions also accept the first 256 values
---of plane 18. This is the range *LuaTeX* uses for raw binary output, as
---explained above. We have no plans to provide more like this because you can
---basically do all that you want in *Lua*.
--- https://github.com/LuaDist/slnunicode/blob/e8abd35c5f0f5a9084442d8665cbc9c3d169b5fd/slnunico.c#L1285-L1302
---there are four string-like ctype closures:
---unicode.ascii, latin1, utf8 and grapheme
---
---ascii and latin1 are single-byte like string,
---but use the unicode table for upper/lower and character classes
---ascii does not touch bytes > 127 on upper/lower
---
---ascii or latin1 can be used as locale-independent string replacement.
---(There is a compile switch to do this automatically for ascii).
--
---UTF-8 operates on UTF-8 sequences as of RFC 3629:
---1 byte 0-7F, 2 byte 80-7FF, 3 byte 800-FFFF, 4 byte 1000-10FFFF
---(not exclusing UTF-16 surrogate characters)
---Any byte not part of such a sequence is treated as it's (Latin-1) value.
---
---Grapheme takes care of grapheme clusters, which are characters followed by
---"grapheme extension" characters (Mn+Me) like combining diacritical marks.
---
---calls are:
---len(str)
---sub(str, start [,end=-1])
---byte(str, start [,end=-1])
---lower(str)
---upper(str)
---char(i [,j...])
---reverse(str)
---
---same as in string: rep, format, dump
---TODO: use char count with %s in format? (sub does the job)
---TODO: grapheme.byte: only first code of any cluster?
--
---find, gfind, gsub: done, but need thorough testing ...:
---ascii does not match them on any %class (but on ., literals and ranges)
---behaviour of %class with class not ASCII is undefined
---frontier %f currently disabled -- should we?
---
---character classes are:
---%a L* (Lu+Ll+Lt+Lm+Lo)
---%c Cc
---%d 0-9
---%l Ll
---%n N* (Nd+Nl+No, new)
---%p P* (Pc+Pd+Ps+Pe+Pi+Pf+Po)
---%s Z* (Zs+Zl+Zp) plus the controls 9-13 (HT,LF,VT,FF,CR)
---%u Lu (also Lt ?)
---%w %a+%n+Pc (e.g. '_')
---%x 0-9A-Za-z
---%z the 0 byte
---c.f. http://unicode.org/Public/UNIDATA/UCD.html#General_Category_Values
---http://unicode.org/Public/UNIDATA/UnicodeData.txt
---
---NOTE: find positions are in bytes for all ctypes!
---use ascii.sub to cut found ranges!
---this is a) faster b) more reliable
---
---UTF-8 behaviour: match is by codes, code ranges are supported
---
---grapheme behaviour: any %class, '.' and range match includes
---any following grapheme extensions.
---Ranges apply to single code points only.
---If a [] enumeration contains a grapheme cluster,
---this matches only the exact same cluster.
---However, a literal single 'o' standalone or in an [] enumeration
---will match just that 'o',	even if it has a extension in the string.
---Consequently, grapheme match positions are not always cluster positions.
--
local unicode = {}

unicode.ascii = {}

---
---Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
---
---@param s string
---@param i? integer
---@param j? integer
---
---@return integer ...
function unicode.ascii.byte(s, i, j) end

---
---Returns a string with length equal to the number of arguments, in which each character has the internal numeric code equal to its corresponding argument.
---
---@param byte integer
---@param ... integer
---
---@return string
function unicode.ascii.char(byte, ...) end

---
---Returns a string containing a binary representation (a binary chunk) of the given function.
---
---@param f fun(...: any):...unknown
function unicode.ascii.dump(f) end
function unicode.ascii.find() end
function unicode.ascii.format() end
function unicode.ascii.gfind() end
function unicode.ascii.gmatch() end
function unicode.ascii.gsub() end

---
---Returns its length.
---
---@param s string
---
---@return integer
function unicode.ascii.len(s) end

---
---Returns a copy of this string with all uppercase letters changed to lowercase.
---
---@param s string
---
---@return string
function unicode.ascii.lower(s) end
function unicode.ascii.match() end

---
---Returns a string that is the concatenation of `n` copies of the string `s`.
---
---@param s string
---@param n integer
---
---@return string
function unicode.ascii.rep(s, n) end

---
---Returns a string that is the string `s` reversed.
---
---@param s string
---
---@return string
function unicode.ascii.reverse(s) end

---
---Returns the substring of the string that starts at `i` and continues until `j`.
---
---@param s string
---@param i integer
---@param j? integer
---
---@return string
function unicode.ascii.sub(s, i, j) end

---
---Returns a copy of this string with all lowercase letters changed to uppercase.
---
---@param s string
---
---@return string
function unicode.ascii.upper(s) end

unicode.latin1 = {}

---
---Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
---
---@param s string
---@param i? integer
---@param j? integer
---
---@return integer ...
function unicode.latin1.byte(s, i, j) end

---
---Returns a string with length equal to the number of arguments, in which each character has the internal numeric code equal to its corresponding argument.
---
---@param byte integer
---@param ... integer
---
---@return string
function unicode.latin1.char(byte, ...) end

---
---Returns a string containing a binary representation (a binary chunk) of the given function.
---
---@param f fun(...: any):...unknown
function unicode.latin1.dump(f) end
function unicode.latin1.find() end
function unicode.latin1.format() end
function unicode.latin1.gfind() end
function unicode.latin1.gmatch() end
function unicode.latin1.gsub() end

---
---Returns its length.
---
---@param s string
---
---@return integer
function unicode.latin1.len(s) end

---
---Returns a copy of this string with all uppercase letters changed to lowercase.
---
---@param s string
---
---@return string
function unicode.latin1.lower(s) end
function unicode.latin1.match() end

---
---Returns a string that is the concatenation of `n` copies of the string `s`.
---
---@param s string
---@param n integer
---
---@return string
function unicode.latin1.rep(s, n) end

---
---Returns a string that is the string `s` reversed.
---
---@param s string
---
---@return string
function unicode.latin1.reverse(s) end

---
---Returns the substring of the string that starts at `i` and continues until `j`.
---
---@param s string
---@param i integer
---@param j? integer
---
---@return string
function unicode.latin1.sub(s, i, j) end

---
---Returns a copy of this string with all lowercase letters changed to uppercase.
---
---@param s string
---
---@return string
function unicode.latin1.upper(s) end

unicode.grapheme = {}

---
---Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
---
---@param s string
---@param i? integer
---@param j? integer
---
---@return integer ...
function unicode.grapheme.byte(s, i, j) end

---
---Returns a string with length equal to the number of arguments, in which each character has the internal numeric code equal to its corresponding argument.
---
---@param byte integer
---@param ... integer
---
---@return string
function unicode.grapheme.char(byte, ...) end

---
---Returns a string containing a binary representation (a binary chunk) of the given function.
---
---@param f fun(...: any):...unknown
function unicode.grapheme.dump(f) end
function unicode.grapheme.find() end
function unicode.grapheme.format() end
function unicode.grapheme.gfind() end
function unicode.grapheme.gmatch() end
function unicode.grapheme.gsub() end

---
---Returns its length.
---
---@param s string
---
---@return integer
function unicode.grapheme.len(s) end

---
---Returns a copy of this string with all uppercase letters changed to lowercase.
---
---@param s string
---
---@return string
function unicode.grapheme.lower(s) end
function unicode.grapheme.match() end

---
---Returns a string that is the concatenation of `n` copies of the string `s`.
---
---@param s string
---@param n integer
---
---@return string
function unicode.grapheme.rep(s, n) end

---
---Returns a string that is the string `s` reversed.
---
---@param s string
---
---@return string
function unicode.grapheme.reverse(s) end

---
---Returns the substring of the string that starts at `i` and continues until `j`.
---
---@param s string
---@param i integer
---@param j? integer
---
---@return string
function unicode.grapheme.sub(s, i, j) end

---
---Returns a copy of this string with all lowercase letters changed to uppercase.
---
---@param s string
---
---@return string
function unicode.grapheme.upper(s) end

unicode.utf8 = {}

---
---Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
---
---@param s string
---@param i? integer
---@param j? integer
---
---@return integer ...
function unicode.utf8.byte(s, i, j) end

---
---Returns a string with length equal to the number of arguments, in which each character has the internal numeric code equal to its corresponding argument.
---
---@param byte integer
---@param ... integer
---
---@return string
function unicode.utf8.char(byte, ...) end

---
---Returns a string containing a binary representation (a binary chunk) of the given function.
---
---@param f fun(...: any):...unknown
function unicode.utf8.dump(f) end

---
---Looks for the first match of pattern in the string.
---
---@param s string
---@param pattern string
---@param init? integer
---@param plain? boolean
---
---@return integer start
---@return integer end
---@return any ... captured
function unicode.utf8.find(s, pattern, init, plain) end

---
---Returns a formatted version of its variable number of arguments following the description given in its first argument.
---
---@param s any
---@param ... any
---
---@return string
function unicode.utf8.format(s, ...) end

function unicode.utf8.gfind() end

---
---Returns an iterator function that, each time it is called, returns the next captures from `pattern` over the string `s`.
---
---@param s string
---@param pattern string
---
---@return fun():string, ...
function unicode.utf8.gmatch(s, pattern) end

---
---Returns a copy of `s` in which all (or the first `n`, if given) occurrences of the pattern have been replaced by a replacement string specified by `repl`.
---
---@param s string
---@param pattern string
---@param repl string|number|table|function
---@param n? integer
---
---@return string
---@return integer count
function unicode.utf8.gsub(s, pattern, repl, n) end

---
---Returns its length.
---
---@param s string
---
---@return integer
function unicode.utf8.len(s) end

---
---Returns a copy of this string with all uppercase letters changed to lowercase.
---
---@param s string
---
---@return string
function unicode.utf8.lower(s) end

---
---Looks for the first match of pattern in the string.
---
---@param s string
---@param pattern string
---@param init? integer
---
---@return any ...
function unicode.utf8.match(s, pattern, init) end

---
---Returns a string that is the concatenation of `n` copies of the string `s`.
---
---@param s string
---@param n integer
---
---@return string
function unicode.utf8.rep(s, n) end

---
---Returns a string that is the string `s` reversed.
---
---@param s string
---
---@return string
function unicode.utf8.reverse(s) end

---
---Returns the substring of the string that starts at `i` and continues until `j`.
---
---@param s string
---@param i integer
---@param j? integer
---
---@return string
function unicode.utf8.sub(s, i, j) end

---
---Returns a copy of this string with all lowercase letters changed to uppercase.
---
---@param s string
---
---@return string
function unicode.utf8.upper(s) end

return unicode
