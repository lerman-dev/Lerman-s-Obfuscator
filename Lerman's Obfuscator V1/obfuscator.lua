print("--//Made with Lerman's Obfuscator\\--")

-- Initialize random seed
math.randomseed(os.time())

function obfuscate(script, options)
    -- Default options
    options = options or {}
    local rename_vars = options.rename_vars ~= false
    local encrypt_strings = options.encrypt_strings ~= false
    local add_junk = options.add_junk or true
    local minify = options.minify or true
    local scramble = options.scramble or true

    -- Check for empty script
    if not script or script == "" then
        return "Error: Empty script provided."
    end

    -- Generate random variable names
    local function generateRandomName()
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local prefix = "v" .. chars:sub(math.random(1, #chars), math.random(1, #chars))
        return prefix .. math.random(1000000, 9999999)
    end

    -- Encode string into array of numbers (ASCII codes)
    local function encodeString(str)
        local result = {}
        for i = 1, #str do
            local byte = string.byte(str:sub(i, i))
            table.insert(result, byte)
        end
        -- Add some random numbers as junk
        for _ = 1, math.random(1, 3) do
            table.insert(result, math.random(0, 255))
        end
        return "{" .. table.concat(result, ",") .. "}"
    end

    -- Add minimal junk code
    local function addJunkCode(script)
        local junk = {}
        for _ = 1, math.random(1, 2) do
            local var1 = generateRandomName()
            local var2 = generateRandomName()
            local junkCode = string.format("local %s = %d local %s = %d %s = %s + %d",
                var1, math.random(1, 50), var2, math.random(1, 50), var1, var2, math.random(1, 20))
            table.insert(junk, junkCode)
        end
        local lines = {}
        for line in (script .. "\n"):gmatch("(.-)\n") do
            if line ~= "" then
                table.insert(lines, line)
            end
        end
        for _, j in ipairs(junk) do
            local insert_pos = math.random(1, #lines + 1)
            table.insert(lines, insert_pos, j)
        end
        return table.concat(lines, "\n")
    end

    -- Minify code (remove extra spaces and newlines)
    local function minifyCode(script)
        return script:gsub("%s+", " "):gsub("[\n\r]+", " ")
    end

    -- Scramble lines (with dependency handling)
    local function scrambleLines(script)
        local lines = {}
        local decodeLine = nil
        for line in (script .. "\n"):gmatch("(.-)\n") do
            if line ~= "" then
                if line:find("decodeString") and line:find("function") then
                    decodeLine = line
                else
                    table.insert(lines, line)
                end
            end
        end
        for i = #lines, 2, -1 do
            local j = math.random(1, i)
            lines[i], lines[j] = lines[j], lines[i]
        end
        if decodeLine then
            table.insert(lines, 1, decodeLine)
        end
        return table.concat(lines, "\n")
    end

    -- Add branding comments
    local function addBranding(script)
        local lines = {}
        for line in (script .. "\n"):gmatch("(.-)\n") do
            if line ~= "" then
                table.insert(lines, line)
            end
        end
        local num_comments = math.random(3, 6)
        for _ = 1, num_comments do
            local insert_pos = math.random(1, #lines + 1)
            table.insert(lines, insert_pos, "-- Lerman's Obfuscator")
        end
        return table.concat(lines, "\n")
    end

    -- Rename variables and handle strings
    local stringVars = {}
    if rename_vars then
        local renamedVars = {}
        script = script:gsub('"(.-)"', function(str)
            local varName = generateRandomName()
            stringVars[varName] = str
            return varName
        end)
        script = script:gsub("%f[%a_](%w+)%f[^%w_]", function(var)
            if var == "print" or var == "math" or var == "string" then return var end
            if stringVars[var] then return var end
            if not renamedVars[var] then
                renamedVars[var] = generateRandomName()
            end
            return renamedVars[var]
        end)
    end

    -- Obfuscate strings
    if encrypt_strings then
        for varName, str in pairs(stringVars) do
            local encoded = encodeString(str)
            script = "local " .. varName .. " = decodeString(" .. encoded .. ")\n" .. script
        end
    end

    -- Add junk code
    if add_junk then
        script = addJunkCode(script)
    end

    -- Add decoding function
    if encrypt_strings then
        script = [[
            local function decodeString(tbl)
                local result = ""
                for i = 1, #tbl do
                    local byte = tbl[i]
                    if byte >= 32 and byte <= 126 then
                        result = result .. string.char(byte)
                    end
                end
                return result
            end
        ]] .. "\n" .. script
    end

    -- Minify
    if minify then
        script = minifyCode(script)
    end

    -- Scramble lines
    if scramble then
        script = scrambleLines(script)
    end

    -- Add fake functions
    local fake_funcs = {}
    for _ = 1, math.random(2, 4) do
        local func_name = generateRandomName()
        table.insert(fake_funcs, string.format("function %s() return math.random(1, 1000) end", func_name))
    end
    script = table.concat(fake_funcs, "\n") .. "\n" .. script

    -- Add branding
    script = addBranding(script)

    return script
end

-- Read script from script.lua
local filename = "script.lua"
local file = io.open(filename, "r")
if not file then
    print("Error: script.lua not found in the current directory.")
    return
end

local inputScript = file:read("*all")
file:close()

if inputScript == "" then
    print("Error: script.lua is empty.")
    return
end

-- Read command-line arguments for options
local args = {...}
local options = {
    rename_vars = true,
    encrypt_strings = true,
    add_junk = args[1] ~= "nojunk" and args[2] ~= "nojunk" and args[3] ~= "nojunk",
    minify = args[1] ~= "nominify" and args[2] ~= "nominify" and args[3] ~= "nominify",
    scramble = args[1] ~= "noscramble" and args[2] ~= "noscramble" and args[3] ~= "noscramble"
}

-- Obfuscate
print("\nYour obfuscated script:")
print("-----------------------------")
local success, obfuscatedScript = pcall(obfuscate, inputScript, options)
if success then
    print(obfuscatedScript)
else
    print("Error during obfuscation: " .. obfuscatedScript)
end
print("-----------------------------")
print("Copy the code above and use it!")