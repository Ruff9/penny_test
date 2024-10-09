# $ rails recipes:import

namespace :recipes do
  desc 'import english recipes to database'
  task import: :environment do
    source_file = File.read(File.expand_path("#{Rails.root}/seed_data/recipes-en.json", __FILE__))

    RecipeImporter.perform(source_file)

    puts "#{Recipe.count} recipes imported in database"
  end
end
