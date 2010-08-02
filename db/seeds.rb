require 'csv'

#create provinces
["Eastern Province", "Southern Province", "Northern Province", "Western Province", "Kigali"].each do |prov|
  Province.find_or_create_by_name prov
end

CSV.open(File.join(RAILS_ROOT, 'db/fixtures/districts.csv'), 'r', ';') do |row|
  district = District.find_or_create_by_name row[1]
  district.province = Province.find_by_name row[0]
  district.save
end

CSV.open(File.join(RAILS_ROOT, 'db/fixtures/sectors.csv'), 'r', ';') do |row|
  sector = Sector.find_or_create_by_name row[1]
  sector.district = District.find_by_name row[0]
  sector.save
end