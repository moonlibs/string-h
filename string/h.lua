local ffi = require 'ffi'

--[[

1. test wether we could modify lua strings with mem*
void *memcpy(void *dest, const void *src, size_t n);
void *memmove(void *dest, const void *src, size_t n);
void *memset(char *, int z, size_t);
char *strcpy(char *toHere, const char *fromHere);
char *strncpy(char *toHere, const char *fromHere, size_t n);

2. TODO: define signature and implement

void *memchr(const char *s, char c, size_t n);
void *strchr(const char *s, char c, size_t n);
char *strrchr(const char *s, int c);
int strcoll(const char *, const char *);
size_t strspn(const char *s, const char *accept);
size_t strcspn(const char *s, const char *reject);
char *strpbrk(const char *s, const char *accept);

3. Requres alloc:
size_t strxfrm(char *dest, const char *src, size_t n);
char *strtok(char *, const char *);
char *strtok_r(char *, const char *, char **); -- POSIX

4. Do we need this? Think no
char *strcat(char *dest, const char *src);
char *strncat(char *dest, const char *src, size_t n);

5. Inherit from ffi or bare lua
char *strerror(int);
size_t strlen(const char *);

6. Can't be used in lua
char *strdup(const char *);


]]


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

function M.memcmp(s1,s2)
	return tonumber(C.memcmp(ffi.cast(char_p,s1),ffi.cast(char_p,s2)))
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
