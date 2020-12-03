function add(t1, t2)
  x, y = t1
  dx, dy = t2
  return (x+dx, y+dy)
end

function get(map, coordinates)
  x, y = coordinates
  x1 = ((x - 1) % length(map[y])) + 1
  return map[y][x1]
end

function main(map, offset)
  coordinate = (1, 1)
  tree_ct = 0
  while coordinate[2] <= length(map)
    loc = get(map, coordinate)
    if (loc == '#')
      tree_ct += 1
    end
    coordinate = add(coordinate, offset)
  end
  return tree_ct
end

lines = readlines(stdin)

# Part 1
println(main(lines, (3, 1)))

# Part 2
slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
trees = map(x -> main(lines, x), slopes)
println(reduce(*, trees))
