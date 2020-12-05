function map_digit(digit)
  if digit == 'B' || digit == 'R'
    return '1'
  else
    return '0'
  end
end

function get_binary(pass, i, j)
  binary = map(map_digit, pass[i:j])
  return parse(Int32, binary, base = 2)
end

function get_row(pass)
  return get_binary(pass, 1, 7)
end

function get_col(pass)
  return get_binary(pass, 8, 10)
end

function get_seat(pass)
  return 8 * get_row(pass) + get_col(pass)
end

function find_missing_seat(lines)
  seats = sort(map(get_seat, lines))
  prev = seats[1] - 1
  for seat in seats
    if prev != seat - 1
      return seat - 1
    end
    prev = seat
  end
  return -1
end

lines = readlines(stdin)

# Part 1
println(maximum(map(get_seat, lines)))

# Part 2
println(find_missing_seat(lines))
