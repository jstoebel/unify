
task :create_admin => :environment do
  desc "Create an admin user"
  cli = HighLine.new

  email = cli.ask("Please enter a user email")
  password =  cli.ask("Enter your password:  ") { |q| q.echo = false }
  User.create!(:email => email, :password => password, :role => 1)
  puts "User created!"
end
