class Subsidiary < ActiveRecord::Base
	validates :parent_id, :presence => true, :uniqueness => {:scope => :child_id} 
	validates :child_id, :presence => true, :uniqueness => {:scope => :parent_id} 


	belongs_to :parent, class_name: "Company", foreign_key: "parent_id"
	belongs_to :child, class_name: "Company", foreign_key: "child_id"

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |subsidiaries|
				csv << subsidiaries.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "parent_id", "child_id","acquisition_date","acquisition_price", "link"]
		CSV.foreach(file.path,headers: true) do |row|
			subsidiaries = find_by_id(row["id"]) || new
			
			subsidiaries.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			subsidiaries.save
		end
	end
end