function main(lines)
  regex = Regex("([0-9]+)-([0-9]+) ([a-z]): ([a-z]*)")
  valid_ct = 0

  for line in lines
    matches = match(regex, line).captures
    min_index = parse(Int32, matches[1])
    max_index = parse(Int32, matches[2])
    must_contain = matches[3][1]
    s = matches[4]
    if xor(s[min_index] == must_contain, s[max_index] == must_contain)
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
