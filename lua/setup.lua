local path = '/home/lib';
os.execute('mkdir ' .. path);
local codeURL = 'https://raw.githubusercontent.com/dunstad/roboserver/master/lua/downloadCode.lua';
os.execute('wget -f ' .. codeURL .. ' ' .. path .. '/downloadCode.lua');
local dl = require("downloadCode");
dl.downloadAll(path);
require('commandLoop');