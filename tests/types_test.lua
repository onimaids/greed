package.path = package.path .. ";../?.lua"
require("greed.types")
require("greed.table")

local Car = {}

function Car:new(brand, year)
  local instance = maketype(self, "Car", { brand = brand, year = year })
  -- setmetatable(instance, self)
  instance.new = nil
  return instance
end

function Car:get_info()
  print(string.format("%s: %s", self.brand, self.year))
end

local x = Car:new("lamb", 2025)
x:get_info()
print(x.brand)
print(table.format(x, nil, " "))

-- enum test
print("Enum test")

local e = makeenum("e", {
  "one",
  [3] = "two",
  "three"
})

local a = e.three
print(a == e.three)
