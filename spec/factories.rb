include Faker

FactoryGirl.define do
    factory :batch do
        transient do
            bottle_qty 1
        end
        qty {bottle_qty}
    end # batch

    factory :bottle do

        code do
            numbers_letters = (0..9).map {|i| i.to_s} + (65..90).map{|c| c.chr }
            all_codes = Bottle.all.pluck :code
            while true
                possible_code = Lorem.characters(6).upcase
                break if !all_codes.include? possible_code
            end
            possible_code
        end
        forever false
        batch

    end # bottle


    factory :donation do
        user
        place
        bottle
        store {StarWars.planet}

    end #donation

    factory :place do
        code {Lorem.characters(3)}
        name {StarWars.planet}
        state {Boolean.boolean(0.2)}
        active {Boolean.boolean(0.5)}
        blurb {Lorem.sentence}
    end # place

    factory :user do
        email {Internet.email}
        password {Internet.password}

        factory :reg_user do
            role 0
        end

        factory :admin do
            role 1
        end

    end # user

end
