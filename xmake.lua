set_project("quickjs")

set_toolchains("gcc")

-- add rules: debug/release
add_rules("mode.debug", "mode.release")
add_defines("CONFIG_VERSION=\"2024-07-28\"")

if is_plat("windows") then 
    add_defines("CONFIG_WIN32=\"y\"")
end 

option("CONFIG_BIGNUM")
    set_default(false)
    set_showmenu(true)
    add_defines("CONFIG_BIGNUM")

-- define target
target("libregexp")

    -- set kind
    set_kind("static")

    -- add files
    add_files("./libregexp.c")

-- define target
target("quickjs")

    -- set kind
    set_kind("static")

    add_deps("libregexp")

    -- add files
    add_files("./cutils.c")
    add_files("./libbf.c")
    add_files("./libunicode.c")
    add_files("./quickjs-libc.c")
    add_files("./quickjs.c")

target("unicode_gen")

    -- set kind
    set_kind("static")

    -- add files
    add_files("./unicode_gen.c")

    -- add deps
    add_deps("quickjs")

--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro defination
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

