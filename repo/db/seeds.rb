# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def phony_address
  ad_no = rand(100..230).to_s
  if rand(1..99).even?
    st_ns = "N"
  else
    st_ns = "S"
  end
  st_no = rand(1..14).to_s
  if st_no == "1"
     st_no += "st"
  elsif st_no == "2"
    st_no += "nd"
  elsif st_no == "3"
    st_no += "rd"
  else
    st_no += "th"
  end
  return ad_no + " " + st_ns + " " + st_no + "street, Olean, NY"
end

      
  

#Make the boss and optimus and the dispatcher
boss = User.create!(     first_name: "Bossman",
                          last_name: "Bobby",
                              email: "bossman@runnerdeliveries.com",
                              phone: "7418520963",
                           password: "password",
              password_confirmation: "password",
                             status: "boss",
                          activated: "true",
                       activated_at: Time.zone.now     )
boss.addresses.create(address: phony_address, name: "home")
boss.set_primary_address(boss.addresses.first)


optimus = User.create!(  first_name: "Optimus",
                          last_name: "Prime",
                              email: "op@auto.bots",
                              phone: "4628862687",
                           password: "password",
              password_confirmation: "password")
optimus.activate!
optimus.is_runner!

dispatch = User.create!( first_name: "Dispatch",
                          last_name: "Control",
                              email: "dispatch@runnerdeliveries.com",
                              phone: "0258963214",
                           password: "password",
              password_confirmation: "password")
dispatch.activate!
dispatch.is_dispatcher!

#Make some runners
4.times do |n|
  name1 = "Runner #{n+1}"
  name2 = "Runnn"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "runner#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password")
  user.addresses.create(address: phony_address, name: "home")
  user.set_primary_address(user.addresses.first)
  user.activate!
  user.is_runner!
end

#make some former employees
2.times do |n|
  name1 = "Fired #{n+1}"
  name2 = "Gohome"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "fired#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password")
  user.addresses.create(address: phony_address, name: "home")
  user.set_primary_address(user.addresses.first)
  user.activate!
  rand(1..17).even? ? user.is_runner! : user.is_dispatcher!
  user.is_fired!
end

#make some cusomters
5.times do |n|
  name1 = "Customer #{n+1}"
  name2 = "Buysstuff"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "customer#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password")
  user.addresses.create!(address: phony_address, name: "home")
  user.set_primary_address(user.addresses.first)
  user.activate!
end

#make some new signups
3.times do |n|
  name1 = "Noob #{n+1}"
  name2 = "Newguy"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "noob#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password")
  user.addresses.create!(address: phony_address, name: "home")
  user.set_primary_address(user.addresses.first)
end

#make some stores
5.times do |n|
  store = Store.create!( name: "GG Grocery no.#{n+1}",
                     featured: true)

  store.create_address(address: phony_address)
  
  store.items.create!( name: "Soylent Red",
               description: "Delicious, nutritious, and widely available!",
                     price: 1.99,
                    active: true)

  store.items.create!( name: "Soylent Yellow",
               description: "A protein powerhouse!",
                     price: 2.99,
                    active: true)

  store.items.create!( name: "Soylent Orange",
               description: "A citrus blend on the classic flavor",
                     price: 6.99,
                    active: true)
  store.items.create!( name: "Soylent Green",
               description: "Only available on Tuesdays",
                     price: 10.99,
                    active: true)
end

#make some carts
User.where(status: 'good').each do |u|
  @order = u.account.orders.create!
  @order.cart_items.create!( attributes = {item_id: rand(1..20), quantity: rand(1..3)} )
  @order.save
  if rand(1..99).even?
    @order.order!
  end
end
#set some orders
Order.where(status: 'cart').each do |o| #assign the orders
  o.update_attribute(:runner_id, rand(2..5))
  o.update_attribute(:where_to_get, o.cart_items.first.item.store.address.address)
  if rand(1..99).even?
    o.receipt = "dummy_receipt.jpg"
    o.progress!
    if rand(1..99).odd?
      o.finished!
    end
  end
end
