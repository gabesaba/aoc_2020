lines = readlines(stdin)
nums = map((x) -> parse(Int32, x), lines)
twos = Dict()

for (i, x1) in enumerate(nums)
  for x2 in view(nums, i+1:length(nums))
    twos[x1 + x2] = (x1, x2)
  end
end

for x3 in nums
  rem = 2020 - x3
  if haskey(twos, rem)
    (x1, x2) = twos[rem]
    if x1 != x3 && x2 != x3
      println(x1 * x2 * x3)
      break
    end
  end
end
