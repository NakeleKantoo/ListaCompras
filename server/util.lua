local caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
--caracteres = split(caracteres,"") 

function randomString(length)
    local str = ""
    for i=1,length do
        local v = math.random(1,#caracteres)
        str = str..caracteres:sub(v,v)
    end
    return str
end

function deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end
  
    local no
    if type(o) == 'table' then
      no = {}
      seen[o] = no
  
      for k, v in next, o, nil do
        no[deepcopy(k, seen)] = deepcopy(v, seen)
      end
      setmetatable(no, deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
      no = o
    end
    return no
end

function split(inputstr, sep)
	if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
          table.insert(t, str)
  end
  return t
end