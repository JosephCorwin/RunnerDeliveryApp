# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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


optimus = User.create!(  first_name: "Optimus",
                          last_name: "Prime",
                              email: "op@auto.bots",
                              phone: "4628862687",
                           password: "password",
              password_confirmation: "password",
                             status: "good"            )
optimus.activate!
optimus.is_runner!

dispatch = User.create!( first_name: "Dispatch",
                          last_name: "Control",
                              email: "dispatch@runnerdeliveries.com",
                              phone: "0258963214",
                           password: "password",
              password_confirmation: "password",
                             status: "good"            )
dispatch.activate!
dispatch.is_dispatcher!

#Make some runners
10.times do |n|
  name1 = "Runner #{n+1}"
  name2 = "Runnn"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "runner#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password",
                            status: "runn" )
  user.activate!
  user.is_runner!
end

#make some former employees
10.times do |n|
  name1 = "Fired #{n+1}"
  name2 = "Gohome"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "fired#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password",
                            status: "prob" )
  user.activate!
  rand(1..17).even? ? user.is_runner! : user.is_dispatcher!
  user.is_fired!
end

#make some cusomters
50.times do |n|
  name1 = "Customer #{n+1}"
  name2 = "Buysstuff"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "customer#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password" )
  user.activate!
end

#make some new signups
5.times do |n|
  name1 = "Noob #{n+1}"
  name2 = "Newguy"
  user = User.create!(  first_name: name1,
                         last_name: name2,
                             email: "noob#{n+1}@example.com",
                             phone: (0..9).to_a.shuffle.join,
                          password: "password",
             password_confirmation: "password" )
end

#make some orders
User.where(status: 'good').each do |u|
  5.times do
    @order = u.account.orders.create!(what_they_want: "Stuff!", where_it_goes: "Places!", status: "open")
  end
end
Order.all.each do |o| #assign the orders
  o.update_attribute(:runner_id, rand(2..11))
  o.update_attribute(:where_to_get, "The store at #{rand(4324-6543)} Main St.")
  if rand(1-99).even?
    o.progress!
    if rand(1-99).odd?
      o.finished!
    end
  end
end
