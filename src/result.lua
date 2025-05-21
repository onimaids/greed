require("greed.table")
require("greed.types")

local ok_value = true
local err_value = nil

result = {
  __type = "result", -- for *and* from require("types")

  __result_type = nil, -- default value
  __result = nil, -- default value
}

-- METAMETHODS

local mt = {
  __tostring = function(r)
    -- gives the result's type name represtation when referencing the result type construct
    if r.__type == "result" then
      return r:is_ok() and "Ok" or "Err"
    end
  end,

  -- checks for the result types
  __eq = function(r, other)
    return r.__result_type == other.__result_type
  end,

  __newindex = function()
    error("You cannot add new values to the result table.")
  end
}

-- visible methods
mt.__index = {
  is_ok = function (r)
    return r.__result_type == ok_value
  end,

  is_err = function (r)
    return r.__result_type == err_value
  end,

  unwrap = function (r)
    if r.__result_type == err_value then
      error("Result error!")
    end

    return r.__result
  end,

  unwrap_or = function (r, default)
    return r.__result_type == ok_value and r.__result or default
  end,

  expect = function (r, msg)
    if r.__result_type == err_value then
      error(msg)
    end

    return r.__result
  end,
}

-- CONSTRUCTORS

function Ok(v)
  local o = {
    __result_type = ok_value,
    __result = v
  }

  setmetatable(o, mt)
  return o
end

function Err(e)
  local o = {
    __result_type = err_value,
    __result = e
  }

  setmetatable(o, mt)
  return o
end

-- WRAPPERS FOR THE STANDARD LIB

-- only valid for functions that return a value when everything
-- is fine or nil when an error occured
function toresult(func, ...)
  local ok, res = pcall(func, ...)
  return ok and Ok(res) or Err(res)
end

-- function toresult_direct(res, errmsg)
--   if res == nil then
--     return Err(errmsg)
--   end
--
--   return Ok(res)
-- end
