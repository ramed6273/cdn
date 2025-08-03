local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(1000)

local ok, err = red:connect("redis", 6379)
if not ok then
    ngx.status = 500
    ngx.say("Redis connect error: ", err)
    return ngx.exit(500)
end

local res, err = red:get("hello")
if not res or res == ngx.null then
    local ok, err = red:set("hello", "world")
    if not ok then
        ngx.status = 500
        ngx.say("Redis set error: ", err)
        return ngx.exit(500)
    end

    ngx.say("Cache miss - set hello=world")
else
    ngx.say("Cache hit: hello = " .. res)
end

-- close connection explicitly
red:set_keepalive(10000, 100)

