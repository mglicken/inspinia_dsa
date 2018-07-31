require "minitest/autorun"
require "minitest/unit"

require_relative '../lib/aspose_slides_cloud'

class SlidesTests < Minitest::Test
	include MiniTest::Assertions
	include AsposeSlidesCloud
	include AsposeStorageCloud
	
	def setup
        	#Get App key and App SID from https://cloud.aspose.com
        	AsposeApp.app_key_and_sid("", "")
		@slides_api = SlidesApi.new
	end

	def teardown
	end

	def upload_file(file_name)
        	@storage_api = StorageApi.new
		response = @storage_api.put_create(file_name, File.open("../../../data/" << file_name,"r") { |io| io.read } )
		assert(response, message="Failed to upload {file_name} file.")
	end

	def test_put_slides_convert
        file_name = "sample.pptx"
        convert_to_format = "pdf"

        response = @slides_api.put_slides_convert(File.open("../../../data/" << file_name,"r") { |io| io.read }, {format: convert_to_format})
	 	assert(response, message="Failed to convert presentation from request content to format specified.")
	end

    def test_using_fontsLocation_parameter_to_specify_custom_fonts
        file_name = "sample.pptx"
        convert_to_format = "pdf"
        fonts_folder = "fonts";

        response = @slides_api.put_slides_convert(File.open("../../../data/" << file_name,"r") { |io| io.read }, {format: convert_to_format, fonts_folder: fonts_folder})
        assert(response, message="Failed to convert presentation from request content to format specified using custom fonts.")
    end

	def test_get_slides_document_with_format
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	format = "tiff"
        	response = @slides_api.get_slides_document_with_format(file_name, format)
	 	assert(response, message="Failed to get slides document in specified format.")
	end

	def test_put_new_presentation_from_stored_template
        	file_name = "newPresentation.pptx"
        	template_path = "sample.pptx"
        	upload_file(template_path)
        
        	response = @slides_api.put_new_presentation_from_stored_template(file_name, template_path, File.open("../../../data/Test.html","r") { |io| io.read })
	 	assert(response, message="Failed to add new presentation from stored template.")
	end

	def test_post_slides_document
        	file_name = "newPresentation.pptx"
        	template_path = "sample.pptx"
        	upload_file(template_path)
        
        	response = @slides_api.post_slides_document(file_name, template_path, File.open("../../../data/Test.html","r") { |io| io.read })
	 	assert(response, message="Failed to create presentation.")
	end

	def test_get_slides_document_properties
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.get_slides_document_properties(file_name)
	 	assert(response, message="Failed to read presentation document properties.")
	end

	def test_post_slides_set_document_properties
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        	
	    	document_properties = DocumentProperties.new
	    	document_property = DocumentProperty.new
	    	document_property.name = "Author"
	    	document_property.value = "Elon Musk"
	    
	    	document_properties.list = [document_property]

        	response = @slides_api.post_slides_set_document_properties(file_name, document_properties)
	 	assert(response, message="Failed to set document properties.")
	end

	def test_delete_slides_document_properties
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.delete_slides_document_properties(file_name)
	 	assert(response, message="Failed to clean document properties.")
	end

	def test_get_slides_document_property
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	property_name = "Author"
        	response = @slides_api.get_slides_document_property(file_name, property_name)
	 	assert(response, message="Failed to read presentation document property.")
	end

	def test_put_slides_set_document_property
        	file_name = "sample-input.pptx"
        	upload_file(file_name)

        	property_name = "Author"
        	document_property = DocumentProperty.new
    		document_property.name = property_name
    		document_property.value = "Elon Musk"
        	response = @slides_api.put_slides_set_document_property(file_name, property_name, document_property)
	 	assert(response, message="Failed to set document property.")
	end

	def test_delete_slides_document_property
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	property_name = "AsposeAuthor"
        	response = @slides_api.delete_slides_document_property(file_name, property_name)
	 	assert(response, message="Failed to delete document property.")
	end

	def test_put_slides_document_from_html
        	file_name = "newPresentation.pptx"
        
        	response = @slides_api.put_slides_document_from_html(file_name, File.open("../../../data/ReadMe.html","r") { |io| io.read })
	 	assert(response, message="Failed to create presentation document from html.")
	end

	def test_get_slides_images
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.get_slides_images(file_name)
	 	assert(response, message="Failed to read presentation images info")
	end

	def test_put_presentation_merge
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	merge_file_name_1 = "welcome.pptx"
        	upload_file(merge_file_name_1)
        	merge_file_name_2 = "demo.pptx"
        	upload_file(merge_file_name_2)
        
        	ordered_merge_request = OrderedMergeRequest.new
    
	    	presentation_to_merge_1 = PresentationToMerge.new
	    	presentation_to_merge_1.path = merge_file_name_1
	    	presentation_to_merge_1.slides = 1
	    
	    	presentation_to_merge_2 = PresentationToMerge.new
	    	presentation_to_merge_2.path = merge_file_name_2
	    	presentation_to_merge_2.slides = 1
	    
	    	ordered_merge_request.presentations = [presentation_to_merge_1, presentation_to_merge_2]

        	response = @slides_api.put_presentation_merge(file_name, ordered_merge_request)
	 	assert(response, message="Failed to merge presentations.")
	end

	def test_post_presentation_merge
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	merge_file_name_1 = "welcome.pptx"
        	upload_file(merge_file_name_1)
        	merge_file_name_2 = "demo.pptx"
        	upload_file(merge_file_name_2)

        	merge_request = PresentationsMergeRequest.new
    	 	merge_request.presentation_paths = [merge_file_name_1, merge_file_name_2]

        	response = @slides_api.post_presentation_merge(file_name, merge_request)
	 	assert(response, message="Failed to merge presentations.")
	end

	def test_post_slides_presentation_replace_text
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	old_value = "aspose" 
        	new_value = "Aspose File Format APIs"
        	response = @slides_api.post_slides_presentation_replace_text(file_name, old_value, new_value)
	 	assert(response, message="Failed to replace text by a new value.")
	end

	def test_post_slides_save_as_html
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	html_export_options = HtmlExportOptions.new
    		html_export_options.save_as_zip = true

        	response = @slides_api.post_slides_save_as_html(file_name, html_export_options)
	 	assert(response, message="Failed to save presentation in html format with options.")
	end

	def test_post_slides_save_as_pdf
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	pdf_export_options = PdfExportOptions.new
    		pdf_export_options.jpeg_quality = "50"

        	response = @slides_api.post_slides_save_as_pdf(file_name, pdf_export_options)
	 	assert(response, message="Failed to save presentation in pdf format with options.")
	end

	def test_post_slides_save_as_tiff
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	tiff_export_options = TiffExportOptions.new
    		tiff_export_options.export_format = "tiff"

        	response = @slides_api.post_slides_save_as_tiff(file_name, tiff_export_options)
	 	assert(response, message="Failed to saves presentation in tiff format with options.")
	end

	def test_get_slides_slides_list
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.get_slides_slides_list(file_name)
	 	assert(response, message="Failed to read presentation slides info.")
	end

	def test_post_add_slide_copy
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_to_clone = 1
        	response = @slides_api.post_add_slide_copy(file_name, slide_to_clone)
     		assert(response, message="Failed to add slide copy.")
	end

	def test_delete_slides_clean_slides_list
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.delete_slides_clean_slides_list(file_name)
	 	assert(response, message="Failed to delete presentation slides.")
	end

	def test_get_slide_with_format
        	file_name = "sample.pptx"
        	upload_file(file_name)
       
        	slide_index = 1 
        	format = "pdf"
        	response = @slides_api.get_slide_with_format(file_name, slide_index, format)
	 	assert(response, message="Failed to get slide in specified format")
	end

	def test_delete_slide_by_index
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.delete_slide_by_index(file_name, slide_index)
	 	assert(response, message="Failed to delete presentation slide by its index.")
	end

	def test_get_slides_slide_background
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_slide_background(file_name, slide_index)
	 	assert(response, message="Failed to read presentation slide background color type.")
	end

	def test_put_slides_slide_background
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	color = "FFFF0000"
        	response = @slides_api.put_slides_slide_background(file_name, slide_index, color)
	 	assert(response, message="Failed to set presentation slide background color.")
	end

	def test_delete_slides_slide_background
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.delete_slides_slide_background(file_name, slide_index)
	 	assert(response, message="Failed to remove presentation slide background color.")
	end

	def test_get_slides_slide_comments
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	slide_index = 1
        	response = @slides_api.get_slides_slide_comments(file_name, slide_index)
	 	assert(response, message="Failed to read presentation slide comments.")
	end

	def test_get_slides_slide_images
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	slide_index = 1
        	response = @slides_api.get_slides_slide_images(file_name, slide_index)
	 	assert(response, message="Failed to read slide images info.")
	end

	def test_get_slides_placeholders
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	slide_index = 1
        	response = @slides_api.get_slides_placeholders(file_name, slide_index)
	 	assert(response, message="Failed to read slide placeholders info.")
	end

	def test_get_slides_placeholder
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        	slide_index = 1 
        	placeholder_index = 0
        	response = @slides_api.get_slides_placeholder(file_name, slide_index, placeholder_index)
	 	assert(response, message="Failed to read slide placeholder info.")
	end

	def test_post_slides_slide_replace_text
        	file_name = "sample.pptx"
        	upload_file(file_name)
         
        	slide_index = 1
        	old_value = "aspose"
        	new_value = "Aspose File Format APIs"
        	response = @slides_api.post_slides_slide_replace_text(file_name, slide_index, old_value, new_value)
	 	assert(response, message="Failed to replace text by a new value.")
	end

	def test_get_slides_slide_shapes
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_slide_shapes(file_name, slide_index)
	 	assert(response, message="Failed to read slides shapes info.")
	end

	def test_post_add_new_shape
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape = Shape.new
        	shape.alternative_text = "Aspose"
        	shape.shape_type = "Line"
        	response = @slides_api.post_add_new_shape(file_name, slide_index, shape)
        	puts response
	 	assert(response, message="Failed to creates new shape.")
	end

	def test_get_shape_with_format
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape_index = 1
        	format = "png"
        	response = @slides_api.get_shape_with_format(file_name, slide_index, shape_index, format)
	 	assert(response, message="Failed to render shape to specified picture format.")
	end

	def test_get_slide_shape_paragraphs
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1 
        	shape_index = 1
        	response = @slides_api.get_slide_shape_paragraphs(file_name, slide_index, shape_index)
	 	assert(response, message="Failed to reads a list of paragraphs in shape's textBody.")
	end

	def test_get_shape_paragraph
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape_index = 1
        	paragraph_index = 1
        	response = @slides_api.get_shape_paragraph(file_name, slide_index, shape_index, paragraph_index)
	 	assert(response, message="Failed to reads paragraph in shape's textBody.")
	end

	def test_get_paragraph_portion
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape_index = 1
        	paragraph_index = 1
        	portion_index = 1
        	response = @slides_api.get_paragraph_portion(file_name, slide_index, shape_index, paragraph_index, portion_index)
	 	assert(response, message="Failed to reads paragraph portion in shape's textBody.")
	end

	def test_put_set_paragraph_portion_properties
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1 
        	shape_index = 1
		paragraph_index = 1 
        	portion_index = 1
        	portion = Portion.new
        	portion.text = "Aspose.Slides for iOS"
        	portion.font_color = "FFFF0000"
        	response = @slides_api.put_set_paragraph_portion_properties(file_name, slide_index, shape_index, paragraph_index, portion_index, portion)
	 	assert(response, message="Failed to updates paragraph portion properties.")
	end

	def test_get_slides_slide_shapes_parent
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape_path = "1"
        	response = @slides_api.get_slides_slide_shapes_parent(file_name, slide_index, shape_path)
	 	assert(response, message="Failed to read slide shapes or shape info.")
	end

	def test_put_slide_shape_info
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	shape_path = "1"        
        	shape = Shape.new
        	shape.alternative_text = "Aspose"

        	response = @slides_api.put_slide_shape_info(file_name, slide_index, shape_path, shape)
	 	assert(response, message="Failed to updates shape properties.")
	end

	def test_get_slides_slide_text_items
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_slide_text_items(file_name, slide_index)
	 	assert(response, message="Failed to extract slide text items.")
	end

	def test_get_slides_theme
        	file_name = "sample.pptx"
        	upload_file(file_name)
		slide_index = 1
        	response = @slides_api.get_slides_theme(file_name, slide_index)
	 	assert(response, message="Failed to read slide theme info.")
	end

    	def test_get_slides_theme_color_scheme
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_theme_color_scheme(file_name, slide_index)
        	assert(response, message="Failed to read slide theme color scheme info.")
    	end

    	def test_get_slides_theme_font_scheme
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_theme_font_scheme(file_name, slide_index)
        	assert(response, message="Failed to read slide theme font scheme info.")
    	end

    	def test_get_slides_theme_format_scheme
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_theme_format_scheme(file_name, slide_index)
        	assert(response, message="Failed to read slide theme color scheme info.")
    	end

    	def test_post_slides_split
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.post_slides_split(file_name, {to: 3, from: 2, format: "png"})
        	assert(response, message="Failed to split presentation.")
    	end

    	def test_get_slides_presentation_text_items
        	file_name = "sample.pptx"
		upload_file(file_name)
        
        	response = @slides_api.get_slides_presentation_text_items(file_name)
        	assert(response, message="Failed to extract presentation text items.")
    	end

    	def test_put_new_presentation
        	file_name = "newPresentation.pptx"
        
        	response = @slides_api.put_new_presentation(file_name, File.open("../../../data/sample.pptx","r") { |io| io.read })
        	assert(response, message="Failed to create presentation")
    	end

    	def test_get_slides_document
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.get_slides_document(file_name)
        	assert(response, message="Failed to read presentation info.")
    	end

    	def test_get_slides_slide
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	slide_index = 1
        	response = @slides_api.get_slides_slide(file_name, slide_index)
        	assert(response, message="Failed to read slide info.")
    	end

    	def test_post_slides_reorder_position
        	file_name = "sample-input.pptx"
        	upload_file(file_name)
        
        	old_position = 1 
        	new_position = 2
        	response = @slides_api.post_slides_reorder_position(file_name, old_position, new_position)
        	assert(response, message="Failed to reorder presentation slide position.")
    	end

    	def test_post_add_empty_slide
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	response = @slides_api.post_add_empty_slide(file_name)
        	assert(response, message="Failed to add empty slide")
    	end

    	def test_post_add_empty_slide_at_position
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	position = 1
        	response = @slides_api.post_add_empty_slide_at_position(file_name, position)
        	assert(response, message="Failed to add empty slide at position")
    	end

    	def test_post_clone_presentation_slide
        	file_name = "sample.pptx"
        	upload_file(file_name)
        
        	position = 1
        	slide_to_clone = 1
        	response = @slides_api.post_clone_presentation_slide(file_name, position, slide_to_clone)
        	assert(response, message="Failed to clone presentation slide")
    	end

    	def test_post_copy_slide_from_source_presentation
        	file_name = "sample.pptx"
        	upload_file(file_name)
        	source_file = "sample-input.pptx"
        	upload_file(source_file)
        
        	slide_to_copy = 1
        	position = 1
        	response = @slides_api.post_copy_slide_from_source_presentation(file_name, slide_to_copy, source_file, position)
        	assert(response, message="Failed to copy slide from source presentation.")
    	end
    
end
