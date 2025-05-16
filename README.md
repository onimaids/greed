# Greed
Greed is another Lua library that enhances the standard library. Unlike others, it tries to blend in with the rest of the standard library; in terms of syntax and usage style (like a monkey-patch).

# Guide
## Result types
Borrowed from rust (pun intended), Lua can now use result types for error handling instead of meaningless-and-obscure program crashes.

```lua
local foo = func_that_returns_result()

if foo:is_ok() then
    print(string.format("bar: %s", foo:get_result()))
elseif foo:is_err()
    print("baz")
end
```

It integrates well with the rest of the standard library, meaning any function that does not use result types, _can_ be made to return one.

```lua
local x = nil
local y = toresult(io.open(x, "w")) -- io.open throws an error in this case

if y:is_err() then
    print("Result types are cool")
end
```

## Enhanced OOP and types
- Better classes
    Using `maketype(t, name)`, you can now give tables an unique type name to enhance OOP and formatting.
    For this to have any effect, **use** this library's `typeof` instead of the standard library's `type` function for checking types.

    ```lua
    local Car = {}
    
    function Car:new(name, brand, year)
        local o = {
            name = name,
            brand = brand,
            year = year
        }

        maketype(o, "Car")
        return o
    end

    local Lamborghini = Car:new("Lamborghini", "dunno", 2025)

    print(typeof(Lamborghini)) -- output: Car
    ```
- Enums
    ```lua
    local enum_name = makeenum("enum_nam", {
        "one",
        "two",
        "three"
    })
    ```

    The value of each key in the table **must be a string**; specifically, a valid lua identifier. This is so you can maintain such syntax for enum accessing:
    ```lua
    print(enum_name.one) -- output: 1
    ```

    The type of the enum instance is not something like `enum`, it is the name from the first parameter of `makeenum`.
    ```lua
    print(typeof(enum_name)) -- output: enum_nam
    ```

## Extra methods
- Dump tables
    ```lua
    -- initial table
    local t = { 0, 1, 2, 5 }

    print(table.format(t, " "))
    ```
- Filter, find, map on tables
    ```lua
    -- print the table with even numbers only
    print("Even numbers: " .. table.format(table.filter(t, function(v)
        return v % 2 == 0 end
    )))

    -- add one to every table value
    t = table.map(t, function(v) return v + 1 end)
    print("Mapped: " .. table.format(t, " "))

    -- find the index of "6"
    local i = table.find(t, function)
    ```
