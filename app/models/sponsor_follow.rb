class SponsorFollow < ActiveRecord::Base
validates_uniqueness_of :user_id, :scope => :sponsor_id

belongs_to :sponsor
belongs_to :user

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |sponsor_follows|
				csv << sponsor_follows.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "sponsor_id", "user_id"]
		CSV.foreach(file.path,headers: true) do |row|
			sponsor_follows = find_by_id(row["id"]) || new
			
			sponsor_follows.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			sponsor_follows.save
		end
	end	
end