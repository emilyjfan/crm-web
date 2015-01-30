require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String 
end

DataMapper.finalize
DataMapper.auto_upgrade! 

@@crm_app_name = "EMILY'S CRM APP"


get '/' do 
	erb :index
end 

get '/contacts' do
 	@contacts = Contact.all 
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
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
  	redirect to('/contacts')
end

get '/contacts/search' do 
	erb :search_contact
end


get '/contacts/results' do 

	# patterns = [:first_name, :last_name, :email, :id].map { |attribute| "%#{params[attribute]}%"  }
	
 	@first_name = "%#{params[:first_name]}%" 
  	@last_name = "%#{params[:last_name]}%" 
 	@email = "%#{params[:email]}%" 
 	@id = "%#{params[:id]}%" 

 	@results = Contact.all({
 		:conditions => [
 		"first_name LIKE ? AND last_name LIKE ? AND email LIKE ? AND id LIKE ?", 
 		@first_name,
 		@last_name,
 		@email,
 		@id
 		]
 	})

	erb :search_results

end


get '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
	if @contact  
  		erb :show_contact
	else
		raise Sinatra::NotFound
	end 
end

get '/contacts/:id/edit' do 
 	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact 
	else
		raise Sinatra::NotFound
	end
end

put '/contacts/:id' do
 	@contact = Contact.get(params[:id].to_i)
	if @contact 
		@contact.last_name = params[:last_name]
		@contact.first_name = params[:first_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

		@contact.save
	
		redirect to ("/contacts")
	else
		raise Sinatra::NotFound				
	end
end

delete '/contacts/:id' do
 	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		redirect to ('/contacts')
	else
		raise Sinatra::NotFound
	end
end







