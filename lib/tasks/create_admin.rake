
task :create_admin => :environment do
  desc "Create an admin user"

  puts "Please enter a user email"
  email = STDIN.gets.chomp
  puts "Please enter a password"
  password = STDIN.gets.chomp
  User.create!(:email => email, :password => password, :role => 1)
  puts "User created!"
end
