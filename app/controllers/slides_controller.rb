class SlidesController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :import]
before_action :ensure_banker_access,  only: [:new, :create, :edit, :update, :destroy]
before_action :ensure_view_access,  only: [:show, :search]

  def ensure_admin_access
    if current_user.access_id.present?
      if current_user.access_id > 2
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def ensure_banker_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def ensure_view_access
    if current_user.access_id.present?
      if current_user.access_id > 4
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @slides = Slide.all

    respond_to do |format|
      format.html
      format.csv {send_data @slides.to_csv }
    end
  end

  def show
    @slide = Slide.find(params[:id].to_i)
    @tags = Tag.all.order("name ASC")
    if @slide.nbp.present?
      @nbp = @slide.nbp
      @image_id = @nbp.image_id
    else
      @nbp = Nbp.none
    end
    if @slide.nda.present?
      @nda = @slide.nda
      @image_id = @nda.image_id
    else
      @nda = Nda.none
    end
    if @slide.cip.present?
      @cip = @slide.cip
      @image_id = @cip.image_id
    else
      @cip = Cip.none
    end
    if @slide.ioi.present?
      @ioi = @slide.ioi
      @image_id = @ioi.image_id
    else
      @ioi = Ioi.none
    end
    if @slide.mp.present?
      @mp = @slide.mp
      @image_id = @mp.image_id
    else
      @mp = Mp.none
    end
    if @slide.loi.present?
      @loi = @slide.loi
      @image_id = @loi.image_id
    else
      @loi = Loi.none
    end
    if @slide.teaser.present?
      @teaser = @slide.teaser
      @image_id = @teaser.image_id
    else
      @teaser = Teaser.none
    end  
    if @slide.case_study.present?
      @case_study = @slide.case_study
      @image_id = @case_study.image_id
    else
      @case_study = CaseStudy.none
    end  
    if @slide.market_study.present?
      @market_study = @slide.market_study
      @image_id = @market_study.image_id
    else
      @market_study = MarketStudy.none
    end 
      if @slide.qofe.present?
      @qofe = @slide.qofe
      @image_id = @qofe.image_id
    else
      @qofe = Qofe.none
    end
  end

  def search
    @text = params[:search].downcase
    @tag_ids = []
    Tag.all.each do |tag|
      if tag.name.downcase.include? @text
        @tag_ids.push(tag.id)
      end
    end
    @nbp_ids = []
    Nbp.all.each do |nbp|
      if nbp.name.downcase.include? @text
        @nbp_ids.push(nbp.id)
      end
    end
    @cip_ids = []
    Cip.all.each do |cip|
      if cip.name.downcase.include? @text
        @cip_ids.push(cip.id)
      end
    end

    @mp_ids = []
    Mp.all.each do |mp|
      if mp.name.downcase.include? @text
        @mp_ids.push(mp.id)
      end
    end
    @slide_ids = (SlideTag.where(tag_id: @tag_ids).pluck(:slide_id) + NbpSlide.where(nbp_id: @nbp_ids).pluck(:slide_id) + CipSlide.where(cip_id: @cip_ids).pluck(:slide_id) + MpSlide.where(mp_id: @mp_ids).pluck(:slide_id)).uniq
    @slides = Slide.where(id: @slide_ids)
    
  end

  def new
    @slide = Slide.new
  end

  def create
    @slide = Slide.new


    @slide.image_url = params[:image_url]
    @slide.number = params[:number]
    @slide.ppt_address = params[:ppt_address]

    if @slide.save
      redirect_to "/slides", :notice => "Slide created successfully."
    else
      render 'new'
    end
  end
  
  def create_nbp_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/c_scale,h_255,w_330/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      nbp_slide = NbpSlide.new
      nbp_slide.nbp_id = params[:nbp_id]
      nbp_slide.slide_id = slide.id
      nbp_slide.save
      slide.ppt_address = nbp_slide.nbp.ppt_address
  
      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "NBP").id
      slide_tag.save

    end
    nbp_slide.nbp.image_id = public_id
    if slide.save
      nbp_slide.nbp.save
      redirect_to "/nbps/#{nbp_slide.nbp_id}", :notice => "NBP slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_nda_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      nda_slide = NdaSlide.new
      nda_slide.nda_id = params[:nda_id]
      nda_slide.slide_id = slide.id
      nda_slide.save


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "NDA").id
      slide_tag.save

    end
    nda_slide.nda.image_id = public_id
    if slide.save
      nda_slide.nda.save
      redirect_to "/ndas/#{nda_slide.nda_id}", :notice => "NDA slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_teaser_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      teaser_slide = TeaserSlide.new
      teaser_slide.teaser_id = params[:teaser_id]
      teaser_slide.slide_id = slide.id
      teaser_slide.save
      slide.ppt_address = teaser_slide.teaser.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "Teaser").id
      slide_tag.save

    end
    teaser_slide.teaser.image_id = public_id
    if slide.save
      teaser_slide.teaser.save
      redirect_to "/teasers/#{teaser_slide.teaser_id}", :notice => "Teaser slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_cip_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/c_scale,h_255,w_330/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      cip_slide = CipSlide.new
      cip_slide.cip_id = params[:cip_id]
      cip_slide.slide_id = slide.id
      cip_slide.save
      slide.ppt_address = cip_slide.cip.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "CIP").id
      slide_tag.save        

    end
    cip_slide.cip.image_id = public_id
    if slide.save
      cip_slide.cip.save
      redirect_to "/cips/#{cip_slide.cip_id}", :notice => "CIP slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_ioi_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      ioi_slide = IoiSlide.new
      ioi_slide.ioi_id = params[:ioi_id]
      ioi_slide.slide_id = slide.id
      ioi_slide.save

      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "IOI").id
      slide_tag.save

    end
    ioi_slide.ioi.image_id = public_id
    if slide.save
      ioi_slide.ioi.save
      redirect_to "/iois/#{ioi_slide.ioi_id}", :notice => "IOI slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_mp_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/c_scale,h_255,w_330/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      mp_slide = MpSlide.new
      mp_slide.mp_id = params[:mp_id]
      mp_slide.slide_id = slide.id
      mp_slide.save  
      slide.ppt_address = mp_slide.mp.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "MP").id
      slide_tag.save

    end
    mp_slide.mp.image_id = public_id
    if slide.save
      mp_slide.mp.save
      redirect_to "/mps/#{mp_slide.mp_id}", :notice => "MP slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_loi_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      loi_slide = LoiSlide.new
      loi_slide.loi_id = params[:loi_id]
      loi_slide.slide_id = slide.id
      loi_slide.save


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "LOI").id
      slide_tag.save

    end
    loi_slide.loi.image_id = public_id
    if slide.save
      loi_slide.loi.save
      redirect_to "/lois/#{loi_slide.loi_id}", :notice => "LOI slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

   def create_case_study_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      case_study_slide = CaseStudySlide.new
      case_study_slide.case_study_id = params[:case_study_id]
      case_study_slide.slide_id = slide.id
      case_study_slide.save
      slide.ppt_address = case_study_slide.case_study.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "Case Study").id
      slide_tag.save

    end
    case_study_slide.case_study.image_id = public_id
    if slide.save
      case_study_slide.case_study.save
      redirect_to "/case_studies/#{case_study_slide.case_study_id}", :notice => "Case Study Slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_market_study_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      market_study_slide = MarketStudySlide.new
      market_study_slide.market_study_id = params[:market_study_id]
      market_study_slide.slide_id = slide.id
      market_study_slide.save
      slide.ppt_address = market_study_slide.market_study.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "Market Study").id
      slide_tag.save

    end
    market_study_slide.market_study.image_id = public_id
    if slide.save
      market_study_slide.market_study.save
      redirect_to "/market_studies/#{market_study_slide.market_study_id}", :notice => "Market Study Slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def create_qofe_slides
    public_id = Cloudinary::Api.resources(type:"upload")["resources"].first["public_id"]
    pdf_len = Cloudinary::Api.resource( public_id , pages: true)["pages"].to_i


    for i in 0..(pdf_len-1)
      slide = Slide.new
      slide.number = i+1
      slide.image_url = "http://res.cloudinary.com/mglicken/image/upload/f_jpg,pg_#{ i+1 }/#{ public_id }.pdf"
      slide.save
      
      qofe_slide = MarketStudySlide.new
      qofe_slide.qofe_id = params[:qofe_id]
      qofe_slide.slide_id = slide.id
      qofe_slide.save
      slide.ppt_address = qofe_slide.qofe.ppt_address


      slide_tag = SlideTag.new
      slide_tag.slide_id = slide.id
      slide_tag.tag_id = Tag.find_by(name: "QofE").id
      slide_tag.save

    end
    qofe_slide.qofe.image_id = public_id
    if slide.save
      qofe_slide.qofe.save
      redirect_to "/qoves/#{qofe_slide.qofe_id}", :notice => "QofE Slides uploaded successfully. Please start tagging slides to aid searches."
    else
      render 'new'
    end
  end

  def edit
    @slide = Slide.find(params[:id])
  end

  def update
    @slide = Slide.find(params[:id])

    @slide.image_url = params[:image_url]
    @slide.number = params[:number]
    @slide.ppt_address = params[:ppt_address]

    if @slide.save
      redirect_to "/slides/#{@slide.id}/", :notice => "Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @slide = Slide.find(params[:id])

    @slide.destroy

    redirect_to "/slides", :notice => "Slide deleted."
  end

  def import
    Slide.import(params[:file])
    redirect_to "/models/", notice: "Slides imported."
  end
end
