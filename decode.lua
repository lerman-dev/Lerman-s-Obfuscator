return function(data)
    local decoded = {}
    for i = 1, #data do
        decoded[i] = string.char(data[i] - 3)
    end
    local str = table.concat(decoded)
    local f = loadstring(str)
    if f then
        return f()
    end
end
