local ffi = require 'ffi'

-- reload protect
local M = rawget(_G,'\0string.h')
if M then return M end
M = {}

ffi.cdef[[
char *strstr(const char *haystack, const char *needle);
char *strcasestr(const char *haystack, const char *needle);

int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);

int strcasecmp(const char *s1, const char *s2);
int strncasecmp(const char *s1, const char *s2, size_t n);
]]

local C = ffi.C

local char_p = ffi.typeof("char *");
local long_t = ffi.typeof("unsigned long");

function M.strstr(haystack, needle)
	local hs = ffi.cast(char_p,haystack)
	local nd = ffi.cast(char_p,needle)
	local res = C.strstr(hs,nd)
	if res ~= nil then
		return tonumber( ffi.cast(long_t,res) - ffi.cast(long_t,hs) )
	else
		return
	end
end

function M.strcasestr(haystack, needle)
	local hs = ffi.cast(char_p,haystack)
	local nd = ffi.cast(char_p,needle)
	local res = C.strcasestr(hs,nd)
	if res ~= nil then
		return tonumber( ffi.cast(long_t,res) - ffi.cast(long_t,hs) )
	else
		return
	end
end

function M.strcmp(s1,s2)
	return tonumber(C.strcmp(ffi.cast(char_p,s1),ffi.cast(char_p,s2)))
end

function M.strncmp(s1,s2,n)
	return tonumber(C.strncmp(ffi.cast(char_p,s1),ffi.cast(char_p,s2),tonumber(n)))
end

function M.strcasecmp(s1,s2)
	return tonumber(C.strcasecmp(ffi.cast(char_p,s1),ffi.cast(char_p,s2)))
end

function M.strncasecmp(s1,s2,n)
	return tonumber(C.strncasecmp(ffi.cast(char_p,s1),ffi.cast(char_p,s2),tonumber(n)))
end


rawset(_G,'\0string.h', M)
return M
