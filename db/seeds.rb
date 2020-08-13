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
filepath    = '/Users/pierrewaechter/code/pierwae/rails-mister-cocktail/db/data_seeds.csv'

CSV.foreach(filepath, csv_options) do |row|
  Cocktail.create(name: row[0], picture: row[1])
end

puts '[3/3] Finished!'
