require("greed.string")

-- if depth is nil then depth doesnt matter
function table.contains(t, value, depth)
  for _, tv in pairs(t) do
    -- the disuse of greed's own typeof() function
    -- is intentional
    if type(tv) == "table" and (type(depth) == "number" and depth ~= 0) then
      local res = table.contains(tv, value, (type(depth) == "number") and depth - 1 or 0)
      if res then return true end
    end

    if tv == value then return true end
  end

  return false
end

-- makes a deep table copy
function table.copy(t)
  local o = {}

  for i, v in pairs(t) do
    if type(v) == "table" then
      o[i] = table.copy(v)
      goto continue
    end

    o[i] = v
    ::continue::
  end

  setmetatable(o, getmetatable(t))
  return o
end

function table.format(t, sep, depth)
  local acc_depth = (depth == nil) and 0 or depth

  -- indent spaces for formatting
  local current_indent = string.rep(sep, acc_depth)
  local subtable_indent = string.rep(sep, acc_depth + 1)

  local fmt = string.rep(sep, acc_depth) ..  "{\n"

  for k, v in pairs(t) do
    if type(v) == "table" and (type(depth) == "number" and depth > 0) then
      fmt = fmt
        .. subtable_indent
        .. string.format("[%s] = ", k)
        .. table.format(v, (depth == nil) and 1 or depth + 1, sep)

      goto continue
    end

    fmt = fmt .. subtable_indent .. string.format("[%s] = %s,\n", k, v)
    ::continue::
  end

  fmt = fmt .. current_indent ..  "}\n"
  return fmt
end

function table.foreach(t, func, iter)
  iter = (iter == nil) and pairs or iter

  for _, v in iter(t) do
    func(v)
  end
end

function table.map(t, func, iter)
  iter = (iter == nil) and pairs or iter
  local new_t = {}

  for key, v in iter(t) do
    new_t[key] = func(v)
  end

  setmetatable(new_t, getmetatable(t))
  return new_t
end

function table.filter(t, pred, iter)
  iter = (iter == nil) and pairs or iter
  local filtered_t = {}

  for key, v in iter(t) do
    if pred(v) then filtered_t[key] = v end
  end

  return filtered_t
end

-- still WIP a bit
function table.dmerge(t1, t2, mt, iter)
  iter = (iter == nil) and pairs or iter

  local new_t = table.copy(t1)
  for key, v in iter(t2) do
    if type(v) == "table" then
      v = table.copy(v)
    end

    new_t[key] = v
  end

  if mt ~= nil then setmetatable(new_t, mt) end
  return new_t
end

function table.smerge(t1, t2, iter)
  iter = (iter == nil) and pairs or iter

  -- true content
  local new_t = table.copy(t1)

  for key, v in iter(t2) do
    new_t[key] = v
  end

  return new_t
end

-- returns the first occurence, index and key
function table.find(t, pred, iter)
  iter = (iter == nil) and pairs or iter

  for i, v in iter(t) do
    if pred(v) == true then return i, v end
  end
end

function table.getkeys(t)
  local keys = {}

  for key in pairs(t) do
    table.insert(keys, key)
  end

  return keys
end

function table.getvalues(t)
  local values = {}

  for _, value in pairs(t) do
    table.insert(values, value)
  end

  return values
end

function table.equals(t1, t2)
  if t1 == t2 then return true end

  if type(t1) ~= "table" or type(t2) ~= "table" then
    return false
  end

  for k, v in pairs(t1) do
    if not table.equals(v, t2[k]) then
      return false
    end
  end

  for k in pairs(t2) do
    if t1[k] == nil then
      return false
    end
  end

  return true
end
