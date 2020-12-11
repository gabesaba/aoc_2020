function parseline(line)
  s = split(line, " ")
  return s[1], parse(Int, s[2])
end

function apply(cmd, line, counter, flip = false)
  (op, num) = cmd
  if op == "acc"
    counter += num
  elseif (op == "nop" && flip) || (op == "jmp" && !flip)
    line += num - 1
  end
  return line + 1, counter
end


function part1(cmds)
  line = 1
  counter = 0
  seen = Set()
  while !(line in seen)
    push!(seen, line)
    line, counter = apply(cmds[line], line, counter)
  end
  return counter
end

function part2(cmds, line, counter, states = Set(), flip_remaining = true)
  if line == length(cmds) + 1
    return counter
  end

  state = (line, flip_remaining)
  if state in states
    return nothing
  end
  push!(states, state)

  if flip_remaining
      newline, newcounter = apply(cmds[line], line, counter, true)
      res = part2(cmds, newline, newcounter, states, false)
      if res != nothing
        return res
      end
   end

  newline, newcounter = apply(cmds[line], line, counter)
  return part2(cmds, newline, newcounter, states, flip_remaining)

end

cmds = map(parseline, readlines(stdin))

println("Part 1: ", part1(cmds))
println("Part 2: ", part2(cmds, 1, 0))
