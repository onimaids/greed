package.path = package.path .. ";../?.lua"
require("greed.table")

local t = {1, 2, {3, 4}}
assert(table.contains(t, 4) == true)
print("Test 1 passed.")

assert(table.deepcopy(t) ~= t)
for i, v in ipairs(t) do
  assert(v == t[i])
end
print("Test 2 passed.")

print(table.format(t, nil, " "))
