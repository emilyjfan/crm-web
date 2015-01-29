require './contact'
require './rolodex'
require 'sinatra'
require 'sinatra/reloader'

@@rolodex = Rolodex.new
@@rolodex.new_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


@@crm_app_name = "EMILY'S CRM APP"


get '/' do 
	erb :index
end 

get '/contacts' do
 	erb :contacts
end


get '/contacts/new' do 
  erb :new_contact
end 

# #figure out how to view one contact only 
# get '/contacts/:name' do
#  	erb :view_contact
# end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.new_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end