require 'open-uri'
namespace :product do
  desc 'Convert image url to attachment'
  task convert_image: :environment do
    Product.find_each do |p|
      begin
        p.image = open(p.image_url)
        p.save
      rescue StandardError => e
        p e.message
        next
      end
    end
  end
end
