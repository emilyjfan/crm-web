require './contact'
require './rolodex'
require 'sinatra'

$rolodex = Rolodex.new

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
  @@rolodex.new_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts/1000" do
  @contact = @@rolodex.find_contact(1000)
  erb :show_contact
end

get "/contacts/:id" do
  @contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact  
  		erb :show_contact
	else
		raise Sinatra::NotFound
	end 
end

get "/contacts/:id/edit" do 
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		erb :edit_contact 
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]	
		@contact.note = params[:note]

		redirect to ("/contacts")	
	else
		raise Sinatra::NotFound 
	end 
end

delete "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to ('/contacts')
	end
end







