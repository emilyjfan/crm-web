require './contact'
require 'sinatra'

get '/' do 
	@crm_name = "My CRM"
	erb :index
end 

get '/contacts' do
end
