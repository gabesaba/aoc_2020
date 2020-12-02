function main(lines)
  regex = Regex("([0-9]+)-([0-9]+) ([a-z]): ([a-z]*)")
  valid_ct = 0

  for line in lines
    matches = match(regex, line).captures
    min_ct = parse(Int32, matches[1])
    max_ct = parse(Int32, matches[2])
    must_contain = matches[3][1]
    s = matches[4]
    ct = count(x -> (x == must_contain), s)
    if ct <= max_ct && ct >= min_ct
      valid_ct += 1
    end
  end
  return valid_ct
end

lines = readlines(stdin)
println(main(lines))
@time main(lines)
@time main(lines)
@time main(lines)
@time main(lines)
@time main(lines)
