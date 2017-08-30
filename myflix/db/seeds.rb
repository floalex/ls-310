# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# run `rake db:seed` to create the data

# personally prefer to use find_ot_create_by to only seed the post if it doesn't already exist

puts "#{Video.count} videos"
Video.find_or_create_by(
  id: 1,
  title: "Family Guy",
  description: "Sick, twisted and politically incorrect, 
  the animated series features the adventures of the Griffin family. Endearingly ignorant 
  Peter and his stay-at-home wife Lois reside in Quahog, R.I., and have three kids. Meg, 
  the eldest child, is a social outcast, and teenage Chris is awkward and clueless when it 
  comes to the opposite sex. The youngest, Stewie, is a genius baby bent on killing his 
  mother and destroying the world. The talking dog, Brian, keeps Stewie in check while sipping 
  martinis and sorting through his own life issues.",
  small_cover_url: "/tmp/family_guy.jpg", 
  large_cover_url: "/tmp/family_guy.jpg",
  category_id: 1
)
Video.find_or_create_by(
  id: 2,
  title: "Futurama",
  description: "Accidentally frozen, pizza-deliverer Fry wakes up 1,000 
  years in the future. He is taken in by his sole descendant, an elderly and addled scientist who owns 
  a small cargo delivery service. Among the other crew members are Capt. Leela, accountant Hermes, 
  intern Amy, obnoxious robot Bender and lobsterlike moocher Dr Zoidberg.",
  small_cover_url: "/tmp/futurama.jpg",
  large_cover_url: "/tmp/futurama.jpg",
  category_id: 1
)
Video.find_or_create_by(
  id: 3,
  title: 'Monk',
  description: 'Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk.',
  small_cover_url: '/tmp/monk.jpg',
  large_cover_url: '/tmp/monk_large.jpg',
  category_id: 1
)
Video.find_or_create_by(
  id: 4,
  title: "South Park", 
  description: "Funny Cartoon for adults", 
  small_cover_url: "/tmp/south_park.jpg", 
  large_cover_url: "/tmp/south_park.jpg",
  category_id: 1
)
Video.find_or_create_by(
  id: 5,
  title: 'Wonder Woman',
  description: 'Before she was Wonder Woman, she was Diana, princess of the Amazons, trained warrior. When a pilot crashes and tells of conflict in the outside world, she leaves home to fight a war, discovering her full powers and true destiny.',
  small_cover_url: '/tmp/wonderwoman.jpg',
  large_cover_url: '/tmp/wonderwoman.jpg',
  category_id: 2
)
puts "#{Video.count} videos"
  
puts "#{Category.count} categories"
Category.find_or_create_by(id: 1, name: 'TV')
Category.find_or_create_by(id: 2, name: 'Movies')
Category.find_or_create_by(id: 3, name: "Reality TV")
puts "#{Category.count} categories"