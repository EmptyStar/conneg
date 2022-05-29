conneg
======

Purpose
-------

This Lua module implements HTTP content negotiation according to [RFC 7231 section 5.3](https://tools.ietf.org/html/rfc7231#section-5.3). It is meant for use with [OpenResty](https://openresty.org).

Usage
-----

The easiest way to put this module to use is by the following steps.

1. Clone EmptyStar/conneg next to your `nginx.conf` file

    ```bash
    $ cd /etc/nginx
    $ git clone https://github.com/EmptyStar/conneg
    ```

2. Import the `conneg` modules and register your supported MIME types and languages

    ```
    # nginx.conf
    
    init_by_lua_block {
      require("conneg/conneg")
      require("conneg/accept")
      require("conneg/accept_language")

      conneg.accept.register("text","text/html,text/plain,text/x-wiki")
      conneg.accept_language.register("languages","en-us,es,fr")
    }
    ```

3. Negotiate acceptable MIME types and languages for incoming requests

    ```
    # nginx.conf
    
    access_by_lua_block {
      # Capture the incoming HTTP request's Accept header, or provide a default
      local newtype = ngx.var.http_accept or "*/*"
      local newlanguage = ngx.var.http_accept_language or "*"

      # Attempt to negotiate an appropriate MIME type
      newtype = conneg.accept.negotiate(newtype,"image")

      # Use negotiated type else return HTTP 406 if no type could be negotiated
      if newtype == nil then
        ngx.exit(ngx.HTTP_NOT_ACCEPTABLE)
      else
        ngx.req.set_header("Accept",newtype)
      end

      # Attempt to negotiate an appropriate language
      newlanguage = conneg.accept_language.negotiate(newlanguage,"languages")

      # Use client's language or default to en-us if no language could be negotiated
      if newlanguage = nil
        ngx.req.set_header("Accept-Language","en-us")
      else
        ngx.req.set_header("Accept-Language",newlanguage)
      end
    }

    # Pass the request upstream with its single-value Accept and Accept-Language headers
    proxy_pass http://upstream-web-server:8080;
    ```

All initialization should occur within an `init_by_lua_block`. Either a `rewrite_by_lua_block` or an `access_by_lua_block` is most appropriate for handling content negotiation.

### Functions

The following functions are defined for public use.

 * `conneg.accept.register([string:name],[string:types])`: Registers a named list of MIME types to negotiate against; returns nothing
 * `conneg.accept.negotiate([string:accept_header],[string:name])`: Negotiates an Accept header value against a registered list of MIME types; returns a single type if successful or nil otherwise
 * `conneg.accept_language.register([string:name],[string:languages])`: Registers a named list of languages to negotiate against; returns nothing
 * `conneg.accept_language.negotiate([string:languages],[string:name])`: Negotiates an Accept-Language header value against a registered list of languages; returns a single language if successful or nil otherwise

Implementation
--------------

Values are parsed character-by-character using a finite state machine. Parsed values are then sorted by descending preference according to the rules specified in the RFC, and a Cartesian product between the client's list of acceptable values and the server's list of available values is then evaluated to determine the most preferable match.

Note that the module contains a number of "internal" functions and values that are not meant to be used outside of the module itself. Any values that are not listed for public use above should not be used as their implementation may change or disappear at any time. These functions and values are preceded with an underscore in the source code in order to avoid confusion.

To-Do
-----

Content negotiation for the Accept header and Accept-Language header is currently implemented. Ideally, this module will be updated to also include content negotiation for Accept-Charset and Accept-Encoding. There are also bound to be many bugs in the code that have not yet surfaced, and the implementation may not match the RFC exactly. Issues and pull requests to identify and/or rememdy these are welcome.

License
-------

Licensed MIT. See the included LICENSE file for details.
