class Contact
	attr_accessor :id, :first_name, :last_name, :email, :note

	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
	end

	FIRST_NAMES = %w[
		Bob
		Janet
		Steve
		Alice
		Ellen
		Lobsterman
	]
	LAST_NAMES = %w[
		Jones
		Ho
		Johnston
		Ali
		McTheDestructor
	]

	def self.fake
		new(FIRST_NAMES.sample, LAST_NAMES.sample, "fake@fake.com", "Intentionally left blank.")
	end

	def update_attribute(attribute_name, new_attr)
		send(attribute_name+"=", new_attr)
	end

	def to_s 
		"ID:#{@id} First Name: #{@first_name} Last Name: #{@last_name} Email: #{@email} Note: #{@note}"
	end

end

