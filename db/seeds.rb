return unless Rails.env == "development"

system 'clear'

puts 'Destroy all records'
puts '*' * 80

Product.destroy_all

puts 'Create new records'
puts '*' * 80

MAX_PODUCTS = 70

print '.'

MAX_PODUCTS.times do
  name = Faker::Name.unique.name
  description = Faker::Company.catch_phrase
  Product.create!(name: name, description: description)
  print '.'
end

puts ' '
puts ' '
puts "That's all folks!"
puts '*' * 80
p "Created #{Product.count} #{'product'.pluralize(Product.count)}"
