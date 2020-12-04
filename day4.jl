function parse_passports(lines)
  passports = Vector()
  passport = Vector()
  for line in lines
    if line == ""
      push!(passports, passport)
      passport = Vector()
    else
      keyvals = split(line, ' ')
      for keyval in keyvals
        key, val = split(keyval, ":")
        push!(passport, (key, val))
      end
    end
  end
  if length(passport) != 0
    push!(passports, passport)
  end
  return passports
end


function is_valid(passport, required, vs)
  fields = Set(map(x->x[1], passport))
  return length(intersect(fields, required)) == 7 &&
    count(field -> any(v -> v(field), vs), passport) == length(passport)
end

function make_validation(key, logic)
  return function validate(field)
    return key == field[1] && logic(field[2])
  end
end

function make_validations()
  v = Vector()

  year_regex = Regex("^[0-9]{4}\$")
  height_regex = Regex("^([0-9]+)(cm|in)\$")
  hair_regex = Regex("^#[0-9a-f]{6}\$")
  eye_colors = Vector(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
  pid_regex = Regex("^[0-9]{9}\$")

  push!(v, make_validation("byr", function(val)
    return occursin(year_regex, val) && 1920 <= parse(Int, val) <= 2002
  end))
  push!(v, make_validation("iyr", function(val)
    return occursin(year_regex, val) && 2010 <= parse(Int, val) <= 2020
  end))
  push!(v, make_validation("eyr", function(val)
    return occursin(year_regex, val) && 2020 <= parse(Int, val) <= 2030
  end))
  push!(v, make_validation("hgt", function(val)
    m = match(height_regex, val)
    if m == nothing
      return false
    end

    num, unit = parse(Int, m.captures[1]), m.captures[2]
    return (unit == "cm" && 150 <= num <= 193) ||
      (unit == "in" && 59 <= num <= 76)
  end))
  push!(v, make_validation("hcl", function(val)
    return occursin(hair_regex, val)
  end))
  push!(v, make_validation("ecl", function(val)
    return val in eye_colors
  end))
  push!(v, make_validation("pid", function(val)
    return occursin(pid_regex, val)
  end))
  push!(v, make_validation("cid", function(val)
    return true
  end))
  return v

end

function main(lines, required, validations)
  passports = parse_passports(lines)
  return count(
      map(passport -> is_valid(passport, required, validations), passports))
end


lines = readlines(stdin)
required = Set(["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"])

# Part 1
println(main(lines, required, [(x) -> true]))

# Part 2
validations = make_validations()
println(main(lines, required, validations))
