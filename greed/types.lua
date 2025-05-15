-- enum type
_G.enum = {}
setmetatable(enum, {
  __newindex = function()
    error("Enum is final.")
  end
})

--[[
  an enum is gonna look like:
  local <name> = makeenum("<name>", {
    [number] = [string]
  })
]]
function makeenum(typename, t)
  local instance = { __type = typename }

  for key, v in pairs(t) do
    -- make sure the enum index is a valid identifier
    if string.isalphanum(v) then
      error("Enum entry must be a Lua-valid identifier.")
    end

    instance[v] = key
  end

  setmetatable(instance, getmetatable(enum))
  return instance
end

-- array that holds all names
local registry = {}

function typeof(v)
  if type(v) ~= "table" then
    return type(v)
  elseif type(v) == "table" and v.__type ~= nil then
    return v.__type
  end
end

-- checks the class of a value
function instanceof(instance, class_name)
  return typeof(instance) == class_name
end

-- little class helper
function maketype(t, typename, index)
  -- sanitize input
  if typeof(typename) ~= "string" then
    error("String expected.")
  end

  if string.isalphanum(typename) then
    error("The class name must be a Lua-valid identifier.")
  end

  if table.contains(registry, typename) then
    error("A class with the same name alreadu exists.")
  end

  -- make the class skeleton
  table.insert(registry, typename)
  t.__type = typename
  t.__index = index
  setmetatable(t, {
    __newindex = function()
      error("Class is final.")
    end
  })

  return t
end
