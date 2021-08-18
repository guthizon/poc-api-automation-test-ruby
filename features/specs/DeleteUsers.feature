#language: pt

@test
Funcionalidade: DELETE Users

	Cenario: DELETE no recurso /users
		Dado que tenho o endpoint "/users"
		Quando faço um GET para todos os usuários
		Então deve retornar o satuscode 200
		Quando faço um DELETE para o primeiro registro retornado
        Então deve retornar o satuscode 200

