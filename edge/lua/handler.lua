local file = ngx.var.uri
local cached_path = "/usr/local/openresty/cache" .. file
local cache_url = "/cached" .. file

-- check if file exists
local file_handle = io.open(cached_path, "rb")
if file_handle then
    file_handle:close()
    return ngx.exec(cache_url)
end

-- fetch from origin
local res = ngx.location.capture("/origin_proxy" .. file)
if res.status ~= 200 then
    ngx.status = res.status
    ngx.say("Failed to fetch from origin: ", res.status)
    return ngx.exit(res.status)
end

-- write to cache
local dir = string.match(cached_path, "(.+)/[^/]+$")
os.execute("mkdir -p " .. dir)

local out, err = io.open(cached_path, "wb")
if not out then
    ngx.status = 500
    ngx.say("Failed to open file for writing: ", err)
    return ngx.exit(500)
end

out:write(res.body)
out:close()

return ngx.exec(cache_url)
