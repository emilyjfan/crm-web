require './contact'
require './rolodex'
require 'sinatra'

$rolodex = Rolodex.new
@crm_app_name = "EMILY'S CRM APP"

get '/' do 
	@crm_app_name = "EMILY'S CRM APP" 
	erb :index
end 

get '/contacts' do
 	@crm_app_name = "EMILY'S CRM APP"
 	erb :contacts
end


get '/contacts/new' do 
  @crm_app_name = "EMILY'S CRM APP" 
  erb :new_contact
end 

#figure out how to view one contact only 
get '/contacts/:name' do
 	@crm_app_name = "EMILY'S CRM APP"
 	erb :view_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.new_contact(new_contact)
  redirect to('/contacts')
end