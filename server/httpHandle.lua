function returnOk(headers, out, response)
    headers:append(':status','200')
    headers:append('content-type','application/json')
    headers:append("Access-Control-Allow-Origin", "*")
    headers:append("Access-Control-Allow-Headers", "Origin, crossorigin")
    out:write_headers(headers, false)
    out:write_chunk(response, true)
end

function returnNotFound(headers, out)
    headers:append(":status","404")
    headers:append('content-type','application/json')
    headers:append("Access-Control-Allow-Origin", "*")
    headers:append("Access-Control-Allow-Headers", "Origin, crossorigin")
    out:write_headers(headers,false)
    out:write_chunk('{"error":"true","text":"Endpoint desconhecido"}',true)
end

function returnError(headers, out, response)
    headers:append(":status","500")
    headers:append('content-type','application/json')
    headers:append("Access-Control-Allow-Origin", "*")
    headers:append("Access-Control-Allow-Headers", "Origin, crossorigin")
    out:write_headers(headers,false)
    out:write_chunk(response,true)
end