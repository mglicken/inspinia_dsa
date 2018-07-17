class Qofe < ActiveRecord::Base
validates :deal, :presence => true

belongs_to :deal
has_many :qofe_slides, :dependent => :destroy
has_many :slides, :through => :qofe_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |qoves|
				csv << qoves.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name","deal_id", "qofe_date", "image_id"]
		CSV.foreach(file.path,headers: true) do |row|
			qoves = find_by_id(row["id"]) || new
			
			qoves.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			qoves.save
		end
	end	
end