require('ostruct')

# Open file
file = File.new('input2.txt')

# Read lines
lines = []
while file.pos < file.size
  line = file.readline.split ','

  junction = OpenStruct.new
  junction.x = line[0].to_i
  junction.y = line[1].to_i
  junction.z = (line[2].split "\n")[0].to_i

  lines.append(junction)
end

# Close file
file.close

# function
def isIn(linkToSkip, junc1, junc2)
  for i in linkToSkip do
    if i[0] == junc1 and i[1] == junc2 then
      return true 
    end
    if i[0] == junc2 and i[1] == junc1 then
      return true
    end
  end
  return false
end

def getClosest(lines, linkToSkip)

  bestDist = 99999999999
  index1 = 0
  index2 = 0

  for i in 0..(lines.size - 1) do
    for j in (i+1)..(lines.size - 1) do
      dist = getDistLines(lines, i, j)
      if dist < bestDist then
        if not isIn(linkToSkip, lines[i], lines[j]) then
          bestDist = dist
          index1 = i 
          index2 = j

        end
      end
    end
  end
  return [index1, index2, bestDist]
end

def getDistLines(lines, index1, index2)
  junction1 = lines[index1]
  junction2 = lines[index2]
  tmpX = (junction1.x - junction2.x)
  tmpY = (junction1.y - junction2.y)
  tmpZ = (junction1.z - junction2.z)
  # dist = tmpX + tmpY + tmpZ 
  dist = tmpX * tmpX + tmpY * tmpY + tmpZ * tmpZ

  return dist 
end

def mergeCircuits(circuits, index1, index2)
  for junction in circuits[index2] do 
  circuits[index1].append(junction)
  end
  circuits.delete(circuits[index2])
end


def addLink(circuits, junc1, junc2)
  lstFound1 = nil
  lstFound2 = nil
  for circ in circuits do
    for elem in circ do
      if elem == junc1 then
        lstFound1 = circ 
      end
      if elem == junc2 then
        lstFound2 = circ 
      end
    end
  end



  if lstFound1 == nil and lstFound2 == nil then
    circuits.append( [junc1, junc2] )
  else
    if lstFound1 == lstFound2 then
      return 
    end
    if lstFound1 == nil then
      lstFound2.append(junc1)
    else 
      if lstFound2 == nil then
        lstFound1.append(junc2)
      else
        for i in lstFound2 do
          lstFound1.append(i)
        end
        circuits.delete(lstFound2)

      end
    end
  end

end

def displayCircuits(circuits)
  for i in circuits do
    print i
    print("\n")
  end
end

def getLstCircuitsLen(circuits)
  res = []
  for i in circuits do
    res.append(i.size)
  end
  return res.sort
end

def linkAllNTimes (lines, linkSeen, circuits, n) 
  for i in 0..n-1 do
    print i
    print "\n"
    res = getClosest(lines, linkSeen)
    linkSeen.append([lines[res[0]], lines[res[1]]])
    addLink(circuits, lines[res[0]], lines[res[1]])
  end
end


circuits = []
linkSeen = []
linkAllNTimes(lines, linkSeen,circuits, 1000)
print(getLstCircuitsLen(circuits))
