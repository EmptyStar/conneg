-- Content negotiation for the HTTP Accept-Language header
conneg.accept_language = {
  -- Functions that represent individual parsing states
  _state = {
    START = function(v,c)
      v:start()
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG2"
      elseif c == "*" then
        v:captureValueChar(c)
        return "LANGANY"
      elseif c == " " then
        return "WHITESPACE_AFTER_START"
      elseif c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,

    LANG2 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG3"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG3 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG4"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG4 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG5"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG5 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG6"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG6 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG7"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG7 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG8"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANG8 = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANGEND"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANGEND = function(v,c)
      if c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    LANGANY = function(v,c)
      if c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG1 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG2"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG2 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG3"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG3 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG4"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG4 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG5"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG5 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG6"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG6 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG7"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG7 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANG8"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANG8 = function(v,c)
      if conneg._charsets.alphanum[c] then
        v:captureValueChar(c)
        return "SUBLANGEND"
      elseif c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    SUBLANGEND = function(v,c)
      if c == "-" then
        v:captureValue()
        return "SUBLANG1"
      elseif c == "," then
        v:captureValue()
        v:captureLanguage()
        return "START"
      elseif c == ";" then
        v:captureValue()
        return "Q"
      elseif c == " " then
        v:captureValue()
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q = function(v,c)
      if c == "q" then
        return "Q_EQUALS"
      else
        return "FAILSCAN"
      end
    end,

    Q_EQUALS = function(v,c)
      if c == "=" then
        return "Q_VALUE"
      else
        return "FAILSCAN"
      end
    end,

    Q_VALUE = function(v,c)
      if c == "0" then
        v:captureQ(c)
        return "Q0"
      elseif c == "1" then
        v:captureQ(c)
        return "Q1"
      elseif c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,

    Q0 = function(v,c)
      if c == "." then
        v:captureQ(c)
        return "Q0_DOT"
      elseif c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q1 = function(v,c)
      if c == "." then
        v:captureQ(c)
        return "Q1_DOT"
      elseif c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q1_DOT = function(v,c)
      if c == "0" then
        v:captureQ(c)
        return "Q1_DIGIT1"
      elseif c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,

    Q1_DIGIT1 = function(v,c)
      if c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      elseif c == "0" then
        v:captureQ(c)
        return "Q1_DIGIT2"
      else
        return "FAILSCAN"
      end
    end,

    Q1_DIGIT2 = function(v,c)
      if c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      elseif c == "0" then
        v:captureQ(c)
        return "Q1_DIGIT3"
      else
        return "FAILSCAN"
      end
    end,

    Q1_DIGIT3 = function(v,c)
      if c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q0_DOT = function(v,c)
      if conneg._charsets.digits[c] then
        v:captureQ(c)
        return "Q0_DIGIT1"
      elseif c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,

    Q0_DIGIT1 = function(v,c)
      if conneg._charsets.digits[c] then
        v:captureQ(c)
        return "Q1_DIGIT2"
      elseif c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q0_DIGIT2 = function(v,c)
      if conneg._charsets.digits[c] then
        v:captureQ(c)
        return "Q1_DIGIT3"
      elseif c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    Q0_DIGIT3 = function(v,c)
      if c == "," then
        v:captureLanguage()
        return "START"
      elseif c == " " then
        v:captureLanguage()
        return "WHITESPACE_AFTER_LANGUAGE"
      else
        return "FAILSCAN"
      end
    end,

    WHITESPACE_AFTER_START = function(v,c)
      if conneg._charsets.alpha[c] then
        v:captureValueChar(c)
        return "LANG2"
      elseif c == "*" then
        v:captureValueChar(c)
        return "LANGANY"
      elseif c == " " then
        return "WHITESPACE_AFTER_START"
      elseif c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,

    WHITESPACE_AFTER_LANGUAGE = function(v,c)
      if c == "," then
        return "START"
      else
        return "WHITESPACE_AFTER_LANGUAGE"
      end
    end,

    FAILSCAN = function(v,c)
      if c == "," then
        return "START"
      else
        return "FAILSCAN"
      end
    end,
  },

  -- Functions called to terminate parsing
  _terminate = {
    START = function(v) end,
    LANG2 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG3 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG4 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG5 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG6 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG7 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANG8 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANGEND = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    LANGANY = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG1 = function(v) end,
    SUBLANG2 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG3 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG4 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG5 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG6 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG7 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANG8 = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    SUBLANGEND = function(v)
      v:captureValue()
      v:captureLanguage()
    end,
    Q = function(v) end,
    Q_EQUALS = function(v) end,
    Q_VALUE = function(v) end,
    Q0 = function(v)
      v:captureLanguage()
    end,
    Q1 = function(v)
      v:captureLanguage()
    end,
    Q1_DOT = function(v) end,
    Q1_DIGIT1 = function(v)
      v:captureLanguage()
    end,
    Q1_DIGIT2 = function(v)
      v:captureLanguage()
    end,
    Q1_DIGIT3 = function(v)
      v:captureLanguage()
    end,
    Q0_DOT = function(v) end,
    Q0_DIGIT1 = function(v)
      v:captureLanguage()
    end,
    Q0_DIGIT2 = function(v)
      v:captureLanguage()
    end,
    Q0_DIGIT3 = function(v)
      v:captureLanguage()
    end,
    WHITESPACE_AFTER_START = function(v) end,
    WHITESPACE_AFTER_LANGUAGE = function(v) end,
    FAILSCAN = function(v) end
  },

  -- Function for advancing the parser state
  _step = function(next,v,c)
    return conneg.accept_language._state[next](v,c)
  end,

  -- Function and map for capturing registered sets of MIME types
  _registeredTypes = {},
  register = function(name,languages)
    conneg.accept_language._registeredTypes[name] = conneg.accept_language._parse(languages)
  end,

  -- Function that returns the most preferable value between the values
  -- requested and the values available
  negotiate = function(want,have)
    want = conneg.accept_language._parse(want)
    have = conneg.accept_language._registeredTypes[have]

    for x,request in pairs(want) do
      for y,language in pairs(have) do
        if request:str() == language:str() or (#request.values == 1 and (request.values[1] == language.values[1] or request.values[1] == "*")) then
          return language:str()
        end
      end
    end
    return nil
  end,

  -- Function for sorting parsed values by descending preference
  _sort = function(t)
    table.sort(t,function(a,b)
      if a.q > b.q then return true end
      if b.q > a.q then return false end
      return a.index < b.index
    end)
  end,

  -- Function for parsing a header value
  _parse = function(header)
    -- Create object for holding successfully parsed languages
    local languages = {}

    -- Create object for capturing parsed values
    local values = {
     currentState = "START",
     index = 0,

      start = function(v)
        v.current = {
          index = v.index,
          value = "",
          values = {},
          q = "",

          str = function(t)
            local s = ""
            for i,segment in pairs(t.values) do
              s = s .. "-" .. segment
            end
            return string.sub(s,2)
          end,
        }
        v.index = v.index + 1
      end,
      
      captureValueChar = function(v,c)
        v.current.value = v.current.value .. string.lower(c)
      end,
      
      captureValue = function(v,c)
        table.insert(v.current.values,v.current.value)
        v.current.value = ""
      end,

      captureQ = function(v,c)
        v.current.q = v.current.q .. c
      end,
      
      captureLanguage = function(v)
        v.current.q = tonumber(v.current.q) or 1
        if v.current.q > 0 then table.insert(languages,v.current) end
      end,
    }

    -- Parse the value character-by-character then cleanly terminate parsing
    for c in header:gmatch('.') do
      values.currentState = conneg.accept_language._step(values.currentState,values,c)
    end
    conneg.accept_language._terminate[values.currentState](values)

    -- Sort parsed values by descending preference
    conneg.accept_language._sort(languages)

    -- Return the parsed types
    return languages
  end
}
