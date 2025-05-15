require("greed.string")

-- if depth is nil then depth doesnt matter
--
function _G.table.contains(t, value, depth)
  for _, tv in pairs(t) do
    -- the disuse of greed's own typeof() function
-- is intentional
    if type(tv) == "table" and depth ~= 0 then
      local res = table.contains(tv, value, type(depth) == "number" and depth - 1 or depth)
      if res then return true end
    end

    if tv == value then return true end
  end

  return false
end

function _G.table.deepcopy(t)
  local o = {}

  for i, v in pairs(t) do
    if type(v) == "table" then
      o[i] = table.deepcopy(v)
      goto continue
    end

    o[i] = v
    ::continue::
  end

  return o
end

function _G.table.format(t, depth, sep)
  -- indent spaces for formatting
  local current_indent = string.rep(sep, depth == nil and 0 or depth)
  local subtable_indent = string.rep(tostring(sep), (depth == nil) and 1 or depth + 1)

  local fmt = string.rep(sep, depth == nil and 0 or depth) ..  "{\n"

  for k, v in pairs(t) do
    if type(v) == "table" and (type(depth) ~= "nil" and depth - 1 ~= 0 or true) then
      fmt = fmt .. subtable_indent .. string.format("[%s] = ", k) .. table.format(v, (depth == nil) and 1 or depth + 1, sep)
      goto continue
    end

    fmt = fmt .. subtable_indent .. string.format("[%s] = %s,\n", k, v)
    ::continue::
  end

  fmt = fmt .. current_indent ..  "}\n"
  return fmt
end
