local s = require 'string.h'

assert(s.strstr("test","test")==0)
assert(s.strstr("aaatest","test")==3)
assert(s.strstr("test","shit")==nil)

assert(s.strcasestr("Test","test")==0)
assert(s.strcasestr("aaaTest","test")==3)
assert(s.strcasestr("Test","shit")==nil)

assert(s.strcmp("test","test")==0)
assert(s.strcmp("tes","test") < 0)
assert(s.strcmp("test","tes") > 0)
assert(s.strcmp("a","b") < 0)
assert(s.strcmp("b","a") > 0)

assert(s.strncmp("test1","test2",4)==0)
assert(s.strncmp("test1","test2","4")==0)

assert(s.strcasecmp("Test","test")==0)
assert(s.strcasecmp("tes","Test") < 0)
assert(s.strcasecmp("Test","tes") > 0)
assert(s.strncasecmp("Test1","test2",4)==0)
assert(s.strncasecmp("Test1","test2","4")==0)

package.loaded['string.h'] = nil
local s = require 'string.h'
assert(s.strstr("test","test")==0)
