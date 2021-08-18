module User
    include HTTParty
    base_uri 'https://gorest.co.in/public-api'
    format :json
end