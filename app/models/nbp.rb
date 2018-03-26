class Nbp < ActiveRecord::Base
belongs_to :deal
has_many :nbp_slides, :dependent => :destroy
has_many :buckets, :dependent => :destroy
has_many :slides, :through => :nbp_slides, :dependent => :destroy
has_many :nbp_sponsors, :dependent => :destroy
has_many :sponsors, :through => :nbp_sponsors
has_many :nbp_companies, :dependent => :destroy
has_many :companies, :through => :nbp_companies

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbps|
				csv << nbps.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "nbp_date","image_id","name"]
		CSV.foreach(file.path,headers: true) do |row|
			nbps = find_by_id(row["id"]) || new
			
			nbps.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbps.save
		end
	end	
end