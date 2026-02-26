local function load_env(path)
  local env = {}
  for line in io.lines(path) do
    -- ignore comments and empty lines
    if not line:match("^%s*#") and line:match("%S") then
      local key, value = line:match("^%s*export%s+([^=]+)=(.+)$")
      if not key then
        key, value = line:match("^%s*([^=]+)=(.+)$")
      end
      if key and value then
        -- strip quotes
        value = value:gsub("^['\"]", ""):gsub("['\"]$", "")
        env[key] = value
      end
    end
  end
  return env
end

local env = load_env(os.getenv("HOME") .. "/.env")

local ha_url = env.HA_URL
local ha_token = env.HA_TOKEN

local headers = {
  ["Authorization"] = "Bearer " .. ha_token,
  ["Content-Type"] = "application/json",
}

local function sendState(state)
  local service = (state == "on") and "turn_on" or "turn_off"

  local body = '{"entity_id": "input_boolean.nok_mac_user_active"}'
  hs.http.asyncPost(
    ha_url .. "/api/services/input_boolean/" .. service,
    body,
    headers,
    function(status, response, responseHeaders)
      if status ~= 200 then
        print(string.format(
          "HA request failed (%s): %s",
          tostring(status),
          tostring(response)
        ))
      else
        print("HA state updated successfully")
      end
    end
  )
end

-- Screen lock / unlock
hs.caffeinate.watcher.new(function(event)
  if event == hs.caffeinate.watcher.screensDidLock then
    sendState("off")
  elseif event == hs.caffeinate.watcher.screensDidUnlock then
    sendState("on")
  end
end):start()

-- Display sleep / wake
hs.caffeinate.watcher.new(function(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    sendState("off")
  elseif event == hs.caffeinate.watcher.systemDidWake then
    sendState("on")
  end
end):start()