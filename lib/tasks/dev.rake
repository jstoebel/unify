if Rails.env.development? || Rails.env.test?
  require "factory_girl"

  namespace :dev do
    desc "Sample data for local development environment"

    task prime: "db:setup" do
      # starts by reloading the database and loading seeds
      include FactoryGirl::Syntax::Methods

      puts "creating an admin..."
      create(:user, email: "admin@admin.com", password: "123456", role: 1)

      # make US and Brazil active
      puts "activating places..."
      ["USA", "BRA"].each do |place_code|
        place = Place.find_by :code => place_code
        place.active = true
        place.blurb = Lorem.sentence(2)
        place.save!
      end


      puts "creating a bottle..."
      FactoryGirl.create :bottle


    end
  end
end
