-- The MIT License (MIT)
--
-- Copyright (c) 2022 ds1sqe
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local M = {}

-- @arg setting => table to config shortcut.
-- setting = {
-- 	upperCaseShortCut = "<space>guu",
-- 	lowerCaseShortCut = "<space>gul",
-- }
function M.config(setting)
	local config = {
		upperCaseShortCut = "<space>guu",
		lowerCaseShortCut = "<space>gul",
	}

	vim.tbl_extend("force", config, setting)

	vim.keymap.set("n", config.upperCaseShortCut, "i" + M.create(true), {
		expr = true,
		desc = "GUID Upper",
	})
	vim.keymap.set("n", config.lowerCaseShortCut, "i" + M.create(false), {
		expr = true,
		desc = "GUID Lower",
	})
end
--
-- opt is boolean to create uuid, true to uppercase
-- false to lowercase
-- returns string
function M.create(opt)
	local rB = M.randomByteString
	local str = "{"
	local i = 1
	while i <= 16 do
		str = str .. rB(opt)
		if (i == 4) or (i == 6) or (i == 8) then
			str = str .. "-"
		end
		i = i + 1
	end
	str = str .. "}"
	return str
end

function M.intToHex(int, case)
	local hexString, base = "", 16
	local digit
	local hexes = "0123456789abcdef"
	if case == true then
		hexes = "0123456789ABCDEF"
	end
	while int > 0 do
		digit = int % base + 1
		int = math.floor(int / base)
		hexString = string.sub(hexes, digit, digit) .. hexString
	end
	while #hexString < 2 do
		hexString = "0" .. hexString
	end
	return hexString
end

function M.randomByte()
	return math.random(0, 255)
end

function M.randomByteString(opts)
	return M.intToHex(M.randomByte(), opts)
end

return M
