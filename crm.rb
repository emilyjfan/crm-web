require './contact'
require './rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	attr_accessor :id, :first_name, :ast_name, :email, :note

	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note 
	end
end

$rolodex = Rolodex.new

@@rolodex = Rolodex.new

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







