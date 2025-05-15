# Greed
Greed is a _cool_ Lua library attempting to enrich the standard library with useful methods and other extra content.

# Guide
So far, this library only adds a few features, which includes stuff like _a better type system_ and _extra methods_.

## Result types
Borrowed from rust (pun intended), Lua can now use result types for error handling instead of obscure program crashes.

```lua
local foo = func_that_returns_result()

if foo:is_ok() then
    print(string.format("bar: %s", foo:get_result()))
elseif foo:is_err()
    print("baz")
end
```

It can (hopefully) integrate well with the standard library, meaning any function that **does not use result types**, can be made to return them.

```lua
local x = nil
local y = toresult(io.open(x, "w")) -- io.open throws an error

if y:is_err() then
    print("Result types are cool")
end
```

## Enhanced OOP and types
For now, this is still heavily WIP, but it has some good features so far:

- Hidden `__type` table parameter
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

        setmetatable(o, self)
        self.__index = self
        return o
    end

    local Lamborghini = Car:new("Lamborghini", "dunno", 2025)

    print(typeof(Lamborghini)) -- output: Car
    ```
- Enums
    The syntax for an enum is relatively simple:
    ```lua
    local enum_name = makeenum("enum_nam", {
        "one",
        "two",
        "three"
    })
    ```
    The **value** of each key in the table must be a string, specifically, a valid lua identifier. 
    Accessing an enum instance goes as:

    ```lua
    print(enum_name.one) -- output: 1
    ```

    The type of the enum instance is not something like `enum`, it is the name from the first parameter of `makeenum`.
    ```lua
    print(typeof(enum_name)) -- output: enum_nam
    ```
