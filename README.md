## Lista de compras
Para executar localmente, você precisa das dependencias:\

>Lua 5.4 [Website](https://lua.org)
>Luarocks [Website](https://github.com/luarocks/luarocks/wiki/Download)
>Mariadb [Website](https://mariadb.org/)
>lua-http [Website](https://github.com/daurnimator/lua-http)
>lua-sql [Website](https://lunarmodules.github.io/luasql/index.html)

Depois de instaladas, execute o script sql na pasta server executando `mariadb -u <SEU USUARIO> -p listacompras < database.sql` e depois\
vá até a pasta server e execute `lua server.lua`\
e altere a variável URL no topo do script.js para a URL do seu servidor, se for local, pode colocar `localhost`

## Para fins de teste:
Um servidor está aberto e rodando com esse exato código, disponível para acesso [aqui](https://www.leonnaviegas.dev.br/listacompras)