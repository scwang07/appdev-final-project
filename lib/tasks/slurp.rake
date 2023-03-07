namespace :slurp do
  desc "TODO"
  task restaurants: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "yelp_checkins_cleaned.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      t = Restaurant.new
      t.name = row["name"]
      t.location = row["location"]
      t.save
    end
  end

end
