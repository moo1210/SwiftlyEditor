-- Helper table for requiring packages from various sources

local root = script.Parent
local packageDirs = {"Packages","External/StudioBuiltins"}
function fetchPackageModule(name)
    for _, dirString in ipairs(packageDirs) do
        local dir = root
        local dirs = string.split(dirString,"/")
        for _, childDir in ipairs(dirs) do
            dir = dir[childDir]
        end
        local foundPkg = dir:FindFirstChild(name)

        if foundPkg then
            return foundPkg
        end
    end
end

return setmetatable({},
{
    __call = function(table, name)
        local module = fetchPackageModule(name)
        if module then
            return require(module)
        else
            error(`Package ${name} does not exist!`)
        end
    end})