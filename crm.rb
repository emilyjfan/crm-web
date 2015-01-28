require './contact'
require './rolodex'
require 'sinatra'

$rolodex = Rolodex.new

get '/' do 
	@crm_app_name = "Emily's CRM App"
	erb :index
end 

get '/contacts' do
 	@crm_app_name = "Emily's CRM App"
 	erb :contacts
end


get '/contacts/new' do 
  @crm_app_name = "Emily's CRM App"
  erb :new_contact
end 

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.new_contact(new_contact)
  redirect to('/contacts')
end