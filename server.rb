
require 'sinatra'

get '/' do 
	"Hello World!"
end

get'/hi' do 
	puts "PARAMS => #{params}"
	"hi!!!"
end

get '/:name' do 
	puts "PARAMS => #{params}"
	@name = params[:name].capitalize
	
	erb :index 
end 