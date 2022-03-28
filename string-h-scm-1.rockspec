package = 'string-h'
version = 'scm-1'

source  = {
    url    = 'git+https://github.com/moonlibs/string-h.git';
    branch = 'master';
}

description = {
    summary  = "LuaJIT ffi interface to string.h functions";
    detailed = "LuaJIT ffi interface to string.h functions";
    homepage = 'https://github.com/moonlibs/string-h';
    license  = 'Artistic';
    maintainer = "Mons Anderson <mons@cpan.org>";
}

dependencies = {
    'lua >= 5.1';
}

build = {
    type = 'builtin',
    modules = {
        ['string.h'] = 'string/h.lua';
    }
}
