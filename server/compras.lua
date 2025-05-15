function addCompra(str)
    local table = json.decode(str)
    local stmt = "INSERT INTO listacompras (produto, quantia, dtcriacao, user) VALUES ('"..table.nome.."', '"..table.qtd.."', '"..table.dt.."', '"..table.user.."');"
    local num, err = conn:execute(stmt)
    return num, err
end

function modifyCompra(str,id)
    local table = json.decode(str)
    local stmt = "UPDATE listacompras SET produto='"..table.nome.."', quantia='"..table.qtd.."';"
    local num, err = conn:execute(stmt)
    return num, err
end

function deleteCompra(id)
    local stmt = "DELETE FROM listacompras WHERE id='"..id.."';"
    local num, err = conn:execute(stmt)
end

function readCompras()
    local cur, err = conn:execute("select * from listacompras;")
    if not cur then
        return nil, err
    end
    local obj = ""
    local table = {}
    local t = {}
    while cur:fetch(t,"a") do
        table[#table+1] = deepcopy(t)
    end
    if #table==0 then return nil, "Erro desconhecido" end
    obj = json.encode(table)
    print(obj)
    return obj
end