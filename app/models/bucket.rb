class Bucket < ActiveRecord::Base
validates :title, :presence => true

belongs_to :nbp
has_many :nbp_companies

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |buckets|
				csv << buckets.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "title", "nbp_id", "rationale"]
		CSV.foreach(file.path,headers: true) do |row|
			buckets = find_by_id(row["id"]) || new
			
			buckets.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			buckets.save
		end
	end	
end