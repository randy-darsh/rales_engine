require 'csv'

desc "Import all csv data"
  task :import => [:environment] do
    merchants = "db/merchants.csv"
    CSV.foreach(merchants, headers: true) do |row|
      Merchant.create({
        name:  row[1],
        created_at: row[2],
        updated_at: row[3]
      })
    end

end
