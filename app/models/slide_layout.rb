class SlideLayout < ActiveRecord::Base
belongs_to :deal
belongs_to :user
has_many :slide_layout_slides, :dependent => :destroy
has_many :slides, :through => :slide_layout_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |slide_layouts|
				csv << slide_layouts.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "user_id","deal_id","date"]
		CSV.foreach(file.path,headers: true) do |row|
			slide_layouts = find_by_id(row["id"]) || new
			
			slide_layouts.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			slide_layouts.save
		end
	end	
end