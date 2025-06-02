return function(data)
    local function reverse_string(s)
        local reversed = {}
        for i = #s, 1, -1 do
            reversed[#reversed+1] = s:sub(i,i)
        end
        return table.concat(reversed)
    end

    local function permute_blocks(s, block_size)
        block_size = block_size or 5
        local blocks = {}
        for i = 1, #s, block_size do
            blocks[#blocks+1] = s:sub(i, i + block_size - 1)
        end
        -- обратная перестановка: переворачиваем порядок блоков обратно
        local reversed_blocks = {}
        for i = #blocks, 1, -1 do
            reversed_blocks[#reversed_blocks+1] = blocks[i]
        end
        return table.concat(reversed_blocks)
    end

    local function ascii_unshift(s, shift)
        shift = shift or 7
        local chars = {}
        for i = 1, #s do
            local byte = string.byte(s, i)
            byte = (byte - shift) % 256
            chars[i] = string.char(byte)
        end
        return table.concat(chars)
    end

    -- обратный порядок операций
    local unshifted = ascii_unshift(data, 7)
    local unpermuted = permute_blocks(unshifted, 5)
    local original = reverse_string(unpermuted)

    return original
end
