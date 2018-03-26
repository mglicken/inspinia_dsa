class CompanyFollow < ActiveRecord::Base
validates_uniqueness_of :user_id, :scope => :company_id

belongs_to :company
belongs_to :user

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |company_follows|
				csv << company_follows.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "company_id", "user_id"]
		CSV.foreach(file.path,headers: true) do |row|
			company_follows = find_by_id(row["id"]) || new
			
			company_follows.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			company_follows.save
		end
	end	
end