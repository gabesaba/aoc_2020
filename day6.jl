function make_groups(lines)
  groups = Vector()
  people = Vector()
  function cut()
    if length(people) != 0
      push!(groups, people)
      people = Vector()
    end
  end

  for line in lines
    if line == ""
      cut()
    else
        push!(people, line)
    end
  end
  cut()
  return groups
end

function count_letters(group)
  letters = Set()
  for line in group
    for letter in line
      push!(letters, letter)
    end
  end
  return length(letters)
end

function count_letters2(group)
  letters = Dict()
  for line in group

    for letter in line
      prev = get(letters, letter, 0)
      letters[letter] = prev + 1
    end
  end
  ct = 0
  for val in values(letters)
    if val == length(group)
      ct += 1
    end
  end
  return ct
end

groups = make_groups(readlines(stdin))

println(sum(map(count_letters, groups)))

println(sum(map(count_letters2, groups)))
