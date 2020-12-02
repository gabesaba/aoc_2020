lines = readlines(stdin)
nums = map((x) -> parse(Int32, x), lines)
twos = Array{Tuple{Int32, Int32}}(undef, 2020)
fill!(twos, (0, 0))

for (i, x1) in enumerate(nums)
  for x2 in view(nums, i+1:length(nums))
    if (x1 + x2) < 2020
      twos[x1 + x2] = (x1, x2)
    end
  end
end

for x3 in nums
  rem = 2020 - x3
  (x1, x2) = twos[rem]
  if (x1 + x2 + x3) == 2020
    println(x1 * x2 * x3)
    break
  end
end
