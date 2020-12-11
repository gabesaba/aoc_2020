function sumsgud(prev, curr)
  f = Vector()
  for num in prev
      rem = curr - num
      if num in f
        return true
      end
      push!(f, rem)
  end
  return false
end

function part1(nums, preamble)
  start = preamble + 1

  while start <= length(nums)
    i, j = start - preamble, start - 1
    num = nums[start]
    if !sumsgud(view(nums, i:j), num)
      return num
    end
    start += 1
  end
end

function part2(nums, ans)
  for i in 1:length(nums)
    for j in i+1:length(nums)
      scenery = view(nums, i:j)
      if sum(scenery) == ans
        return minimum(scenery) + maximum(scenery)
      end
    end
  end
end


nums = map(x -> parse(Int, x), readlines(stdin))

ans = part1(nums, 25)
println("Part 1: ", ans)

println("Part 2", part2(nums, ans))
