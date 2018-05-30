class SlideLayoutsController < ApplicationController

before_action :ensure_admin_access,  only: [ :index, :import]
before_action :ensure_banker_access,  only: [ :new, :create, :create_pdf ,:show, :share_layout, :edit, :update, :destroy]
before_action :ensure_banker_user_access,  only: []

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

  def ensure_banker_user_access
    if current_user.access_id.present?
      if params[:user_id] !=  current_user.id
        redirect_to root_url, :alert => "Not Authorized"
      else
        if current_user.access_id > 3
          redirect_to root_url, :alert => "Not Authorized"
        end
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
    @slide_layouts = SlideLayout.all

    respond_to do |format|
      format.html
      format.csv {send_data @slide_layouts.to_csv }
    end
  end


  def show
    @slide_layout = SlideLayout.find(params[:id])
    @favorite_slides = current_user.favorite_slides
  end

  def new
    @slide_layout = SlideLayout.new
  end
 
  def create
    @slide_layout = SlideLayout.new
    @slide_ids = params[:slide_ids].split(",").map { |s| s.to_i }

    @slide_layout.name = params[:name]
    if @slide_layout.name == "" || @slide_layout.name.nil?
     redirect_to "/favorite_slides", :alert => "Slide Layout must have a name."      
    else
      @slide_layout.date = params[:date]
      @slide_layout.user_id = params[:user_id]
      @slide_layout.deal_id = params[:deal_id]
      
      if @slide_layout.save

      @slide_ids.each do |slide_id|
        sls = SlideLayoutSlide.new
        sls.slide_layout_id = @slide_layout.id
        sls.slide_id = slide_id
        sls.save
      end
        redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout created successfully."
      else
        render 'new'
      end
    end
  end

  def share_layout

    @slide_layout1 = SlideLayout.find(params[:slide_layout_id])
    @slide_layout2 = SlideLayout.new
    @user = Person.find(params[:person_id]).users.last
    if @user.nil?
      redirect_to "/slide_layout/#{@slide_layout1.id}", :alert => "Person does not have a user account. Layout cannot be shared."
    else
      @slide_layout2.name = @slide_layout1.name + " (#{current_user.person.name})"
      @slide_layout2.date = Date.today
      @slide_layout2.user_id = @user.id
      @slide_layout2.deal_id = @slide_layout1.deal_id
      if @slide_layout2.save

        @slide_layout1.slide_layout_slides.order("id ASC").each do |slide_layout_slide|
          sls = SlideLayoutSlide.new
          sls.slide_layout_id = @slide_layout2.id
          sls.slide_id = slide_layout_slide.slide_id
          sls.save
        end

        redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout shared with #{@user.person.name} successfully."
      else
        render 'new'
      end

    end
  end

  def create_pdf
    require 'combine_pdf'
    require 'net/http'

    @slide_layout = SlideLayout.find(params[:id])
    i=1
    @slide_layout.slides.each do |slide|
      #Cloudinary::Uploader.add_tag("slide_layout_#{@slide_layout.id}", "pg_#{slide.number}," , 'add')
      p_id = "slide_layout-#{@slide_layout.id},page-#{i}"
      pdf = CombinePDF.new
      url = "https://res.cloudinary.com/mglicken/image/upload/#{p_id}.pdf"

      if slide.teaser.present?
        Cloudinary::Uploader.upload('https://res.cloudinary.com/mglicken/image/upload/pg_#{slide.number}/#{slide.teaser.image_id}.pdf',
          tags: ["slide_layout_#{@slide_layout.id}"],
          cloud_name: 'mglicken',
          upload_preset: 'zq87ewvr',
          format:"pdf",
          public_id: p_id)

      elsif slide.nbp.present?
        Cloudinary::Uploader.upload("https://res.cloudinary.com/mglicken/image/upload/pg_#{slide.number}/#{slide.nbp.image_id}.pdf",
          tags: ["slide_layout_#{@slide_layout.id}"],
          cloud_name: 'mglicken',
          upload_preset: 'zq87ewvr',
          format:"pdf",
          public_id: p_id)

      elsif slide.cip.present?
        Cloudinary::Uploader.upload("https://res.cloudinary.com/mglicken/image/upload/pg_#{slide.number}/#{slide.cip.image_id}.pdf",
          tags: ["slide_layout_#{@slide_layout.id}"],
          cloud_name: 'mglicken',
          upload_preset: 'zq87ewvr',
          format:"pdf",
          public_id: p_id)

      elsif slide.mp.present?
        Cloudinary::Uploader.upload("https://res.cloudinary.com/mglicken/image/upload/pg_#{slide.number}/#{slide.mp.image_id}.pdf",
          tags: ["slide_layout_#{@slide_layout.id}"],
          cloud_name: 'mglicken',
          upload_preset: 'zq87ewvr',
          format:"pdf",
          public_id: p_id)

      elsif slide.case_study.present?           
        Cloudinary::Uploader.upload("https://res.cloudinary.com/mglicken/image/upload/pg_#{slide.number}/#{slide.case_study.image_id}.pdf",
          tags: ["slide_layout_#{@slide_layout.id}"],
          cloud_name: 'mglicken',
          upload_preset: 'zq87ewvr',
          format:"pdf",
          public_id: p_id)

      end
      i=i+1
    end

    Cloudinary::Uploader.multi("slide_layout_#{@slide_layout.id}", format:"zip")

    Cloudinary::Api.delete_resources_by_prefix("slide_layout")

    redirect_to "http://res.cloudinary.com/mglicken/image/multi/slide_layout_#{@slide_layout.id}.zip", :notice => "PDFs downloaded successfully."
  end

  def create_pptx
    require 'fileutils'
    require 'nokogiri'
    require 'zip'

    @slide_layout = SlideLayout.find(params[:id])
    
    #slide_layout folder creation
    FileUtils.mkdir_p "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/"

    #copy over temp_NBP directory (template) 
    FileUtils.cp_r "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/temp_NBP/XML/.", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/"
    
    #ppt/presentation.xml file
    presentation_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/ppt/presentation.xml"
    presentation_contents = File.open(presentation_file)
    @presentation_doc = Nokogiri::XML(presentation_contents)
    notesMasterIdLst = @presentation_doc.xpath('//p:notesMasterIdLst').first
    sldIdLst = Nokogiri::XML::Node.new "sldIdLst", @presentation_doc
    notesMasterIdLst.add_next_sibling(sldIdLst)
    sldId = Array.new(@slide_layout.slides.count)
    #ppt/_rels/presentation.xml.rels file
    rels_presentation_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/ppt/_rels/presentation.xml.rels"
    #docProps/app.xml file
    doc_props_app_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/docProps/app.xml"
    #XML/[Content_types].xml file
    ct_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/[Content_Types].xml"

    #counter through all slides
    i = 1
    tags = 1
    charts = 1
    embeddings = 1
    sls = 1
    media = 1
    content_types=[]
    slide_errors=[]
    #iterate through all slides
    @slide_layout.slides.each do |slide|
      #copy over /ppt/slides/ file
      FileUtils.cp_r "#{slide.ppt_address}/XML/ppt/slides/slide#{slide.number}.xml", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/XML/ppt/slides/slide#{i}.xml"
      #copy over /ppt/slides/rels/ file
      FileUtils.cp_r "#{slide.ppt_address}/XML/ppt/slides/_rels/slide#{slide.number}.xml.rels", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/XML/ppt/slides/_rels/slide#{i}.xml.rels"
      #clean relationships
      slide_rels_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/XML/ppt/slides/_rels/slide#{i}.xml.rels"
      slide_rels_contents = File.open(slide_rels_file)
      slide_rels_doc = Nokogiri::XML(slide_rels_contents)
      rels = slide_rels_doc.xpath('/').children.first.children
      rels.each do |rel|
        if rel.attributes.present?
          if rel.attributes['Type'].value.split('/').last == "chart"
            content_types.push(rel.attributes['Target'].value.split('.').last.downcase)
            FileUtils.cp_r "#{slide.ppt_address}/XML/ppt#{rel.attributes['Target'].value.split('..').last}", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/ppt/charts/chart#{charts}.#{content_types.last}"
            rel.attributes['Target'].value = "../charts/chart#{charts}.#{content_types.last}"
            #update ppt/charts/_rels file
            charts = charts + 1                    
          elsif rel.attributes['Type'].value.split('/').last == "image"
            content_types.push(rel.attributes['Target'].value.split('.').last.downcase)
            FileUtils.cp_r "#{slide.ppt_address}/XML/ppt#{rel.attributes['Target'].value.split('..').last}", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/ppt/media/image#{media}.#{content_types.last}"
            rel.attributes['Target'].value = "../media/image#{media}.#{content_types.last}"
            media = media + 1
          elsif rel.attributes['Type'].value.split('/').last == "slideLayout"
            length = rel.attributes['Target'].value.split('/').last.split('.').first.length
            if length > 12 
              if rel.attributes['Target'].value.split('/').last.split('.').first[11..(length-1)].to_i > 12
                rel.attributes['Target'].value = "../slideLayouts/slideLayout12.xml"
              end
            end
            sls = sls + 1
          elsif rel.attributes['Type'].value.split('/').last == "tags"
            FileUtils.cp_r "#{slide.ppt_address}/XML/ppt#{rel.attributes['Target'].value.split('..').last}", "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id }/XML/ppt/tags/tag#{tags}.xml"
            rel.attributes['Target'].value = "../tags/tag#{tags}.xml"
            tags = tags + 1
          end
        else
          slide_errors.push(i)
        end
      end
      #save slide/_rels/ file
      File.open(slide_rels_file, 'w') {|f| f.write(slide_rels_doc)}
      
      #update /ppt/powerpoint.xml file
      sldId[(i-1)] = Nokogiri::XML::Node.new "sldId", @presentation_doc
      sldId[(i-1)]['id'] = "#{255+i}"
      sldId[(i-1)]['r:id'] = "#{i+1}"
      sldIdLst.add_child(sldId[(i-1)])
      
      #update counter
      i = i + 1
    end
    i = i - 1
    @presentation_doc.xpath("//p:notesMasterId").first.attributes.first.second.value = "rId#{i+2}"
    #write to ppt/presentation.xml file
    File.open(presentation_file, 'w') {|f| f.write(@presentation_doc)}

    content_types = content_types.uniq

    #update /ppt/_rels/powerpoint.xml.rels file
    x1 = Nokogiri::XML('<?xml version = "1.0" encoding = "UTF-8" standalone ="yes"?>')
    builder1 = Nokogiri::XML::Builder.with(x1) do |xml|
      xml.Types(xmlns: "http://schemas.openxmlformats.org/package/2006/content-types"){

          xml.Default(Extension: "png", ContentType: "image/png"){}
          xml.Default(Extension: "emf", ContentType: "image/x-emf"){}
          xml.Default(Extension: "jpeg", ContentType: "image/jpeg"){}
          xml.Default(Extension: "rels", ContentType: "application/vnd.openxmlformats-package.relationships+xml"){}
          xml.Default(Extension: "xml", ContentType: "application/xml"){}
          xml.Default(Extension: "wdp", ContentType: "image/vnd.ms-photo"){}
          xml.Default(Extension: "gif", ContentType: "image/gif"){}
          xml.Default(Extension: "xlsx", ContentType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"){}
          xml.Default(Extension: "jpg", ContentType: "image/jpeg"){}
          xml.Override(PartName: "/ppt/presentation.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"){}
          xml.Override(PartName: "/ppt/slideMasters/slideMaster1.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"){}
          xml.Override(PartName: "/ppt/notesMasters/notesMaster1.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.notesMaster+xml"){}
          xml.Override(PartName: "/ppt/presProps.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.presProps+xml"){}
          xml.Override(PartName: "/ppt/viewProps.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.viewProps+xml"){}
          xml.Override(PartName: "/ppt/theme/theme1.xml", ContentType: "application/vnd.openxmlformats-officedocument.theme+xml"){}
          xml.Override(PartName: "/ppt/theme/theme2.xml", ContentType: "application/vnd.openxmlformats-officedocument.theme+xml"){}
          xml.Override(PartName: "/ppt/tableStyles.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.tableStyles+xml"){}
          xml.Override(PartName: "/docProps/core.xml", ContentType: "application/vnd.openxmlformats-package.core-properties+xml"){}
          xml.Override(PartName: "/docProps/app.xml", ContentType: "application/vnd.openxmlformats-officedocument.extended-properties+xml"){}
          
          for j in 1..i do
            xml.Override(PartName: "/ppt/slides/slide#{j}.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"){}
          end
          for j in 1..12 do
            xml.Override(PartName: "/ppt/slideLayouts/slideLayout#{j}.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"){}
          end
          for j in 1..tags do
            xml.Override(PartName: "/ppt/tags/tag#{j}.xml", ContentType: "application/vnd.openxmlformats-officedocument.presentationml.tags+xml"){}
          end
          for j in 1..charts do
            xml.Override(PartName: "/ppt/charts/chart#{j}.xml", ContentType: "application/vnd.openxmlformats-officedocument.drawingml.chart+xml"){}
          end
      }
    end
    #write to XML/[Content_Types].xml file
    File.open(ct_file, 'w') {|f| f.write(builder1.to_xml) }

    #counter through all slides
    i = 1
    
    #update /ppt/_rels/powerpoint.xml.rels file
    x2 = Nokogiri::XML('<?xml version = "1.0" encoding = "UTF-8" standalone ="yes"?>')
    builder2 = Nokogiri::XML::Builder.with(x2) do |xml|
      xml.Relationships(xmlns: "http://schemas.openxmlformats.org/package/2006/relationships"){
       @slide_layout.slides.each do |relationship|
          xml.Relationship(Id: "rId#{i+1}",Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", Target: "slides/slide#{i}.xml"){}
          #update counter
          i = i + 1
        end
        i= i - 1
        xml.Relationship(Id: "rId#{1}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster", Target: "slideMasters/slideMaster1.xml"){}
        xml.Relationship(Id: "rId#{i+2}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesMaster", Target: "notesMaster/notesMaster1.xml"){}
        xml.Relationship(Id: "rId#{i+3}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps", Target: "presProps.xml"){}
        xml.Relationship(Id: "rId#{i+4}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/viewProps", Target: "viewProps.xml"){}
        xml.Relationship(Id: "rId#{i+5}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme", Target: "theme/theme1.xml"){}
        xml.Relationship(Id: "rId#{i+6}", Type: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/tableStyles", Target: "tableStyles.xml"){}
      }
    end
    #write to ppt/_rels/presentation.xml.rels file
    File.open(rels_presentation_file, 'w') {|f| f.write(builder2.to_xml) }

    i = 1
    #update docProps/app.xml
    x3 = Nokogiri::XML('<?xml version = "1.0" encoding = "UTF-8" standalone ="yes"?>')
    builder3 = Nokogiri::XML::Builder.with(x3) do |xml|
      xml.Properties(xmlns: "http://schemas.openxmlformats.org/officeDocument/2006/extended-properties", 'xmlns:vt' => "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes" ){
        xml.Template("Slide Layout #{@slide_layout.id} Template"){}
        xml.Application("Microsoft Office PowerPoint"){}
        xml.PresentationFormat("On-screen Show (4:3)"){}
        xml.Slides("#{@slide_layout.slides.count}"){}
        xml.ScaleCrop("false"){}
        xml.HeadingPairs{
          xml.vector( size: "4", baseType: "variant"){
            xml['vt'].variant{
              xml['vt'].lpstr("Theme"){}
            }
            xml['vt'].variant{
              xml['vt'].i4("1"){}
            }
            xml['vt'].variant{
              xml['vt'].lpstr("Slide Titles"){}
            } 
            xml['vt'].variant{
              xml['vt'].i4("#{@slide_layout.slides.count}"){}
            }           
          }
        }
        xml.TitleOfParts{
          xml['vt'].vector(size: "#{@slide_layout.slides.count + 1}", baseType: "lpstr"){
            xml['vt'].lpstr("Slide Layout #{@slide_layout.id} Template"){}            
            @slide_layout.slides.each do |relationship|
              slide_file = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/XML/ppt/slides/slide#{i}.xml"
              slide_contents = File.open(slide_file)
              slide_doc = Nokogiri::XML(slide_contents)
              st = ""
              children = slide_doc.xpath('//p:ph')[0].parent.parent.parent.children.children.children.children
                children.each do |child|
                 st = st + child.text
                end
              xml['vt'].lpstr("#{st}"){}
              #update counter
              i = i + 1
            end
            i = i - 1
          }
        }

        xml.LinksUpToDate("false"){}
        xml.SharedDoc("false"){}
        xml.HyperlinksChanged("false"){}
        xml.AppVersion("16.0000"){}
      }
    end
    #write to ppt/_rels/presentation.xml.rels file
    File.open(doc_props_app_file, 'w') {|f| f.write(builder3.to_xml) }

    #Zip the directory
    directory = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/XML/" 
    zipfile_name = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/slide_layout_#{@slide_layout.id}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          Dir.chdir directory
          Dir.glob("**/*").reject {|fn| File.directory?(fn) }.each do |file|
            zipfile.add(file.sub(directory + '/', ''), file)
          end
          zipfile.rename('_rels/a.rels', '_rels/.rels')
    end
    #convert to powerpoint 
    zip_name = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/slide_layout_#{@slide_layout.id}.zip"
    pptx_name = "C:/Users/Michael Glicken/Dropbox/Michael/dev/_test/slide_layout_#{@slide_layout.id}/slide_layout_#{@slide_layout.id}.pptx"
    FileUtils.mv zip_name, pptx_name
 
    redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout PPTX Created. #{slide_errors} /// #{content_types}"
  end

  def edit
    @slide_layout = SlideLayout.find(params[:id])
  end

  def update
    @slide_layout = SlideLayout.find(params[:id])

    @slide_ids = params[:slide_ids].split(",").map { |s| s.to_i }

    @slide_layout.name = params[:name]
    @slide_layout.date = params[:date]
    @slide_layout.user_id = params[:user_id]
    @slide_layout.deal_id = params[:deal_id]
    slide_number = 0
    if @slide_ids.count > @slide_layout.slides.count
      @slide_ids.each do |slide_id|
        if slide_number <= (@slide_layout.slides.count-1)
          sls = @slide_layout.slide_layout_slides.order("id ASC")[slide_number]
          sls.slide_id = slide_id
          sls.save
          slide_number = slide_number + 1
        else
          sls = SlideLayoutSlide.new
          sls.slide_layout_id = @slide_layout.id
          sls.slide_id = slide_id
          sls.save
          slide_number = slide_number + 1
        end
      end
    else
      @slide_layout.slide_layout_slides.order("id ASC").each do |sls|
        if slide_number <= (@slide_ids.count-1)
          sls.slide_id = @slide_ids[slide_number]
          sls.save
          slide_number = slide_number + 1
        else
          sls.destroy
          slide_number = slide_number + 1
        end
      end
    end

    if @slide_layout.save
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout updated successfully, check #{@slide_layout.slide_layout_slides.order("id ASC").pluck(:slide_id)} /// check #{params[:slide_ids]}."
    else
      render 'edit'
    end
  end

  def destroy
    @slide_layout = SlideLayout.find(params[:id])

    @slide_layout.destroy

    redirect_to "/", :notice => "Slide Layout deleted."
  end

  def import
    SlideLayout.import(params[:file])
    redirect_to "/models/", notice: "Slide Layouts imported."
  end
end
