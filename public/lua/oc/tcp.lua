local internet = require('internet');
local JSON = require("json");
local config = require('config');
local conf = config.get(config.path);

local handle = internet.open(conf.serverIP, tonumber(conf.tcpPort));
handle:setvbuf('line');
-- handle:setTimeout('10');

local M = {};

function M.read()
  -- reads delimited by newlines
  return JSON:decode(handle:read());
end

function M.write(data)
  local status, result = pcall(function()
    -- without the newline the write will wait in the buffer
    handle:write(JSON:encode(data)..'\r\n');
  end);
  if not status then
    local errorMessage = {['message']='Failed to serialize result!'};
    handle:write(JSON:encode(errorMessage)..'\r\n');
  end
  return result;
end

M.write({id={account=conf.accountName, robot=conf.robotName}});

return M;
