#language: pt

@test
Funcionalidade: PUT Users

	Cenario: PUT no recurso /users
		Dado que tenho o endpoint "/users"
		Quando faço um GET para todos os usuários
		Então deve retornar o satuscode 200
		Quando faço um PUT para o primeiro registro retornado
        Então deve retornar o satuscode 200

