function string.isalphanum(s)
  return (string.match(s, "^[%w_]+$") == true) and true or false
end
