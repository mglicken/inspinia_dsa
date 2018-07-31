require 'aspose_storage_cloud'

# Common files
require_relative 'aspose_slides_cloud/api_client'
require_relative 'aspose_slides_cloud/api_error'
require_relative 'aspose_slides_cloud/version'
require_relative 'aspose_slides_cloud/configuration'

# Models
require_relative 'aspose_slides_cloud/models/base_object'
require_relative 'aspose_slides_cloud/models/base_response'
require_relative 'aspose_slides_cloud/models/placeholders_response'
require_relative 'aspose_slides_cloud/models/placeholders'
require_relative 'aspose_slides_cloud/models/resource_uri'
require_relative 'aspose_slides_cloud/models/placeholder_response'
require_relative 'aspose_slides_cloud/models/placeholder'
require_relative 'aspose_slides_cloud/models/resource_uri_element'
require_relative 'aspose_slides_cloud/models/shape'
require_relative 'aspose_slides_cloud/models/fill_format'
require_relative 'aspose_slides_cloud/models/line_format'
require_relative 'aspose_slides_cloud/models/arrow_head_properties'
require_relative 'aspose_slides_cloud/models/custom_dash_pattern'
require_relative 'aspose_slides_cloud/models/portion'
require_relative 'aspose_slides_cloud/models/theme_response'
require_relative 'aspose_slides_cloud/models/theme'
require_relative 'aspose_slides_cloud/models/color_scheme_response'
require_relative 'aspose_slides_cloud/models/color_scheme'
require_relative 'aspose_slides_cloud/models/font_scheme_response'
require_relative 'aspose_slides_cloud/models/font_scheme'
require_relative 'aspose_slides_cloud/models/font_set'
require_relative 'aspose_slides_cloud/models/format_scheme_response'
require_relative 'aspose_slides_cloud/models/format_scheme'
require_relative 'aspose_slides_cloud/models/tiff_export_options'
require_relative 'aspose_slides_cloud/models/pdf_export_options'
require_relative 'aspose_slides_cloud/models/html_export_options'
require_relative 'aspose_slides_cloud/models/document_properties_response'
require_relative 'aspose_slides_cloud/models/document_properties'
require_relative 'aspose_slides_cloud/models/document_property'
require_relative 'aspose_slides_cloud/models/document_property_response'
require_relative 'aspose_slides_cloud/models/common_response'
require_relative 'aspose_slides_cloud/models/text_items_response'
require_relative 'aspose_slides_cloud/models/text_items'
require_relative 'aspose_slides_cloud/models/text_item'
require_relative 'aspose_slides_cloud/models/presentation_string_replace_response'
require_relative 'aspose_slides_cloud/models/document'
require_relative 'aspose_slides_cloud/models/slide_string_replace_response'
require_relative 'aspose_slides_cloud/models/slide_response'
require_relative 'aspose_slides_cloud/models/slide'
require_relative 'aspose_slides_cloud/models/presentations_merge_request'
require_relative 'aspose_slides_cloud/models/document_response'
require_relative 'aspose_slides_cloud/models/ordered_merge_request'
require_relative 'aspose_slides_cloud/models/presentation_to_merge'
require_relative 'aspose_slides_cloud/models/slide_list_response'
require_relative 'aspose_slides_cloud/models/slides'
require_relative 'aspose_slides_cloud/models/slide_background_response'
require_relative 'aspose_slides_cloud/models/slide_background'
require_relative 'aspose_slides_cloud/models/slide_comments_response'
require_relative 'aspose_slides_cloud/models/slide_comments'
require_relative 'aspose_slides_cloud/models/slide_comment'
require_relative 'aspose_slides_cloud/models/images_response'
require_relative 'aspose_slides_cloud/models/images'
require_relative 'aspose_slides_cloud/models/image'
require_relative 'aspose_slides_cloud/models/split_document_response'
require_relative 'aspose_slides_cloud/models/split_document_result'
require_relative 'aspose_slides_cloud/models/shape_response'
require_relative 'aspose_slides_cloud/models/shape_list'
require_relative 'aspose_slides_cloud/models/new_shape_response'
require_relative 'aspose_slides_cloud/models/shape_paragraphs_response'
require_relative 'aspose_slides_cloud/models/paragraphs'
require_relative 'aspose_slides_cloud/models/shape_paragraph_response'
require_relative 'aspose_slides_cloud/models/paragraph'
require_relative 'aspose_slides_cloud/models/paragraph_portion_response'
require_relative 'aspose_slides_cloud/models/color'

# APIs
require_relative 'aspose_slides_cloud/api/slides_api'

module AsposeSlidesCloud
  class << self
    # Configure sdk using block.
    # AsposeSlidesCloud.configure do |config|
    #   config.username = "xxx"
    #   config.password = "xxx"
    # end
    # If no block given, return the configuration singleton instance.
    def configure
      if block_given?
        yield Configuration.instance
      else
        Configuration.instance
      end
    end
  end
end
