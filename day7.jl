lhs = Regex("([a-z ]*) bags")
rhs = Regex("([0-9]+) ([a-z ]*) bags?")

function matchline(line)
  return match(lhs, line).captures[1], map(x -> (x.captures[2], parse(Int, x.captures[1])), eachmatch(rhs, line))
end

function insert1!(dict, outer, inners)
  for inner in inners
    inner = inner[1]
    lst = get(dict, inner, Set())
    push!(lst, outer)
    dict[inner] = lst
  end
end

function insert2!(dict, outer, inners)
  dict[outer] = inners
end

function makegraphs(matches)
  graph1 = Dict()
  graph2 = Dict()
  for match in filter(x -> length(x[2]) > 0, matches)
    insert1!(graph1, match[1], match[2])
    insert2!(graph2, match[1], match[2])
  end
  return graph1, graph2
end


function traverse(graph, innerbag, seen)
  for outerbag in get(graph, innerbag, [])
    if !(outerbag in seen)
      push!(seen, outerbag)
      traverse(graph, outerbag, seen)
    end
  end
  return seen
end

function part1(graph, bag)
  return length(traverse(graph, bag, Set()))
end


function part2(graph, bag)
 cost = 0
 for content in get(graph, bag, [])
   cost += content[2] + content[2] * part2(graph, content[1])
 end
 return cost
end

lines = readlines(stdin)
matches = map(matchline, lines)
graph1, graph2 = makegraphs(matches)
println("Part 1: ", part1(graph1, "shiny gold"))
println("Part 2: ", part2(graph2, "shiny gold"))
