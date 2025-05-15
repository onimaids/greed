-- custom type function that adds support for
-- custom type names for tables

function typeof(v)
  if type(v) ~= "table" then
    return type(v)
  elseif type(v) == "table" and v.__type ~= nil then
    return v.__type
  end
end

function make_type(t, typename)
  if type(typename) ~= "string" then
    error("String expected.")
  end

  t.__type = typename
end
