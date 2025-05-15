require('auth')
require('compras')
require('util')
require('access')
require('httpHandle')

server = require 'http.server'
headers = require 'http.headers'

driver = require 'luasql.mysql'
env = driver.mysql()
json = require('json')

bcrypt = require('bcrypt')

function gethammertime()
    return tonumber(assert(assert(io.popen'date +%s%3N'):read'a'))
end
math.randomseed(gethammertime())

local config = {}

local srv = server.listen {
  host = '0.0.0.0',
  port = 8998,
  tls = false,
  onstream = function (sv, out)
    local hdrs = out:get_headers()
    local authCode = hdrs:get('Authorization')
    local method = hdrs:get(':method')
    local path = hdrs:get(':path') or '/'
    local body = out:get_body_as_string()
    local rh = headers.new()

    local command = split(path,"/")
    handleAccess(command, rh, out, body, method)
    
  end,
  onerror = function (err, errn, a, b, c, d, e)
    print(err, errn,a,b,c,d,e)
  end
}

local user, pass = "",""
function readConfig()
    local filename = ".env"
    local file = io.open(filename,"r")
    local config = file:read("a")
    local obj = json.decode(config)
    user = obj.user
    pass = obj.pass
end
readConfig()
print(user, pass)
conn = env:connect('listacompras',user,pass)


srv:listen()
local n, err, errnum = srv:loop()

if n==nil then print(err,errnum) end