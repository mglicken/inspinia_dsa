class Slide < ActiveRecord::Base
	has_many :slide_tags, :dependent => :destroy
	has_many :tags, :through => :slide_tags
	has_many  :favorite_slides, :dependent => :destroy
	has_many :users, :through => :favorite_slides
	has_one  :nbp_slide, :dependent => :destroy
	has_one  :teaser_slide, :dependent => :destroy
	has_one  :nda_slide, :dependent => :destroy
	has_one  :cip_slide, :dependent => :destroy
	has_one  :ioi_slide, :dependent => :destroy
	has_one  :mp_slide, :dependent => :destroy
	has_one  :loi_slide, :dependent => :destroy
	has_one  :case_study_slide, :dependent => :destroy
	has_one  :market_study_slide, :dependent => :destroy
	has_one  :qofe_slide, :dependent => :destroy
	has_one :nbp, :through => :nbp_slide
	has_one :nda, :through => :nda_slide
	has_one :teaser, :through => :teaser_slide
	has_one :cip, :through => :cip_slide
	has_one :ioi, :through => :ioi_slide
	has_one :mp, :through => :mp_slide
	has_one :loi, :through => :loi_slide
	has_one :case_study, :through => :case_study_slide
	has_one :market_study, :through => :market_study_slide
	has_one :qofe, :through => :qofe_slide
	has_one :deal, :through => :nbp
	has_one :deal, :through => :cip
	has_one :deal, :through => :mp
	has_one :deal, :through => :teaser
	has_one :deal, :through => :case_study
	has_one :deal, :through => :market_study
	has_one :deal, :through => :qofe_study
	has_one :deal, :through => :ioi
	has_one :deal, :through => :loi
	has_one :deal, :through => :nda

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |slides|
				csv << slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "number", "image_url", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			slides = find_by_id(row["id"]) || new
			
			slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			slides.save
		end
	end	
end