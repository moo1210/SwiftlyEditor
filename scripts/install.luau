local process = require("@lune/process")
local stdio = require("@lune/stdio")

local workingDir = process.cwd

-- TODO: Lune should probably provide a way to get the current scripts path, make a PR.
if workingDir:sub(#workingDir-8):gsub("\\", "/"):match("/scripts/") then
    stdio.write(stdio.color("red"))
    print("Please run this script from the root of the project, not from the scripts directory.")
    stdio.write(stdio.color("reset"))
    process.exit(1)
end

local function runCommand(program: string, args: {}, options: {})
    if not args then
        args = {}
    end
    local result = process.spawn(program, args, {stdio = "inherit"})
    if not result.ok then
        stdio.write(stdio.color("red"))
        print("Failed to run command: " .. program, table.concat(args, " "))
        stdio.write(stdio.color("reset"))
        process.exit(1)
    end
end