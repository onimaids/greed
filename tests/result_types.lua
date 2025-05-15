package.path = package.path .. ";../?.lua"
require("greed.table")
require("greed.result")

local function is_string(v)
  if type(v) == "string" then
    return Ok(v)
  end

  return Err("Not a string")
end

local res = is_string("2")
local res2 = is_string(2)

-- checks "IS OK: " .. tostring(res:is_ok()) .. ", RESULT: " .. res:get_result()
assert(("IS OK: " .. tostring(res:is_ok()) .. ", RESULT: " .. res:get_result()) == "IS OK: true, RESULT: 2")
print("Test 1 passed")
assert(("IS OK: " .. tostring(res2:is_ok()) .. ", RESULT: " .. res2:get_result()) == "IS OK: false, RESULT: Not a string")
print("Test 2 passed")
