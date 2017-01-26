# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create all of the places per topojson files

# create countries
countries_file = File.read(Rails.root.join('public', 'json', 'countries.topo.json'))
countries_hash = JSON.parse(countries_file)
countries_hash["objects"]["countries"]["geometries"].each do |g|

  place_id = g['id']
  name = g['properties']['name']
  Place.create!({:code => place_id,
    :name => name,
    :state => false
  })
  puts "created #{place_id}: #{name}"

end

# create states
states_file = File.read(Rails.root.join('public', 'json', 'states_usa.topo.json'))
states_hash = JSON.parse(states_file)
states_hash["objects"]["states"]["geometries"].each do |g|

  place_id = g['id']
  name = g['properties']['name']

  Place.create!({:code => place_id,
    :name => name,
    :state => true,
    :active => true
  })
  puts "created #{place_id}: #{name}"
end
