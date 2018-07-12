class Mp < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

	belongs_to :deal
	has_many :mp_slides, :dependent => :destroy
	has_many :slides, :through => :mp_slides, :dependent => :destroy
	has_many :mp_sponsors, :dependent => :destroy
	has_many :sponsors, :through => :mp_sponsors
	has_many :mp_companies, :dependent => :destroy
	has_many :companies, :through => :mp_companies

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |mps|
				csv << mps.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "mp_date","image_id","name", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			mps = find_by_id(row["id"]) || new
			
			mps.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			mps.save
		end
	end
	def self.import_acquirers(file, mp_id = 1)
		@data = CSV.read(file.path, headers: true)
		mp = Mp.find(mp_id) 
		@data.each do |data|
			if data["Acquirer"].present?
				mp.mp_sponsors.each do |mp_sponsor|
					if	mp_sponsor.sponsor.name.downcase.include? data["Acquirer"].downcase
						if mp_sponsor.loi.present?
							loi = mp_sponsor.loi
							loi.loi_date = data["loi_date"]
							loi.enterprise_value = data["enterprise_value"]
							loi.save
							mp_sponsor.loi.loi_highlights.each do |loi_highlight|
								loi_highlight.detail = data[loi_highlight.highlight.name]
								if loi_highlight.detail.present? && loi_highlight.detail.length > 1 
									loi_highlight.detail = loi_highlight.detail[0].capitalize + loi_highlight.detail[1..-1]
								else
									loi_highlight.detail = "N/A"
								end
								loi_highlight.save
							end
						end
					end
				end
				mp.mp_companies.each do |mp_company|
					if	mp_company.company.name.downcase.include? data["Acquirer"].downcase
						if mp_company.loi.present?
							loi = mp_company.loi
							loi.loi_date = data["loi_date"]
							loi.enterprise_value = data["enterprise_value"]
							loi.save
							mp_company.loi.loi_highlights.each do |loi_highlight|
								loi_highlight.detail = data[loi_highlight.highlight.name]
								if loi_highlight.detail.present? && loi_highlight.detail.length > 1 
									loi_highlight.detail = loi_highlight.detail[0].capitalize + loi_highlight.detail[1..-1]
								else
									loi_highlight.detail = "N/A"
								end
								loi_highlight.save
							end
						end
					end
				end
			end
		end
		return @data["loi_date"]
	end	
end