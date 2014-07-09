require 'csv'
namespace :communications do
  desc 'Import communications from csv'
  task import: :environment do
    begin
      CSV.foreach('db/csv/communications.csv', headers: true) do |row|
        puts "processing Communication #{row['title']}"
        record = Communication.find_or_initialize_by(title: row['title'])
        if category = Category.find_by(old_id: row['category_id'])
          puts "found Category #{category.name}"
          record.category = category
        else
          raise "category with old_id = #{row['category_id']} not found"
        end
        record.fichier_name = row['fichier_name']
        record.fichier_url = row['fichier_url']
        record.publication = Date.parse(row['publication'])
        record.state = 'published' if row['pd'] == 'oui'
        record.tag_list = row['tag_list'].split(';').join(', ')

        record.save!
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end

end
