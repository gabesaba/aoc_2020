function part1(nums)
  diffs = zeros(Int, 3)
  jolts = nums[1]
  for num in Iterators.drop(nums, 1)
    diff = num - jolts
    diffs[diff] += 1
    jolts = num
  end
  return diffs[1] * diffs[3]
end

function part2(nums, i, memo)
  curr_num = nums[i]
  if haskey(memo, curr_num)
    return memo[curr_num]
  end
  if i == length(nums)
    return 1
  end

  ways = 0
  for j in i+1:i+3
    if j <= length(nums) && (nums[j] - curr_num) <= 3
      ways += part2(nums, j, memo)
    end
  end
  memo[curr_num] = ways
  return ways
end

nums = sort(map(x -> parse(Int, x), readlines(stdin)))

# Insert outlet
insert!(nums, 1, 0)

# Connect device
push!(nums, nums[length(nums)] + 3)

println("Part 1: ", part1(nums))
println("Part 2: ", part2(nums, 1, Dict()))
