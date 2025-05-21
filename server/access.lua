function handleAccess(command, rh, out, body, method)
    if #command==0 then
        returnNotFound(rh, out)
    end
    if method == "GET" then
        handleGet(command, rh, out)
    elseif method == "POST" then
        handlePost(command, rh, out, body)
    elseif method == "DELETE" then
        handleDelete(command, rh, out)
    elseif method == "PUT" then
        handlePut(command, rh, out, body)
    end
end

function handleGet(command, rh, out)
    local where = command[1]
    if where == "compras" then
        local response, error = readCompras()
        tryToSend(response, error, rh, out)
    end
end

function handlePost(command, rh, out, body)
    if command[1] == "compras" then
        local response, error = addCompra(body)
        tryToSend(response, error, rh, out)
    end
end

function handleDelete(command, rh, out)
    if command[1] == "compras" then
        local response, error = deleteCompra(command[2])
        tryToSend(response, error, rh, out)
    end
end

function handlePut(command, rh, out, body)
    if command[1] == "compras" then
        local response, error = modifyCompra(body,command[2])
        tryToSend(response, error, rh, out)
    end
end

function tryToSend(body, error, rh, out)
    
    if body then
        body = tostring(body)
        returnOk(rh, out, body)
    else
        error = tostring(error)
        returnError(rh, out, error)
    end
end