require 'csv'

namespace :import do 
  desc "Import merchants from csv"

  task merchants: :environment do 
    filename = File.join Rails.root, "db/merchants.csv"
    CSV.foreach(filename) do |row|
      name, created_at, updated_at = row
      Merchant.create(name: name, created_at: created_at, updated_at: updated_at)
    end
  end
end
