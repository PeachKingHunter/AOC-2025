-------------------
------ PARSE ------
-------------------

-- Get operands
local file = io.open("inputOperands2.txt", "r")
io.input(file)
local operandsLine = string.reverse(io.read("l"))
io.close()

-- Put operands in an array
local operandsStr = string.gmatch(operandsLine, "[^%s]+")
local operands = {}
local i = 1
for valStr in operandsStr do
	operands[i] = valStr
	i = i + 1
end

-- Open numbers's file
file = io.open("inputNumbers2.txt", "r")
io.input(file)

-- Varaibles for store lines
local lines = {}
local index = 1

-- Store all lines
local line = io.read("l")
while line ~= nil do
	lines[index] = string.reverse(line)
	line = io.read("l")
	index = index + 1
end

-- Close the file
io.close()

--------------------
------ Calcul ------
--------------------

-- Variables for loop
local indexOperand = 1
local res = 0
local tmpRes = 0

-- Default value of the tmpRes
if operands[indexOperand] == "+" then
	tmpRes = 0
elseif operands[indexOperand] == "*" then
	tmpRes = 1
end

-- Loop on all columns
for x = 1, #lines[1] do
	-- Test: Do we change calcul (all are space on the column)
	isAllEmpty = true
	for y = 1, #lines do
		local character = string.sub(lines[y], x, x)
		if character ~= " " then
			isAllEmpty = false
		end
	end

	-- We change to an other calcul
	if isAllEmpty == true then
		res = res + tmpRes

		indexOperand = indexOperand + 1
		if operands[indexOperand] == "+" then
			tmpRes = 0
		elseif operands[indexOperand] == "*" then
			tmpRes = 1
		end

		print()
		goto continue
	end

	-- Get the number of the column x
	local str = ""
	for y = 1, #lines do
		local character = string.sub(lines[y], x, x)
		if character ~= " " then
			str = str .. character
		end
	end
	-- print(str)

	-- Add the number to the tmpRes
	if operands[indexOperand] == "+" then
		tmpRes = tmpRes + str
	elseif operands[indexOperand] == "*" then
		tmpRes = tmpRes * str
	end
	print(tmpRes)

	::continue::
end

-- Add the last number not added
res = res + tmpRes

-- Print the result
print("-> " .. res)
