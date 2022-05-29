-- Import conneg
require("conneg")
require("accept")
require("accept_language")

-- Set up global test function
function test(t)
  -- Print test info
  print("*** " .. t.description .. " ***")
  print("HAVE: " .. t.have)
  print("WANT: " .. t.want)
  print("EXPECT: " .. (t.expect or "(none)"))

  -- Execute test and report results
  t.conneg.register("test",t.have)
  local actual = t.conneg.negotiate(t.want,"test")
  print("ACTUAL: " .. (actual or "(none)"))
  if(actual == t.expect) then
    print("RESULT: PASS")
  else
    print("RESULT: FAIL")
  end

  print("")
end

tests = {
  -- Accept header tests
  {
    description = "Basic image MIME type negotiation, simple test for affirmative result",
    conneg = conneg.accept,
    have = "image/jpeg,image/png,image/gif",
    want = "image/webp, image/jpeg;q=0.9, image/png;q=0.5, image/*;q=0.2",
    expect = "image/jpeg"
  },
  {
    description = "Accept negotiation with lower index but high quality values",
    conneg = conneg.accept,
    have = "image/jpeg,image/png,image/gif",
    want = "image/webp;q=0.25, image/jpeg;q=0.1, image/png;q=0, image/gif;q=1",
    expect = "image/gif"
  },
  {
    description = "Accept wildcard type",
    conneg = conneg.accept,
    have = "image/jpeg,image/png,image/gif",
    want = "text/html, text/*;q=0.8, */*;q=0.5",
    expect = "image/jpeg"
  },
  {
    description = "Accept wildcard subtype",
    conneg = conneg.accept,
    have = "image/jpeg,image/png,image/gif",
    want = "image/webp, image/*;q=0.8",
    expect = "image/jpeg"
  },
  {
    description = "Failed Accept negotiation",
    conneg = conneg.accept,
    have = "image/jpeg,image/png,image/gif",
    want = "text/html, text/*;q=0.5",
    expect = nil
  },

  -- Accept-Language header tests
  {
    description = "Basic Accept-Language negotiation, simple test for affirmative result",
    conneg = conneg.accept_language,
    have = "en-US,es,fr",
    want = "da, en-gb;q=0.8, en;q=0.5",
    expect = "en-us"
  },
  {
    description = "Accept-Language negotiation with lower index but high quality values",
    conneg = conneg.accept_language,
    have = "en-US,es,fr",
    want = "da;q=0.9, en-gb;q=0.8, en;q=0.5, fr",
    expect = "fr"
  },
  {
    description = "Accept-Language negotiation with wildcard language",
    conneg = conneg.accept_language,
    have = "en-US,es,fr",
    want = "tr, tk;q=0.5, az;q=0.4, *;q=0.1",
    expect = "en-us"
  },
  {
    description = "Failed Accept-Language negotiation",
    conneg = conneg.accept_language,
    have = "en-US,es,fr",
    want = "tr, de",
    expect = nil
  },
}

for i = 1,#tests do
  test(tests[i])
end
