class DealStage < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	has_many :deals

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |deal_stages|
				csv << deal_stages.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name"]
		CSV.foreach(file.path,headers: true) do |row|
			deal_stages = find_by_id(row["id"]) || new
			
			deal_stages.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			deal_stages.save
		end
	end	

end