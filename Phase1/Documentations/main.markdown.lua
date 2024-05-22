local ran_ok, error = pcall(function() local ran_ok, kpse = pcall(require, "kpse") if ran_ok then kpse.set_program_name("luatex") end local lfs = require("lfs") local cacheDir = "./_markdown_main" if not lfs.isdir(cacheDir) then assert(lfs.mkdir(cacheDir)) end local md = require("markdown") local convert = md.new({cacheDir = "./_markdown_main", frozenCacheFileName = "./_markdown_main/frozenCache.tex", }) local file = assert(io.open("./main.markdown.in", "r"), [[could not open file "./main.markdown.in" for reading]]) local input = assert(file:read("*a")) assert(file:close()) print(convert(input:gsub("\r\n?", "\n") .. "\n")) end) if not ran_ok then local file = io.open("./main.markdown.err", "w") if file then file:write(error .. "\n") file:close() end print('\\markdownError{An error was encountered while executing Lua code}{For further clues, examine the file "./main.markdown.err"}') end
