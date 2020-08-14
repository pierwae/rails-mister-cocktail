# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'csv'

puts '[1/3] Cleaning everything...'

Cocktail.all.each do |cocktail|
  cocktail.destroy
end

Dose.all.each do |dose|
  dose.destroy
end

Ingredient.all.each do |ingredient|
  ingredient.destroy
end

puts '[1/3] Finished!'

puts '[2/3] Loading ingredients data...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
serialized_drinks = open(url).read
drinks = JSON.parse(serialized_drinks)

puts '[2/3] Creating a lot of ingredients...'

drinks['drinks'].each do |drink|
  Ingredient.create(name: drink['strIngredient1'])
end

puts '[2/3] Finished!'

puts '[3/3] Creating 18 fake cocktails...'

csv_options = { col_sep: ',', quote_char: "'" }
filepath    = Rails.root.join('db/data_seeds.csv')

CSV.foreach(filepath, csv_options) do |row|
  Cocktail.create(name: row[0], picture: row[1])
end

# data =
# [['Long Island Iced Tea', 'https://images.unsplash.com/photo-1583898350903-99fa829dad3d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Gin fizz', 'https://images.unsplash.com/photo-1527271982979-83fea3eb3582?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
# ['Singapour sling', 'https://images.unsplash.com/photo-1560963689-b5682b6440f8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Bellini', 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Cosmopolitan', 'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Bloody mary', 'https://images.unsplash.com/photo-1560508179-b2c9a3f8e92b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Margarita', 'https://images.unsplash.com/photo-1486428263684-28ec9e4f2584?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Tequila sunrise', 'https://images.unsplash.com/photo-1566284628402-3f0895b3eb28?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Cuba libre', 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Mojito', 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Caïpirinha', 'https://images.unsplash.com/photo-1536599424071-0b215a388ba7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Piña colada', 'https://images.unsplaash.com/photo-1558645836-e44122a743ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Daiquiri', 'https://images.unsplash.com/photo-1512103865222-dcf9531c9961?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Kir', 'https://images.unsplash.com/photo-1562708294-4df93280352d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Americano', 'https://images.unsplash.com/photo-1549746423-e5fe9cafded8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
# ['Martini', 'https://images.unsplash.com/photo-1510626176961-4b57d4fbad03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Manhattan', 'https://images.unsplash.com/photo-1499638673689-79a0b5115d87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'],
# ['Agua de Valencia', 'https://images.unsplash.com/photo-1506802913710-40e2e66339c9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60']]

# data.each do |row|
#   Cocktail.create(name: row[0], picture: row[1])
# end

puts '[3/3] Finished!'
