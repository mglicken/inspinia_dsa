class Nda < ActiveRecord::Base
	validates :name, :presence => true
	validates :deal, :presence => true

	belongs_to :deal

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |ndas|
				csv << ndas.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "deal_id", "nda_date","image_id","status", "status_date"]
		CSV.foreach(file.path,headers: true) do |row|
			ndas = find_by_id(row["id"]) || new
			
			ndas.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			ndas.save
		end
	end	
end