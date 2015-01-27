class Rolodex
attr_reader :contacts

	@@ids = 1001

	def initialize 
		@contacts = []
	end

	def add_random_contacts
		10.times do
			new_contact(Contact.fake)
		end
	end

	def new_contact(contact)
		contact.id = @@ids
		@contacts << contact
		@@ids += 1
		contact
	end

	def find_contact(contact_id)
		@contacts.each do |contact| 
			if contact_id == contact.id
				return contact
			end 
		end
	end

	def display_all_contacts
		@contacts
	end

	def display_attribute(attribute_name)
		@contacts.map do |contact|
			contact.send(attribute_name) 
		end
	end
	
	def delete_one_contact(contact_id)
		@contacts.delete_if {|contact| contact_id == contact.id}
	end 

end

