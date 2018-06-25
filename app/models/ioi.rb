class Ioi < ActiveRecord::Base
	validates :name, :presence => true
	validates :deal, :presence => true

	belongs_to :deal
	has_many :ioi_slides, :dependent => :destroy
	has_many :slides, :through => :ioi_slides, :dependent => :destroy
	has_one :cip_sponsor
	has_one :sponsor, :through => :cip_sponsor
	has_one :cip_company
	has_one :company, :through => :cip_company
	has_many :ioi_highlights, :dependent => :destroy
	has_many :highlights, :through => :ioi_highlights
	
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |iois|
				csv << iois.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "deal_id", "ioi_date","image_id","low_purchase_price","high_purchase_price"]
		CSV.foreach(file.path,headers: true) do |row|
			iois = find_by_id(row["id"]) || new
			
			iois.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			iois.save
		end
	end	
end