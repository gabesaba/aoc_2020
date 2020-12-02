lines = readlines(stdin)

f = falses(2020)
for line in lines
    num = parse(Int32, line)
    rem = 2020 - num
    if f[num]
      println(rem * num)
      break
    end
    f[rem] = true
end
