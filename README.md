conneg
======

Purpose
-------

This Lua module implements HTTP content negotiation according to [RFC 7231 section 5.3](https://tools.ietf.org/html/rfc7231#section-5.3). It is meant for use with [OpenResty](https://openresty.org).

Usage
-----

The easiest way to put this module to use is by the following steps.

1. Place `conneg.lua` next to your `nginx.conf` file

    ```bash
    $ cd
    $ git clone https://github.com/EmptyStar/conneg
    $ cp ./conneg/conneg.lua /etc/nginx/
    ```

2. Import the `conneg` module and register your MIME types

    ```
    # nginx.conf
    
    init_by_lua_block {
      require("conneg")
      conneg.accept.register("image","image/jpeg,image/png,image/gif")
    }
    ```

3. Negotiate acceptable MIME types for incoming requests

    ```
    # nginx.conf
    
    accept_by_lua_block {
      # Capture the incoming HTTP request's Accept header, or provide a default
      local newtype = ngx.var.http_accept or "*/*"

      # Reject Accept headers that are too short or too long
      if newtype:len() > 255 or newtype:len() == 0 then
        ngx.exit(ngx.HTTP_NOT_ACCEPTABLE)
      else
        # Negotiate an appropriate type
        newtype = conneg.accept.negotiate(newtype,"image")

        # A nil value indicates that the client and server could not negotiate an agreeable type
        if newtype == nil then
          ngx.exit(ngx.HTTP_NOT_ACCEPTABLE)
        else
          # Set the client's Accept header to the negotiated type
          ngx.req.set_header("Accept",newtype)
        end
      end
    }

    # Pass the request upstream with its single-value Accept header
    proxy_pass http://upstream-image-server:8080;
    ```

All initialization should occur within an `init_by_lua_block`. Either a `rewrite_by_lua_block` or an `access_by_lua_block` is most appropriate for handling content negotiation.

### Functions

The following functions are defined for public use.

 * `conneg.accept.register([string:name],[string:types])`: Registers a predefined set of MIME types to be negoitated against
 * `conneg.accept.negotiate([string:accept_header],[string:name])`: Negotiates an Accept header value against a registered set of MIME types

Implementation
--------------

Values are parsed character-by-character using a finite state machine. Parsed values are then sorted by descending preference according to the rules specified in the RFC, and a Cartesian product between the client's list of acceptable values and the server's list of available values is then evaluated to determine the most preferable match.

Note that the module contains a number of "internal" functions and values that are not meant to be used outside of the module itself. Any values that are not listed for public use above should not be used as their implementation may change or disappear at any time. These functions and values are preceded with an underscore in the source code in order to avoid confusion.

To-Do
-----

Only content negotiation for the Accept header is currently implemented. Ideally, this module will be updated to also include content negotiation for Accept-Charset, Accept-Encoding, and Accept-Language. There are also bound to be many bugs in the code that have not yet surfaced, and the implementation may not match the RFC exactly. Issues and pull requests to identify and/or rememdy these are welcome.

License
-------

Licensed MIT. See the included LICENSE file for details.
