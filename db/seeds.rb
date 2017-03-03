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
