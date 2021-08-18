require 'faker'

@@statuscode = 0
@@new_user = {
    name: Faker::Name.name ,
    email: Faker::Internet.email,
    gender: 'male',
    status: 'active'
}
@@header = {
    Authorization: "Bearer 9f29328627c8491e442c784b11e1e58e7b4a761519ea0738869bae2177bf413f"
}

Dado('que tenho o endpoint {string}') do |resource|
    @endpoint = resource
end
  
Dado('faço um GET informando o parâmetro {string}') do |param|
    @users = User.get("#{@endpoint}?#{param}")
    @@statuscode = @users.code
    puts(@users)
end
  
Então('deve retornar o satuscode {int}') do |status|
    expect(@@statuscode).to eq(status)
end

Então('verifico que todos os objetos contenham {string}') do |value|
    @users['data'].each do |user|
        expect(user['name']).to include(value)
    end
    puts 'Consulta de usuários'
    puts @users
end

E('realizo um GET no endpoint {string} com o primeiro elemento retornado de \/users') do |resource|
    @user = @users['data'].first
    @posts = User.get("/users/#{@user['id']}#{resource}")
end
  
Então('todos os objetos devem conter o id do usuário pesquisado') do
    @posts['data'].each do |post|
        expect(post['user_id']).to eq(@user['id'])
        puts post
    end
    puts 'Consulta de posts'
    puts @posts
  end

Quando('faço um POST de um usuário') do
    @request = User.post(@endpoint, :body => @@new_user, :headers => @@header)
    @@statuscode = @request.code
    puts @request
end

E('eu faça um DELETE do usuário consultado') do
    @users['data'].each do |user|
        id = user['id']
        @request = User.delete("/users?id=#{id}")
        puts @request
    end
end

E('valido os dados inseridos') do
    expect(@request["code"]).to eq(201)
    expect(@request["data"]["id"]).not_to be nil
    expect(@request["data"]["name"]).to eq(@@new_user[:name])
    expect(@request["data"]["email"]).to eq(@@new_user[:email])
    expect(@request["data"]["gender"]).to eq(@@new_user[:gender])
    expect(@request["data"]["status"]).to eq(@@new_user[:status])
    
    puts 'Usuário cadastrado'
    puts @request
end

Quando('faço um GET para todos os usuários') do
    @users = '';
    @users = User.get("#{@endpoint}")
    @@statuscode = @users.code
    puts(@users)
end
  
  Quando('faço um DELETE para o primeiro registro retornado') do
    user = @users['data'].first
    @request = User.delete("/users/#{user['id']}")
    puts @request
  end

  Quando('faço um PUT para o primeiro registro retornado') do
    user = @users['data'].first
    @request = User.put("/users/#{user['id']}", 
        :body => {
            name: Faker::Name.name ,
            email: Faker::Internet.email,
            gender: 'male',
            status: 'active'
        }, :headers => @@header)
    puts @request
    @@statuscode = @request.code
  end
  