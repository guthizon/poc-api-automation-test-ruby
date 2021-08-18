#language: pt

@test
Funcionalidade: POST Users

	Cenario: POST no recurso /users
		Dado que tenho o endpoint "/users"
		Quando faço um POST de um usuário
		Então deve retornar o satuscode 200
		E valido os dados inseridos

