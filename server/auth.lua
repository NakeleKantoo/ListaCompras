function checkAuth(body)
    local t = json.decode(body)
    local email = t.email
    local pass = t.pass
    local query = "select senha from usuarios where email='"..email.."';"
    local cur, err = conn:execute(query)
    local cache = {}
    if cur then
        cur:fetch(cache, "n")
        if bcrypt.verify(pass, cache[1]) then
            local res = {text="Success", error=false, code=randomString(255)}
            local query = "insert into auth (code) values ('"..res.code.."');"
            local resTxt = json.encode(res)
            return resTxt, nil
        else
            return nil, json.encode({text="ERRO: Senha ou Usuario invalido", error=true, code=""})
        end
    else
        return nil, json.encode({text="ERRO: Senha ou Usuario invalido", error=true, code=""})
    end
end

function addUser(body)
    local totalUsers = getTotalUsers()
    local maxusers = getAllowedUsers()
    if tonumber(totalUsers) >= tonumber(maxusers) then
        return nil, json.encode({text="Máximo de usuarios alcançado", error=true})
    end

    local t = json.decode(body)
    local name = t.name
    local email = t.email
    local pass = t.pass
    local log_rounds = 9 --change if too slow/quick
    local hashed = bcrypt.digest(pass, log_rounds)
    local query = "insert into usuarios (nome, email, senha) values ('"..name.."','"..email.."','"..hashed.."');"
    local cur, err = conn:execute(query)
    if cur then
        local code = randomString(255)
        local query = "insert into auth (code) values ('"..code.."');"
        return json.encode({text="Success", error=false, code=code}), nil
    else
        return nil, json.encode({text="Erro", error=true})
    end
end

function getTotalUsers()
    local stmt = "select count(id) from usuarios;"
    local cur, err = conn:execute(stmt)
    if not cur then
        return nil, err
    end
    local cache = {}
    cur:fetch(cache, "n")
    return cache[1], nil
end

function getAllowedUsers()
    local stmt = "select * from maxusers where id='1';"
    local cur, err = conn:execute(stmt)
    if not cur then
        return nil, err
    end
    local cache = {}
    cur:fetch(cache, "a")
    return cache.value, nil
end