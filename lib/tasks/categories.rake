require 'csv'
namespace :categories do
  desc 'Import categories from csv'
  task import: :environment do
    begin
      CSV.foreach('db/csv/categories.csv', headers: true) do |row|
        puts "processing Category #{row["name"]}"
        record = Category.find_or_initialize_by(name: row['name'])
        record.old_id = row['old_id']

        record.save!
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end

end
