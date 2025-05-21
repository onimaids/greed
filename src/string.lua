function string.isalphanum(s)
  return (string.match(s, "^[%w_]+$") == true) and true or false
end

function string.split(s, sep)
  local t = {}

  for sstr in string.gmatch(s, "([^" .. sep .. "]+)") do
    table.insert(t, sstr)
  end

  return t
end

function string.startswith(s, letter)
  return string.sub(s, 1, 1) == letter
end

function string.endswith(s, letter)
  return string.sub(s, #s, #s) == letter
end

function string.trim(s)
  return string.match(s, "^%s*(.-)%s*$")
end
