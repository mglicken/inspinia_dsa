class Loi < ActiveRecord::Base
	validates :name, :presence => true
	validates :deal, :presence => true

	belongs_to :deal
	has_many :loi_slides, :dependent => :destroy
	has_many :slides, :through => :loi_slides, :dependent => :destroy
	has_one :cip_sponsor
	has_one :sponsor, :through => :cip_sponsor
	has_one :cip_company
	has_one :company, :through => :cip_company
	has_many :loi_highlights, :dependent => :destroy
	has_many :highlights, :through => :loi_highlights
	
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |lois|
				csv << lois.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "deal_id", "loi_date","image_id","low_purchase_price","high_purchase_price"]
		CSV.foreach(file.path,headers: true) do |row|
			lois = find_by_id(row["id"]) || new
			
			lois.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			lois.save
		end
	end	
end