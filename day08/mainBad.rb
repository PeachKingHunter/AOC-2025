require('ostruct')

# Open file
file = File.new('input.txt')

# Read lines
circuits = []
while file.pos < file.size
  line = file.readline.split ','

  junction = OpenStruct.new
  junction.x = line[0].to_i
  junction.y = line[1].to_i
  junction.z = (line[2].split "\n")[0].to_i

  circuits.append([junction])

  # print(line)
end
# print(circuits)

# Close file
file.close

# function
def getClosest(circuits)

  bestDist = 999999999
  index1 = 0
  index2 = 0

  for i in 0..(circuits.size - 1) do
    for j in (i+1)..(circuits.size - 1) do
      dist = getDistCircuits(circuits, i, j)
      if dist < bestDist then
        bestDist = dist
        index1 = i 
        index2 = j
          
        end
      end
  end
  return [index1, index2, bestDist]
end

def getDistCircuits(circuits, index1, index2)
  bestDist = 999999999999

  for junction1 in circuits[index1] do
    for junction2 in circuits[index2] do
      tmpX = (junction1.x - junction2.x)
      tmpY = (junction1.y - junction2.y)
      tmpZ = (junction1.z - junction2.z)
      # dist = tmpX + tmpY + tmpZ 
      dist = tmpX * tmpX + tmpY * tmpY + tmpZ * tmpZ
      if dist < bestDist then
        bestDist = dist
      end
    end
  end
  return bestDist
end

def mergeCircuits(circuits, index1, index2)
  for junction in circuits[index2] do 
  circuits[index1].append(junction)
  end
  circuits.delete(circuits[index2])
end

def linkCircuits(circuits, n)
  for i in 0.. n-2
    closest = getClosest(circuits)
    mergeCircuits(circuits, closest[0], closest[1])
  end
end

def displayCircuits(circuits)
  for i in circuits do
    print i
    print("\n")
  end
end

def countsBestsCircuits(circuits, n)
  lst = []
  for i in circuits do
    lst.append(i.size)
  end
  lst = lst.sort
  print lst
end

displayCircuits circuits
    print("\n")
linkCircuits(circuits, 0)
displayCircuits circuits

countsBestsCircuits(circuits, 2)
