require 'rails_helper'
describe User do
	it 'should not save an invalid user' do
		user = User.new
		expect {user.save}.to change {User.count}.by(0)
	end
	
	it 'should save a valid user' do
		user = User.new(first_name: "Rodger",
			             last_name: "Goodman",
		                     email: "rgoodman@example.com",
		                     phone: "7859635216",
		                    status: "good",
               			  password: "testpass123",
			 password_confirmation: "testpass123")
		expect {user.save}.to change {User.count}.by(1)
	end
end