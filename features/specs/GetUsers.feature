#language: pt

@test
Funcionalidade: GET Users

Contexto: GET no recurso /users
    Dado que tenho o endpoint "/users"
    E faço um GET informando o parâmetro "name=Naik"
    Então deve retornar o satuscode 200

Cenario: Pesquisar por nome do usuário
    E verifico que todos os objetos contenham "Naik"

Cenario: Consulta de posts por id Usuário
    Quando realizo um GET no endpoint "/posts" com o primeiro elemento retornado de /users
    Então deve retornar o satuscode 200
    E todos os objetos devem conter o id do usuário pesquisado