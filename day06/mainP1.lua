-- Get operands
local file = io.open("inputOperands2.txt", "r")
io.input(file)
local operandsLine = io.read("l")
io.close()

local operandsStr = string.gmatch(operandsLine, "[^%s]+")
local operands = {}
local i = 1
for valStr in operandsStr do
	operands[i] = valStr
	i = i + 1
end

-- open numbers's file
file = io.open("inputNumbers2.txt", "r")
io.input(file)

local line = io.read("l")

-- Array for res
local res = {}
local nbNumbers = 1
for _ in string.gmatch(line, "[^%s]+") do
	res[nbNumbers] = 0
	nbNumbers = nbNumbers + 1
end

-- Loop on all lines
while line ~= nil do
	local operandNum = 1

	-- All number of the line
	local numbers = string.gmatch(line, "[^%s]+")
	for num in numbers do
		-- Add it to the result of this sub calcul
		if operands[operandNum] == "+" then
			res[operandNum] = res[operandNum] + num
		elseif operands[operandNum] == "*" then
			-- Default value to 1 if multiplication
			if res[operandNum] == 0 then
				res[operandNum] = 1
			end

			res[operandNum] = res[operandNum] * num
		end

		operandNum = operandNum + 1
	end

	line = io.read("l")
end

-- Close the file
io.close()

-- Print res
for i = 1, nbNumbers - 1 do
	print(res[i])
end

local resSum = 0
for i in pairs(res) do
	resSum = resSum + res[i]
end

print("-> " .. resSum)
