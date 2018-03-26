class DealFollow < ActiveRecord::Base
validates_uniqueness_of :user_id, :scope => :deal_id

belongs_to :deal
belongs_to :user

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |deal_follows|
				csv << deal_follows.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "user_id"]
		CSV.foreach(file.path,headers: true) do |row|
			deal_follows = find_by_id(row["id"]) || new
			
			deal_follows.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			deal_follows.save
		end
	end	
end