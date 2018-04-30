puts "starting seed"

puts "destroying previous seeds"
Runner.destroy_all
PersonalisedEmail.destroy_all
User.destroy_all
Area.destroy_all

puts "creating area"
westminster = Area.create!(name: "Westminster")

puts "creating user (trainer)"
user = User.create!(first_name: "Axel", last_name: "Manzano", email: "am@gmail.com", password: "123456", area: westminster)

puts "creating runners"
john = Runner.create!(email: "jd@gmail.com", first_name: "John", last_name: "Doe", status: "never_run", area: westminster, group_run: true, mission: false, coach_run: true)
elizabeth = Runner.create!(email: "thequeen@gmail.com", first_name: "Queen Elizabeth", last_name: "Windsor", status: "never_run", area: westminster, group_run: true, mission: false, coach_run: true)
sylvester = Runner.create!(email: "ss@gmail.com", first_name: "Sylvester", last_name: "Stallone", status: "never_run", area: westminster, group_run: true, mission: false, coach_run: true)
jeremy = Runner.create!(email: "jc@gmail.com", first_name: "Jeremy", last_name: "Corbyn", status: "never_run", area: westminster, group_run: true, mission: false, coach_run: true)
james = Runner.create!(email: "jb@gmail.com", first_name: "Mr. Bond", last_name: "007", status: "never_run", area: westminster, group_run: true, mission: false, coach_run: true)
henry = Runner.create!(email: "hc@gmail.com", first_name: "Henry", last_name: "Cavill", status: "lapsed", area: westminster, group_run: false, mission: true, coach_run: true)
arnold = Runner.create!(email: "as@gmail.com", first_name: "Arnold", last_name: "Schwarzenegger", status: "regular", area: westminster, group_run: true, mission: true, coach_run: false)
ellen = Runner.create!(email: "ed@gmail.com", first_name: "Ellen", last_name: "Degenneres", status: "never_run", area: westminster, group_run: false, mission: true, coach_run: false)
theresa = Runner.create!(email: "tm@gmail.com", first_name: "Theresa", last_name: "May", status: "lapsed", area: westminster, group_run: false, mission: true, coach_run: true)

puts "seed finished!"



