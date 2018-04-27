# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "starting seed"

puts "creating area"
westminster = Area.new(name: "Westminster")

puts "creating user (trainer)"
user = User.new(first_name: "Axel", last_name: "Manzano", email: "am@gmail.com", password: "123456" area: westminster)

puts "creating runners"
john = Runner.new(email: "jd@gmail.com", first_name: "John", last_name: "Doe", status: "never_run", area: westminster)
henry = Runner.new(email: "hc@gmail.com", first_name: "Henry", last_name: "Cavill", status: "lapsed", area: westminster)
arnold = Runner.new(email: "as@gmail.com", first_name: "Arnold", last_name: "Schwarzenegger", status: "regular", area: westminster)
ellen = Runner.new(email: "ed@gmail.com", first_name: "Ellen", last_name: "Degenneres", status: "never_run", area: westminster)
theresa = Runner.new(email: "tm@gmail.com", first_name: "Theresa", last_name: "May", status: "lapsed", area: westminster)

puts "creating preferences"

mission = Preference.new(name: "Mission")
group_run = Preference.new(name: "GroupRun")
coach_run = Preference.new(name: "CoachRun")

puts "creating memberships"

john_membership1 = Membership.new(runner: john, preference: mission)
john_membership2 = Membership.new(runner: john, preference: group_run)
henry_membership = Membership.new(runner: henry, preference: coach_run)
arnold_membership1 = Membership.new(runner: arnold, preference: mission)
arnold_membership2 = Membership.new(runner: arnold, preference: coach_run)
ellen_membership = Membership.new(runner: ellen, preference: mission)
theresa_membership = Membership.new(runner: theresa, preference: mission)

puts "seed finished!"



