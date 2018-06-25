class LoiHighlight < ActiveRecord::Base
validates_uniqueness_of :highlight_id, scope: :loi_id

belongs_to :highlight
belongs_to :loi

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |loi_highlights|
				csv << loi_highlights.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "highlight_id", "loi_id", "detail"]
		CSV.foreach(file.path,headers: true) do |row|
			loi_highlights = find_by_id(row["id"]) || new
			
			loi_highlights.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			loi_highlights.save
		end
	end	
end