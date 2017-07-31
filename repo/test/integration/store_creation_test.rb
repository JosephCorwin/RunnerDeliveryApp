require 'test_helper'

class StoreCreationTest < ActionDispatch::IntegrationTest

	def setup
		@boss = users(:boss)
		@jerk = users(:archer)
		@customer = users(:michael)
		@new_store_params = { store: {          name: 'Foo Bar',
			                                 address: '123 Fake St, Faketown, XX',
			                            contact_name: 'Chad Fakerton',
			                           contact_phone: '1203456304' }}
	end

	test 'bossman can add stores' do

		log_in_as(@boss)
		get new_store_path
		assert_template 'stores/new'
		assert_difference 'Store.count', 1 do
		  assert_difference 'Address.count', 1 do
		      post stores_path, params: { store: { name: 'Foo Bar',
				                                address: '123 Fake St, Faketown, XX',
				                           contact_name: 'Chad Fakerton',
				                          contact_phone: '1203456304' }}
		  end
	    end

	end

end