Command line interface
======================

``luacheck`` program accepts files, directories and `rockspecs <http://www.luarocks.org/en/Rockspec_format>`_ as arguments. They can be filtered using ``--include-files`` and ``--exclude-files`` options, see below.

* Given a file, ``luacheck`` will check it.
* Given ``-``, ``luacheck`` will check stdin.
* Given a directory, ``luacheck`` will check all files within it, selecting only files with ``.lua`` extension unless ``--include-files`` option is used. This feature requires `LuaFileSystem <http://keplerproject.github.io/luafilesystem/>`_ (installed automatically if LuaRocks was used to install Luacheck).
* Given a rockspec (a file with ``.rockspec`` extension), ``luacheck`` will check all files with ``.lua`` extension mentioned in the rockspec in ``build.install.lua``, ``build.install.bin`` and ``build.modules`` tables.

The output of ``luacheck`` consists of separate reports for each checked file and ends with a summary::

   $ luacheck src
   Checking src/bad_code.lua                         5 warnings

       src/bad_code.lua:3:16: unused variable helper
       src/bad_code.lua:3:23: unused variable length argument
       src/bad_code.lua:7:10: setting non-standard global variable embrace
       src/bad_code.lua:8:10: variable opt was previously defined as an argument on line 7
       src/bad_code.lua:9:11: accessing undefined variable hepler

   Checking src/good_code.lua                        OK
   Checking src/python_code.lua                      1 error

       src/python_code.lua:1:6: expected '=' near '__future__'

   Checking src/unused_code.lua                      9 warnings

       src/unused_code.lua:3:18: unused argument baz
       src/unused_code.lua:4:8: unused loop variable i
       src/unused_code.lua:5:13: unused variable q
       src/unused_code.lua:7:11: unused loop variable a
       src/unused_code.lua:7:14: unused loop variable b
       src/unused_code.lua:7:17: unused loop variable c
       src/unused_code.lua:13:7: value assigned to variable x is unused
       src/unused_code.lua:14:1: value assigned to variable x is unused
       src/unused_code.lua:22:1: value assigned to variable z is unused

   Total: 14 warnings / 1 error in 4 files

``luacheck`` exits with 0 if no warnings or errors occurred and with a positive number otherwise.

.. _cliopts:

Command line options
--------------------

Short options that do not take an argument can be combined into one, so that ``-qqu`` is equivalent to ``-q -q -u``. For long options, both ``--option value`` or ``--option=value`` can be used.

Options taking several arguments can be used several times; ``--ignore foo --ignore bar`` is equivalent to ``--ignore foo bar``.

Note that options that may take several arguments, such as ``--globals``, should not be used immediately before positional arguments; given ``--globals foo bar file.lua``, ``luacheck`` will consider all ``foo``, ``bar`` and ``file.lua`` global and then panic as there are no file names left.

======================================= ================================================================================
Option                                  Meaning
======================================= ================================================================================
``-g | --no-global``                    Filter out warnings related to global variables.
``-u | --no-unused``                    Filter out warnings related to unused variables and values.
``-r | --no-redefined``                 Filter out warnings related to redefined variables.
``-a | --no-unused-args``               Filter out warnings related to unused arguments and loop variables.
``-s | --no-unused-secondaries``        Filter out warnings related to unused variables set together with used ones.

                                        See :ref:`secondaryvaluesandvariables`
``--no-self``                           Filter out warnings related to implicit ``self`` argument.
``--std <std>``                         Set standard globals. ``<std>`` can be one of:

                                        * ``_G`` - globals of the Lua interpreter ``luacheck`` runs on (default);
                                        * ``lua51`` - globals of Lua 5.1;
                                        * ``lua52`` - globals of Lua 5.2;
                                        * ``lua52c`` - globals of Lua 5.2 compiled with LUA_COMPAT_ALL;
                                        * ``lua53`` - globals of Lua 5.3; 
                                        * ``lua53c`` - globals of Lua 5.3 compiled with LUA_COMPAT_5_2; 
                                        * ``luajit`` - globals of LuaJIT 2.0;
                                        * ``ngx_lua`` - globals of Openresty `lua-nginx-module <https://github.com/openresty/lua-nginx-module>`_ with LuaJIT 2.0;
                                        * ``rockspec`` - globals allowed in rockspecs;
                                        * ``min`` - intersection of globals of Lua 5.1, Lua 5.2, Lua 5.3 and LuaJIT 2.0;
                                        * ``max`` - union of globals of Lua 5.1, Lua 5.2, Lua 5.3 and LuaJIT 2.0;
                                        * ``busted`` - globals added by Busted 2.0;
                                        * ``none`` - no standard globals.

                                        See :ref:`stds`
``--globals [<global>] ...``            Add custom globals on top of standard ones.
``--read-globals [<global>] ...``       Add read-only globals.
``--new-globals [<global>] ...``        Set custom globals. Removes custom globals added previously.
``--new-read-globals [<global>] ...``   Set read-only globals. Removes read-only globals added previously.
``-c | --compat``                       Equivalent to ``--std max``.
``-d | --allow-defined``                Allow defining globals implicitly by setting them.

                                        See :ref:`implicitlydefinedglobals`
``-t | --allow-defined-top``            Allow defining globals implicitly by setting them in the top level scope.

                                        See :ref:`implicitlydefinedglobals`
``-m | --module``                       Limit visibility of implicitly defined globals to their files.

                                        See :ref:`modules`
``--ignore | -i <patt> [<patt>] ...``   Filter out warnings matching patterns.
``--enable | -e <patt> [<patt>] ...``   Do not filter out warnings matching patterns.
``--only | -o <patt> [<patt>] ...``     Filter out warnings not matching patterns.
``--no-inline``                         Disable inline options.
``--config <config>``                   Path to custom configuration file (default: ``.luacheckrc``).
``--no-config``                         Do not look up custom configuration file.
``--filename <filename>``               Use another filename in output, for selecting
                                        configuration overrides and for file filtering.
``--exclude-files <glob> [<glob>] ...`` Do not check files matching these globbing patterns. Recursive globs such as ``**/*.lua`` are supported.
``--include-files <glob> [<glob>] ...`` Do not check files not matching these globbing patterns.
``--cache [<cache>]``                   Path to cache file. (default: ``.luacheckcache``). See :ref:`cache`
``--no-cache``                          Do not use cache.
``-j | --jobs``                         Check ``<jobs>`` files in parallel. Requires `LuaLanes <http://cmr.github.io/lanes/>`_.
                                        Default number of jobs is set to number of available processing units.
``--formatter <formatter>``             Use custom formatter. ``<formatter>`` must be a module name or one of:

                                        * ``TAP`` - Test Anything Protocol formatter;
                                        * ``JUnit`` - JUnit XML formatter;
                                        * ``plain`` - simple warning-per-line formatter;
                                        * ``default`` - standard formatter.
``-q | --quiet``                        Suppress report output for files without warnings.

                                        * ``-qq`` - Suppress output of warnings.
                                        * ``-qqq`` - Only output summary.
``--codes``                             Show warning codes.
``--ranges``                            Show ranges of columns related to warnings.
``--no-color``                          Do not colorize output.
``-v | --version``                      Show version of Luacheck and its dependencies and exit.
``-h | --help``                         Show help and exit.
======================================= ================================================================================

.. _patterns:

Patterns
--------

CLI options ``--ignore``, ``--enable`` and ``--only`` and corresponding config options allow filtering warnings using pattern matching on warning codes, variable names or both. If a pattern contains a slash, the part before slash matches warning code and the part after matches variable name. Otherwise, if a pattern contains a letter or underscore, it matches variable name. Otherwise, it matches warning code. E.g.:

======= =========================================================================
Pattern Matching warnings
======= =========================================================================
4.2     Shadowing declarations of arguments or redefining them.
.*_     Warnings related to variables with ``_`` suffix.
4.2/.*_ Shadowing declarations of arguments with ``_`` suffix or redefining them.
======= =========================================================================

Unless already anchored, patterns matching variable names are anchored at both sides and patterns matching warning codes are anchored at their beginnings. This allows one to filter warnings by category (e.g. ``--only 1`` focuses ``luacheck`` on global-related warnings).

.. _stds:

Sets of standard globals
------------------------

CLI option ``--stds`` allows combining built-in sets described above using ``+``. For example, ``--std max`` is equivalent to ``--std=lua51+lua52+lua53``. Leading plus sign adds new sets to default one instead of replacing it. For instance, ``--std +busted`` is suitable for checking test files that use `Busted <http://olivinelabs.com/busted/>`_ testing framework. Custom sets of globals can be defined by mutating global variable ``stds`` in config. See :ref:`custom_stds`

Formatters
----------

CLI option ``--formatter`` allows selecting a custom formatter for ``luacheck`` output. A custom formatter is a Lua module returning a function with three arguments: report as returned by ``luacheck`` module (see :ref:`report`), array of file names and table of options. Options contain values assigned to ``quiet``, ``color``, ``limit``, ``codes``, ``ranges`` and ``formatter`` options in CLI or config. Formatter function must return a string.

.. _cache:

Caching
-------

If LuaFileSystem is available, Luacheck can cache results of checking files. On subsequent checks, only files which have changed since the last check will be rechecked, improving run time significantly. Changing options (e.g. defining additional globals) does not invalidate cache. Caching can be enabled by using ``--cache <cache>`` option or ``cache`` config option. Using ``--cache`` without an argument or setting ``cache`` config option to ``true`` sets ``.luacheckcache`` as the cache file. Note that ``--cache`` must be used every time ``luacheck`` is run, not on the first run only.

Stable interface for editor plugins and tools
---------------------------------------------

Command-line interface of Luacheck can change between minor releases. Starting from 0.11.0 version, the following interface is guaranteed at least till 1.0.0 version, and should be used by tools using Luacheck output, e.g. editor plugins.

* Luacheck should be started from the directory containing the checked file.
* File can be passed through stdin using ``-`` as argument or using a temporary file. Real filename should be passed using ``--filename`` option.
* Plain formatter should be used. It outputs one issue (warning or error) per line.
* To get precise error location, ``--ranges`` option can be used. Each line starts with real filename (passed using ``--filename``), followed by ``:<line>:<start_column>-<end_column>:``, where ``<line>`` is line number on which issue occurred and ``<start_column>-<end_column>`` is inclusive range of columns of token related to issue. Numbering starts from 1. If ``--ranges`` is not used, end column and dash is not printed.
* To get warning and error codes, ``--codes`` option can be used. For each line, substring between parentheses contains three digit issue code, prefixed with ``E`` for errors and ``W`` for warnings. Lack of such substring indicates a fatal error (e.g. I/O error).
* The rest of the line is warning message.

If compatibility with older Luacheck version is desired, output of ``luacheck --help`` can be used to get its version. If it contains string ``0.<minor>.<patch>``, where ``<minor>`` is at least 11 and ``patch`` is any number, interface described above should be used.
