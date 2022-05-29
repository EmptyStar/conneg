-- Define global conneg object
conneg = {}

-- Define charsets for parsing
conneg._charsets = {
  alpha = (function()
    local charset = {}
    for c in string.gmatch("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",".") do
      charset[c] = true
    end
    return charset
  end)(),

  digits = (function()
    local charset = {}
    for c in string.gmatch("1234567890",".") do
      charset[c] = true
    end
    return charset
  end)(),

  alphanum = (function()
    local charset = {}
    for c in string.gmatch("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",".") do
      charset[c] = true
    end
    return charset
  end)(),

  token = (function()
    local charset = {}
    for c in string.gmatch("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-",".") do
      charset[c] = true
    end
    return charset
  end)(),

  typeChars = (function()
    local charset = {}
    for c in string.gmatch("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-+._!#$&^",".") do
      charset[c] = true
    end
    return charset
  end)()
}

require("accept")
require("accept_language")
