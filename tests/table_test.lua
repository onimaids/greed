package.path = package.path .. ";../?.lua"
require("greed.table")

local t = {1, 2, {3, 4}}

-- print(table.format(t, " ", nil))

t = {0, 1, 2, 3, 5}
print("Table is: " .. table.format(t, " ", nil))

local new_t = table.map(t, function(v)
  return v + 1
end)

print("After map:")

table.foreach(new_t, function(v)
  print(string.format("value: %d", v))
end)

print("Filtered: ")
local filtered_t = table.filter(t, function (v)
  return v % 2 == 0
end)
print(table.format(filtered_t, " ", nil))

local new_t2 = table.filter(new_t, function (v)
  return v % 2 == 1
end)

print(
  string.format("mix between v %% 2 == 1 and v %% 2 == 0: %s",
    table.format(
      table.dmerge(new_t, new_t2),
      " "
    )
  )
)
