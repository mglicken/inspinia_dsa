class TeaserSponsor < ActiveRecord::Base
validates_uniqueness_of :teaser_id, :scope => :sponsor_id
belongs_to :teaser
belongs_to :sponsor
belongs_to :nda

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |teaser_sponsors|
				csv << teaser_sponsors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "teaser_id", "sponsor_id", "nda_id"]
		CSV.foreach(file.path,headers: true) do |row|
			teaser_sponsors = find_by_id(row["id"]) || new
			
			teaser_sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			teaser_sponsors.save
		end
	end	

end