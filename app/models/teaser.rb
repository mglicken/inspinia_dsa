class Teaser < ActiveRecord::Base
belongs_to :deal
has_many :teaser_slides, :dependent => :destroy
has_many :slides, :through => :teaser_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |teasers|
				csv << teasers.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "teaser_date","image_id","name"]
		CSV.foreach(file.path,headers: true) do |row|
			teasers = find_by_id(row["id"]) || new
			
			teasers.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			teasers.save
		end
	end	
end