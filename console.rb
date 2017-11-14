require_relative('./models/bounty.rb')

bounty1 = Bounty.new(
{ 'name'=>'Peter',
  'species'=>'martian',
  'value'=> 10,
  'location'=>'Mars'
}
)

bounty2 = Bounty.new(
{ 'name'=>'Mark',
  'species'=>'alien',
  'value'=> 20,
  'location'=>'Jupiter'
}
)
#
# bounty1.save
# bounty1.delete
# bounty2.save
#
# bounty1.name = "Sheila"
# bounty1.location = "Earth"
# bounty1.value = 100
# bounty1.update
# Bounty.create('Jason', 'dinosaur', 25, 'brazil')
# p Bounty.return_by_id(14)
Bounty.update_location_by_id(14, 'Mauritius')

#Not working:
# Bounty.update_anything_by_id(14,'name', 'Sally')


# p Bounty.return_by_location("Mars")

nil
