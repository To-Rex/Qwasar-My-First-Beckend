require 'sinatra'

set :bind, '0.0.0.0'
set :port, 8080
helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end
    def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
      end
    end
get '/' do
    ['All alone','All By Myself','All I Need is the Girl','All I Do Is Dream of You',
    'All My Tomorrows','Almost Like Being in Love','Always','America the Beautiful',
    'American Beauty Rose','Among My Souvenirs','Angel Eyes','Anything Goes',
    'April in Paris','Around the World','As Time Goes By','At Long Last Love',
    'Autumn in New York','Autumn Leaves','Ave Maria','Bad, Bad Leroy Brown','Begin the Beguine'].sample()
end
get '/birth_date' do
    'December 12, 1915'
end
get '/wives' do
    'Barbara Sinatra , Ava Gardner , Mia ferriy , Nensi Barbato'
end
get '/birth_city' do
    'Hoboken, NJ'
end
get '/picture' do
     redirect 'https://upload.wikimedia.org/wikipedia/commons/a/af/Frank_Sinatra_%2757.jpg'
end
get '/public' do
    'Everybody can see this page'
end
get '/protected' do
    protected!
    'Welcome, authenticated cleint'
end
