return function(data)
    local func = loadstring(data:gsub("\\(%d+)", function(n)
        return string.char(tonumber(n))
    end))
    if func then func() end
end
