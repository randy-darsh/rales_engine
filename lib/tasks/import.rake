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
    transactions = "db/transactions.csv"
    CSV.foreach(transactions, headers: true) do |row|
      Transaction.create({
        invoice_id: row[1],
        credit_card_number: row[2],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      })
    end
    customers = "db/customers.csv"
    CSV.foreach(customers, headers: true) do |row|
      Customer.create({
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      })
    end
end
