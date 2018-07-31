require "uri"

module AsposeSlidesCloud
  class SlidesApi
    attr_accessor :api_client

    def initialize(api_client = nil)
      @api_client = api_client || Configuration.api_client
    end

    # Convert presentation from request content to format specified.
    # 
    # @param file 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The document password.
    # @option opts [String] :format The format.
    # @option opts [String] :out_path Path to save result
    # @option opts [String] :fonts_folder The optional custom fonts folder.
    # @return [File]
    def put_slides_convert(file, opts = {})
      if Configuration.debugging
        Configuration.debugging "Calling API: SlidesApi#put_slides_convert ..."
      end
      
      # verify the required parameter 'file' is set
      fail "Missing the required parameter 'file' when calling put_slides_convert" if file.nil?
      
      # resource path
      path = "/slides/convert".sub('{format}','json')

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'format'] = opts[:'format'] if opts[:'format']
      query_params[:'outPath'] = opts[:'out_path'] if opts[:'out_path']
      query_params[:'fontsFolder'] = opts[:'fonts_folder'] if opts[:'fonts_folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['multipart/form-data']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}
      form_params["file"] = file

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:PUT, path, :query_params => query_params, :header_params => header_params, :form_params => form_params, :body => post_body, :auth_names => auth_names, :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_slides_convert. Result: #{result.inspect}"
      end
      result
    end

    # Get slides document in specified format
    # 
    # @param name The document name.
    # @param format The slides document format.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :jpeg_quality 
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @option opts [String] :out_path 
    # @return [File]
    def get_slides_document_with_format(name, format, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_document_with_format ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_document_with_format" if name.nil?
      
      # verify the required parameter 'format' is set
      fail "Missing the required parameter 'format' when calling get_slides_document_with_format" if format.nil?
      
      # resource path
      path = "/slides/{name}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'format'] = format
      query_params[:'jpegQuality'] = opts[:'jpeg_quality'] if opts[:'jpeg_quality']
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'outPath'] = opts[:'out_path'] if opts[:'out_path']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_document_with_format. Result: #{result.inspect}"
      end
      return result
    end

    # 
    # 
    # @param name The document name.
    # @param template_path 
    # @param file 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :template_storage 
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @return [DocumentResponse]
    def put_new_presentation_from_stored_template(name, template_path, file, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_new_presentation_from_stored_template ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_new_presentation_from_stored_template" if name.nil?
      
      # verify the required parameter 'template_path' is set
      fail "Missing the required parameter 'template_path' when calling put_new_presentation_from_stored_template" if template_path.nil?
      
      # verify the required parameter 'file' is set
      fail "Missing the required parameter 'file' when calling put_new_presentation_from_stored_template" if file.nil?
      
      # resource path
      path = "/slides/{name}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'templatePath'] = template_path
      query_params[:'templateStorage'] = opts[:'template_storage'] if opts[:'template_storage']
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['multipart/form-data']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}
      form_params["file"] = file

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_new_presentation_from_stored_template. Result: #{result.inspect}"
      end
      return result
    end

    # Create presentation
    # 
    # @param name The document name.
    # @param template_path Template file path.
    # @param file 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :template_storage Template storage name.
    # @option opts [BOOLEAN] :is_image_data_embeeded Is Image Data Embeeded
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @return [BaseResponse]
    def post_slides_document(name, template_path, file, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_document ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_document" if name.nil?
      
      # verify the required parameter 'template_path' is set
      fail "Missing the required parameter 'template_path' when calling post_slides_document" if template_path.nil?
      
      # verify the required parameter 'file' is set
      fail "Missing the required parameter 'file' when calling post_slides_document" if file.nil?
      
      # resource path
      path = "/slides/{name}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'templatePath'] = template_path
      query_params[:'templateStorage'] = opts[:'template_storage'] if opts[:'template_storage']
      query_params[:'isImageDataEmbeeded'] = opts[:'is_image_data_embeeded'] if opts[:'is_image_data_embeeded']
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['multipart/form-data']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}
      form_params["file"] = file

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'BaseResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_document. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation document properties.
    # 
    # @param name The document name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Document&#39;s folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [DocumentPropertiesResponse]
    def get_slides_document_properties(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_document_properties ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_document_properties" if name.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentPropertiesResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_document_properties. Result: #{result.inspect}"
      end
      return result
    end

    # Set document properties.
    # 
    # @param name The document name.
    # @param properties New properties.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Document&#39;s folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [DocumentPropertiesResponse]
    def post_slides_set_document_properties(name, properties, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_set_document_properties ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_set_document_properties" if name.nil?
      
      # verify the required parameter 'properties' is set
      fail "Missing the required parameter 'properties' when calling post_slides_set_document_properties" if properties.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript', 'application/x-www-form-urlencoded']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(properties)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentPropertiesResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_set_document_properties. Result: #{result.inspect}"
      end
      return result
    end

    # Clean document properties.
    # 
    # @param name The presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [DocumentPropertiesResponse]
    def delete_slides_document_properties(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#delete_slides_document_properties ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling delete_slides_document_properties" if name.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:DELETE, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentPropertiesResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#delete_slides_document_properties. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation document property.
    # 
    # @param name The document name.
    # @param property_name The property name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Document&#39;s folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [DocumentPropertyResponse]
    def get_slides_document_property(name, property_name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_document_property ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_document_property" if name.nil?
      
      # verify the required parameter 'property_name' is set
      fail "Missing the required parameter 'property_name' when calling get_slides_document_property" if property_name.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties/{propertyName}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'propertyName' + '}', property_name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentPropertyResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_document_property. Result: #{result.inspect}"
      end
      return result
    end

    # Set document property.
    # 
    # @param name The presentation name.
    # @param property_name The property name.
    # @param property Property with the value.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Document&#39;s folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [DocumentPropertyResponse]
    def put_slides_set_document_property(name, property_name, property, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_slides_set_document_property ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_slides_set_document_property" if name.nil?
      
      # verify the required parameter 'property_name' is set
      fail "Missing the required parameter 'property_name' when calling put_slides_set_document_property" if property_name.nil?
      
      # verify the required parameter 'property' is set
      fail "Missing the required parameter 'property' when calling put_slides_set_document_property" if property.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties/{propertyName}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'propertyName' + '}', property_name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript', 'application/x-www-form-urlencoded']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(property)
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentPropertyResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_slides_set_document_property. Result: #{result.inspect}"
      end
      return result
    end

    # Delete document property.
    # 
    # @param name The presentation name.
    # @param property_name The property name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [CommonResponse]
    def delete_slides_document_property(name, property_name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#delete_slides_document_property ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling delete_slides_document_property" if name.nil?
      
      # verify the required parameter 'property_name' is set
      fail "Missing the required parameter 'property_name' when calling delete_slides_document_property" if property_name.nil?
      
      # resource path
      path = "/slides/{name}/documentproperties/{propertyName}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'propertyName' + '}', property_name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:DELETE, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'CommonResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#delete_slides_document_property. Result: #{result.inspect}"
      end
      return result
    end

    # Create presentation document from html
    # 
    # @param name The document name.
    # @param file 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @return [DocumentResponse]
    def put_slides_document_from_html(name, file, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_slides_document_from_html ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_slides_document_from_html" if name.nil?
      
      # verify the required parameter 'file' is set
      fail "Missing the required parameter 'file' when calling put_slides_document_from_html" if file.nil?
      
      # resource path
      path = "/slides/{name}/fromHtml".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}
      form_params["file"] = file

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_slides_document_from_html. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation images info.
    # 
    # @param name The presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [ImagesResponse]
    def get_slides_images(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_images ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_images" if name.nil?
      
      # resource path
      path = "/slides/{name}/images".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ImagesResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_images. Result: #{result.inspect}"
      end
      return result
    end

    # Merge presentations.
    # 
    # @param name Original presentation name.
    # @param request {PresentationsMergeRequest} with a list of presentations to merge.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :storage The storage.
    # @option opts [String] :folder The folder.
    # @return [DocumentResponse]
    def put_presentation_merge(name, request, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_presentation_merge ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_presentation_merge" if name.nil?
      
      # verify the required parameter 'request' is set
      fail "Missing the required parameter 'request' when calling put_presentation_merge" if request.nil?
      
      # resource path
      path = "/slides/{name}/merge".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript', 'application/x-www-form-urlencoded']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(request)
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_presentation_merge. Result: #{result.inspect}"
      end
      return result
    end

    # Merge presentations.
    # 
    # @param name Original presentation name.
    # @param request {PresentationsMergeRequest} with a list of presentations to merge.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :storage The storage.
    # @option opts [String] :folder The folder.
    # @return [DocumentResponse]
    def post_presentation_merge(name, request, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_presentation_merge ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_presentation_merge" if name.nil?
      
      # verify the required parameter 'request' is set
      fail "Missing the required parameter 'request' when calling post_presentation_merge" if request.nil?
      
      # resource path
      path = "/slides/{name}/merge".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript', 'application/x-www-form-urlencoded']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(request)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_presentation_merge. Result: #{result.inspect}"
      end
      return result
    end

    # Replace text by a new value.
    # 
    # @param name The presentation name.
    # @param old_value Text value to replace.
    # @param new_value The new text value.
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :ignore_case Is case must be ignored.
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [PresentationStringReplaceResponse]
    def post_slides_presentation_replace_text(name, old_value, new_value, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_presentation_replace_text ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_presentation_replace_text" if name.nil?
      
      # verify the required parameter 'old_value' is set
      fail "Missing the required parameter 'old_value' when calling post_slides_presentation_replace_text" if old_value.nil?
      
      # verify the required parameter 'new_value' is set
      fail "Missing the required parameter 'new_value' when calling post_slides_presentation_replace_text" if new_value.nil?
      
      # resource path
      path = "/slides/{name}/replaceText".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'oldValue'] = old_value
      query_params[:'newValue'] = new_value
      query_params[:'ignoreCase'] = opts[:'ignore_case'] if opts[:'ignore_case']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PresentationStringReplaceResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_presentation_replace_text. Result: #{result.inspect}"
      end
      return result
    end

    # Saves presentation in html format with options
    # 
    # @param name The presentation name
    # @param options Tiff export options
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The password to open presentation.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :out_path The optional output path.
    # @return [File]
    def post_slides_save_as_html(name, options, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_save_as_html ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_save_as_html" if name.nil?
      
      # verify the required parameter 'options' is set
      fail "Missing the required parameter 'options' when calling post_slides_save_as_html" if options.nil?
      
      # resource path
      path = "/slides/{name}/saveAs/html".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'outPath'] = opts[:'out_path'] if opts[:'out_path']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript', 'application/x-www-form-urlencoded']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(options)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_save_as_html. Result: #{result.inspect}"
      end
      return result
    end

    # Saves presentation in pdf format with options
    # 
    # @param name The presentation name
    # @param options Pdf export options
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The password to open presentation.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :out_path The optional output path.
    # @return [File]
    def post_slides_save_as_pdf(name, options, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_save_as_pdf ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_save_as_pdf" if name.nil?
      
      # verify the required parameter 'options' is set
      fail "Missing the required parameter 'options' when calling post_slides_save_as_pdf" if options.nil?
      
      # resource path
      path = "/slides/{name}/saveAs/pdf".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'outPath'] = opts[:'out_path'] if opts[:'out_path']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(options)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_save_as_pdf. Result: #{result.inspect}"
      end
      return result
    end

    # Saves presentation in tiff format with options
    # 
    # @param name The presentation name
    # @param options Tiff export options
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The password to open presentation.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :out_path The optional output path.
    # @return [File]
    def post_slides_save_as_tiff(name, options, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_save_as_tiff ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_save_as_tiff" if name.nil?
      
      # verify the required parameter 'options' is set
      fail "Missing the required parameter 'options' when calling post_slides_save_as_tiff" if options.nil?
      
      # resource path
      path = "/slides/{name}/saveAs/tiff".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'outPath'] = opts[:'out_path'] if opts[:'out_path']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(options)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_save_as_tiff. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation slides info.
    # 
    # @param name The presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [SlideListResponse]
    def get_slides_slides_list(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slides_list ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slides_list" if name.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slides_list. Result: #{result.inspect}"
      end
      return result
    end

    # 
    # 
    # @param name The presentation name.
    # @param slide_to_clone 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_add_slide_copy(name, slide_to_clone, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_add_slide_copy ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_add_slide_copy" if name.nil?
      
      # verify the required parameter 'slide_to_clone' is set
      fail "Missing the required parameter 'slide_to_clone' when calling post_add_slide_copy" if slide_to_clone.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'slideToClone'] = slide_to_clone
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_add_slide_copy. Result: #{result.inspect}"
      end
      return result
    end

    # Delete presentation slides.
    # 
    # @param name The presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [SlideListResponse]
    def delete_slides_clean_slides_list(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#delete_slides_clean_slides_list ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling delete_slides_clean_slides_list" if name.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:DELETE, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#delete_slides_clean_slides_list. Result: #{result.inspect}"
      end
      return result
    end

    # Get slide in specified format
    # 
    # @param name 
    # @param slide_index 
    # @param format 
    # @param [Hash] opts the optional parameters
    # @option opts [Integer] :width 
    # @option opts [Integer] :height 
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [File]
    def get_slide_with_format(name, slide_index, format, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slide_with_format ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slide_with_format" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slide_with_format" if slide_index.nil?
      
      # verify the required parameter 'format' is set
      fail "Missing the required parameter 'format' when calling get_slide_with_format" if format.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'format'] = format
      query_params[:'width'] = opts[:'width'] if opts[:'width']
      query_params[:'height'] = opts[:'height'] if opts[:'height']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slide_with_format. Result: #{result.inspect}"
      end
      return result
    end

    # Delete presentation slide by its index.
    # 
    # @param name The presentation name.
    # @param slide_index The slide index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def delete_slide_by_index(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#delete_slide_by_index ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling delete_slide_by_index" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling delete_slide_by_index" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:DELETE, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#delete_slide_by_index. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation slide background color type.
    # 
    # @param name 
    # @param slide_index 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [SlideBackgroundResponse]
    def get_slides_slide_background(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_background ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_background" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_background" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/background".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideBackgroundResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_background. Result: #{result.inspect}"
      end
      return result
    end

    # Set presentation slide background color.
    # 
    # @param name 
    # @param slide_index 
    # @param color 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [SlideBackgroundResponse]
    def put_slides_slide_background(name, slide_index, color, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_slides_slide_background ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_slides_slide_background" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling put_slides_slide_background" if slide_index.nil?
      
      # verify the required parameter 'color' is set
      fail "Missing the required parameter 'color' when calling put_slides_slide_background" if color.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/background".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(color)
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideBackgroundResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_slides_slide_background. Result: #{result.inspect}"
      end
      return result
    end

    # Remove presentation slide background color.
    # 
    # @param name 
    # @param slide_index 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [SlideBackgroundResponse]
    def delete_slides_slide_background(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#delete_slides_slide_background ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling delete_slides_slide_background" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling delete_slides_slide_background" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/background".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:DELETE, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideBackgroundResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#delete_slides_slide_background. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation slide comments.
    # 
    # @param name 
    # @param slide_index 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [SlideCommentsResponse]
    def get_slides_slide_comments(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_comments ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_comments" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_comments" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/comments".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideCommentsResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_comments. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide images info.
    # 
    # @param name Presentation name.
    # @param slide_index The slide index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [ImagesResponse]
    def get_slides_slide_images(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_images ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_images" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_images" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/images".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ImagesResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_images. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide placeholders info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [PlaceholdersResponse]
    def get_slides_placeholders(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_placeholders ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_placeholders" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_placeholders" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/placeholders".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PlaceholdersResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_placeholders. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide placeholder info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param placeholder_index Pleceholder index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [PlaceholderResponse]
    def get_slides_placeholder(name, slide_index, placeholder_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_placeholder ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_placeholder" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_placeholder" if slide_index.nil?
      
      # verify the required parameter 'placeholder_index' is set
      fail "Missing the required parameter 'placeholder_index' when calling get_slides_placeholder" if placeholder_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/placeholders/{placeholderIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'placeholderIndex' + '}', placeholder_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'PlaceholderResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_placeholder. Result: #{result.inspect}"
      end
      return result
    end

    # Replace text by a new value.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param old_value Text to replace.
    # @param new_value New text value.
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :ignore_case Is case must be ignored.
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [SlideStringReplaceResponse]
    def post_slides_slide_replace_text(name, slide_index, old_value, new_value, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_slide_replace_text ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_slide_replace_text" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling post_slides_slide_replace_text" if slide_index.nil?
      
      # verify the required parameter 'old_value' is set
      fail "Missing the required parameter 'old_value' when calling post_slides_slide_replace_text" if old_value.nil?
      
      # verify the required parameter 'new_value' is set
      fail "Missing the required parameter 'new_value' when calling post_slides_slide_replace_text" if new_value.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/replaceText".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'oldValue'] = old_value
      query_params[:'newValue'] = new_value
      query_params[:'ignoreCase'] = opts[:'ignore_case'] if opts[:'ignore_case']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideStringReplaceResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_slide_replace_text. Result: #{result.inspect}"
      end
      return result
    end

    # Read slides shapes info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [ShapeResponse]
    def get_slides_slide_shapes(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_shapes ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_shapes" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_shapes" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ShapeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_shapes. Result: #{result.inspect}"
      end
      return result
    end

    # Creates new shape.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param shape Shape.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [NewShapeResponse]
    def post_add_new_shape(name, slide_index, shape, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_add_new_shape ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_add_new_shape" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling post_add_new_shape" if slide_index.nil?
      
      # verify the required parameter 'shape' is set
      fail "Missing the required parameter 'shape' when calling post_add_new_shape" if shape.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(shape)
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NewShapeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_add_new_shape. Result: #{result.inspect}"
      end
      return result
    end

    # Render shape to specified picture format.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param shape_index Index of shape starting from 1
    # @param format Export picture format.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @option opts [Float] :scale_x X scale ratio.
    # @option opts [Float] :scale_y Y scale ratio.
    # @option opts [String] :bounds Shape thumbnail bounds type.
    # @return [File]
    def get_shape_with_format(name, slide_index, shape_index, format, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_shape_with_format ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_shape_with_format" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_shape_with_format" if slide_index.nil?
      
      # verify the required parameter 'shape_index' is set
      fail "Missing the required parameter 'shape_index' when calling get_shape_with_format" if shape_index.nil?
      
      # verify the required parameter 'format' is set
      fail "Missing the required parameter 'format' when calling get_shape_with_format" if format.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapeIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapeIndex' + '}', shape_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'format'] = format
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'scaleX'] = opts[:'scale_x'] if opts[:'scale_x']
      query_params[:'scaleY'] = opts[:'scale_y'] if opts[:'scale_y']
      query_params[:'bounds'] = opts[:'bounds'] if opts[:'bounds']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = []
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'File')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_shape_with_format. Result: #{result.inspect}"
      end
      return result
    end

    # Reads a list of paragraphs in shape&#39;s textBody.
    # 
    # @param name Presentation name.
    # @param slide_index Index of slide starting from 1
    # @param shape_index Index of shape starting from 1
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [ShapeParagraphsResponse]
    def get_slide_shape_paragraphs(name, slide_index, shape_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slide_shape_paragraphs ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slide_shape_paragraphs" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slide_shape_paragraphs" if slide_index.nil?
      
      # verify the required parameter 'shape_index' is set
      fail "Missing the required parameter 'shape_index' when calling get_slide_shape_paragraphs" if shape_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapeIndex}/paragraphs".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapeIndex' + '}', shape_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ShapeParagraphsResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slide_shape_paragraphs. Result: #{result.inspect}"
      end
      return result
    end

    # Reads paragraph in shape&#39;s textBody.
    # 
    # @param name Presentation name.
    # @param slide_index Index of slide starting from 1
    # @param shape_index Index of shape starting from 1
    # @param paragraph_index Index of paragraph starting from 1
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [ShapeParagraphResponse]
    def get_shape_paragraph(name, slide_index, shape_index, paragraph_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_shape_paragraph ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_shape_paragraph" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_shape_paragraph" if slide_index.nil?
      
      # verify the required parameter 'shape_index' is set
      fail "Missing the required parameter 'shape_index' when calling get_shape_paragraph" if shape_index.nil?
      
      # verify the required parameter 'paragraph_index' is set
      fail "Missing the required parameter 'paragraph_index' when calling get_shape_paragraph" if paragraph_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapeIndex}/paragraphs/{paragraphIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapeIndex' + '}', shape_index.to_s).sub('{' + 'paragraphIndex' + '}', paragraph_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ShapeParagraphResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_shape_paragraph. Result: #{result.inspect}"
      end
      return result
    end

    # Reads paragraph portion in shape&#39;s textBody.
    # 
    # @param name Presentation name.
    # @param slide_index Index of slide starting from 1
    # @param shape_index Index of shape starting from 1
    # @param paragraph_index Index of paragraph starting from 1
    # @param portion_index Index of portion starting from 1
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Document&#39;s storage.
    # @return [ParagraphPortionResponse]
    def get_paragraph_portion(name, slide_index, shape_index, paragraph_index, portion_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_paragraph_portion ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_paragraph_portion" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_paragraph_portion" if slide_index.nil?
      
      # verify the required parameter 'shape_index' is set
      fail "Missing the required parameter 'shape_index' when calling get_paragraph_portion" if shape_index.nil?
      
      # verify the required parameter 'paragraph_index' is set
      fail "Missing the required parameter 'paragraph_index' when calling get_paragraph_portion" if paragraph_index.nil?
      
      # verify the required parameter 'portion_index' is set
      fail "Missing the required parameter 'portion_index' when calling get_paragraph_portion" if portion_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapeIndex}/paragraphs/{paragraphIndex}/portions/{portionIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapeIndex' + '}', shape_index.to_s).sub('{' + 'paragraphIndex' + '}', paragraph_index.to_s).sub('{' + 'portionIndex' + '}', portion_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ParagraphPortionResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_paragraph_portion. Result: #{result.inspect}"
      end
      return result
    end

    # Updates paragraph portion properties.
    # 
    # @param name 
    # @param slide_index 
    # @param shape_index 
    # @param paragraph_index 
    # @param portion_index 
    # @param portion 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [ParagraphPortionResponse]
    def put_set_paragraph_portion_properties(name, slide_index, shape_index, paragraph_index, portion_index, portion, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_set_paragraph_portion_properties ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_set_paragraph_portion_properties" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling put_set_paragraph_portion_properties" if slide_index.nil?
      
      # verify the required parameter 'shape_index' is set
      fail "Missing the required parameter 'shape_index' when calling put_set_paragraph_portion_properties" if shape_index.nil?
      
      # verify the required parameter 'paragraph_index' is set
      fail "Missing the required parameter 'paragraph_index' when calling put_set_paragraph_portion_properties" if paragraph_index.nil?
      
      # verify the required parameter 'portion_index' is set
      fail "Missing the required parameter 'portion_index' when calling put_set_paragraph_portion_properties" if portion_index.nil?
      
      # verify the required parameter 'portion' is set
      fail "Missing the required parameter 'portion' when calling put_set_paragraph_portion_properties" if portion.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapeIndex}/paragraphs/{paragraphIndex}/portions/{portionIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapeIndex' + '}', shape_index.to_s).sub('{' + 'paragraphIndex' + '}', paragraph_index.to_s).sub('{' + 'portionIndex' + '}', portion_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(portion)
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ParagraphPortionResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_set_paragraph_portion_properties. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide shapes or shape info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param shape_path Shape path.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [NewShapeResponse]
    def get_slides_slide_shapes_parent(name, slide_index, shape_path, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_shapes_parent ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_shapes_parent" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_shapes_parent" if slide_index.nil?
      
      # verify the required parameter 'shape_path' is set
      fail "Missing the required parameter 'shape_path' when calling get_slides_slide_shapes_parent" if shape_path.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapePath}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapePath' + '}', shape_path.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NewShapeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_shapes_parent. Result: #{result.inspect}"
      end
      return result
    end

    # Updates shape properties.
    # 
    # @param name Presentation name.
    # @param slide_index Slide index.
    # @param shape_path Shape path.
    # @param shape Shape
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [NewShapeResponse]
    def put_slide_shape_info(name, slide_index, shape_path, shape, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_slide_shape_info ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_slide_shape_info" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling put_slide_shape_info" if slide_index.nil?
      
      # verify the required parameter 'shape_path' is set
      fail "Missing the required parameter 'shape_path' when calling put_slide_shape_info" if shape_path.nil?
      
      # verify the required parameter 'shape' is set
      fail "Missing the required parameter 'shape' when calling put_slide_shape_info" if shape.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/shapes/{shapePath}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s).sub('{' + 'shapePath' + '}', shape_path.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(shape)
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'NewShapeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_slide_shape_info. Result: #{result.inspect}"
      end
      return result
    end

    # Extract slide text items.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :with_empty Include empty items.
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [TextItemsResponse]
    def get_slides_slide_text_items(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide_text_items ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide_text_items" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide_text_items" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/textItems".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'withEmpty'] = opts[:'with_empty'] if opts[:'with_empty']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'TextItemsResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide_text_items. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide theme info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [ThemeResponse]
    def get_slides_theme(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_theme ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_theme" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_theme" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/theme".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ThemeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_theme. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide theme color scheme info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [ColorSchemeResponse]
    def get_slides_theme_color_scheme(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_theme_color_scheme ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_theme_color_scheme" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_theme_color_scheme" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/theme/colorScheme".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'ColorSchemeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_theme_color_scheme. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide theme font scheme info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [FontSchemeResponse]
    def get_slides_theme_font_scheme(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_theme_font_scheme ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_theme_font_scheme" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_theme_font_scheme" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/theme/fontScheme".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'FontSchemeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_theme_font_scheme. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide theme color scheme info.
    # 
    # @param name Presentation name.
    # @param slide_index Slide&#39;s index.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [FormatSchemeResponse]
    def get_slides_theme_format_scheme(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_theme_format_scheme ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_theme_format_scheme" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_theme_format_scheme" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}/theme/formatScheme".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'FormatSchemeResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_theme_format_scheme. Result: #{result.inspect}"
      end
      return result
    end

    # Splitting presentations. Create one image per slide.
    # 
    # @param name The document name.
    # @param [Hash] opts the optional parameters
    # @option opts [Integer] :width The width of created images.
    # @option opts [Integer] :height The height of created images.
    # @option opts [Integer] :to The last slide number for splitting, if is not specified splitting ends at the last slide of the document.
    # @option opts [Integer] :from The start slide number for splitting, if is not specified splitting starts from the first slide of the presentation.
    # @option opts [String] :dest_folder Folder on storage where images are going to be uploaded. If not specified then images are uploaded to same folder as presentation.
    # @option opts [String] :format The format. Default value is jpeg.
    # @option opts [String] :storage The document storage.
    # @option opts [String] :folder The document folder.
    # @return [SplitDocumentResponse]
    def post_slides_split(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_split ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_split" if name.nil?
      
      # resource path
      path = "/slides/{name}/split".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'width'] = opts[:'width'] if opts[:'width']
      query_params[:'height'] = opts[:'height'] if opts[:'height']
      query_params[:'to'] = opts[:'to'] if opts[:'to']
      query_params[:'from'] = opts[:'from'] if opts[:'from']
      query_params[:'destFolder'] = opts[:'dest_folder'] if opts[:'dest_folder']
      query_params[:'format'] = opts[:'format'] if opts[:'format']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SplitDocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_split. Result: #{result.inspect}"
      end
      return result
    end

    # Extract presentation text items.
    # 
    # @param name Presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [BOOLEAN] :with_empty Incude empty items.
    # @option opts [String] :folder Presentation folder.
    # @option opts [String] :storage Presentation storage.
    # @return [TextItemsResponse]
    def get_slides_presentation_text_items(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_presentation_text_items ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_presentation_text_items" if name.nil?
      
      # resource path
      path = "/slides/{name}/textItems".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'withEmpty'] = opts[:'with_empty'] if opts[:'with_empty']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'TextItemsResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_presentation_text_items. Result: #{result.inspect}"
      end
      return result
    end

    # @param name The presentation name.
    # @param slide_to_copy 
    # @param source 
    # @param position 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_copy_slide_from_source_presentation(name, slide_to_copy, source, position, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_copy_slide_from_source_presentation ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_copy_slide_from_source_presentation" if name.nil?
      
      # verify the required parameter 'slide_to_copy' is set
      fail "Missing the required parameter 'slide_to_copy' when calling post_copy_slide_from_source_presentation" if slide_to_copy.nil?
      
      # verify the required parameter 'source' is set
      fail "Missing the required parameter 'source' when calling post_copy_slide_from_source_presentation" if source.nil?
      
      # verify the required parameter 'position' is set
      fail "Missing the required parameter 'position' when calling post_copy_slide_from_source_presentation" if position.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'slideToCopy'] = slide_to_copy
      query_params[:'source'] = source
      query_params[:'position'] = position
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_copy_slide_from_source_presentation. Result: #{result.inspect}"
      end
      return result
    end

    # @param name The presentation name.
    # @param position 
    # @param slide_to_clone 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_clone_presentation_slide(name, position, slide_to_clone, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_clone_presentation_slide ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_clone_presentation_slide" if name.nil?
      
      # verify the required parameter 'position' is set
      fail "Missing the required parameter 'position' when calling post_clone_presentation_slide" if position.nil?
      
      # verify the required parameter 'slide_to_clone' is set
      fail "Missing the required parameter 'slide_to_clone' when calling post_clone_presentation_slide" if slide_to_clone.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'position'] = position
      query_params[:'slideToClone'] = slide_to_clone
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_clone_presentation_slide. Result: #{result.inspect}"
      end
      return result
    end

    # @param name The presentation name.
    # @param position 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_add_empty_slide_at_position(name, position, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_add_empty_slide_at_position ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_add_empty_slide_at_position" if name.nil?
      
      # verify the required parameter 'position' is set
      fail "Missing the required parameter 'position' when calling post_add_empty_slide_at_position" if position.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'position'] = position
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_add_empty_slide_at_position. Result: #{result.inspect}"
      end
      return result
    end

    # 
    # 
    # @param name The presentation name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_add_empty_slide(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_add_empty_slide ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_add_empty_slide" if name.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_add_empty_slide. Result: #{result.inspect}"
      end
      return result
    end

    # Reorder presentation slide position
    # 
    # @param name The presentation name.
    # @param old_position The new presentation slide position.
    # @param new_position The new presentation slide position.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder The presentation folder.
    # @option opts [String] :storage The presentation storage.
    # @return [SlideListResponse]
    def post_slides_reorder_position(name, old_position, new_position, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#post_slides_reorder_position ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling post_slides_reorder_position" if name.nil?
      
      # verify the required parameter 'old_position' is set
      fail "Missing the required parameter 'old_position' when calling post_slides_reorder_position" if old_position.nil?
      
      # verify the required parameter 'new_position' is set
      fail "Missing the required parameter 'new_position' when calling post_slides_reorder_position" if new_position.nil?
      
      # resource path
      path = "/slides/{name}/slides".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'oldPosition'] = old_position
      query_params[:'newPosition'] = new_position
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'application/xml', 'text/xml', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideListResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#post_slides_reorder_position. Result: #{result.inspect}"
      end
      return result
    end

    # Read slide info.
    # 
    # @param name 
    # @param slide_index 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :folder 
    # @option opts [String] :storage 
    # @return [SlideResponse]
    def get_slides_slide(name, slide_index, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_slide ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_slide" if name.nil?
      
      # verify the required parameter 'slide_index' is set
      fail "Missing the required parameter 'slide_index' when calling get_slides_slide" if slide_index.nil?
      
      # resource path
      path = "/slides/{name}/slides/{slideIndex}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s).sub('{' + 'slideIndex' + '}', slide_index.to_s)

      # query parameters
      query_params = {}
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SlideResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_slide. Result: #{result.inspect}"
      end
      return result
    end

    # Read presentation info.
    # 
    # @param name The document name.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @return [DocumentResponse]
    def get_slides_document(name, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#get_slides_document ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling get_slides_document" if name.nil?
      
      # resource path
      path = "/slides/{name}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json', 'text/json', 'text/javascript']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = []
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:GET, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'DocumentResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#get_slides_document. Result: #{result.inspect}"
      end
      return result
    end

    # Create presentation
    # 
    # @param name The document name.
    # @param file 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :password The document password.
    # @option opts [String] :storage Document&#39;s storage.
    # @option opts [String] :folder Document&#39;s folder.
    # @return [BaseResponse]
    def put_new_presentation(name, file, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: SlidesApi#put_new_presentation ..."
      end
      
      # verify the required parameter 'name' is set
      fail "Missing the required parameter 'name' when calling put_new_presentation" if name.nil?
      
      # verify the required parameter 'file' is set
      fail "Missing the required parameter 'file' when calling put_new_presentation" if file.nil?
      
      # resource path
      path = "/slides/{name}".sub('{format}','json').sub('{' + 'name' + '}', name.to_s)

      # query parameters
      query_params = {}
      query_params[:'password'] = opts[:'password'] if opts[:'password']
      query_params[:'storage'] = opts[:'storage'] if opts[:'storage']
      query_params[:'folder'] = opts[:'folder'] if opts[:'folder']

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['multipart/form-data']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}
      form_params["file"] = file

      # http body (model)
      post_body = nil
      

      auth_names = []
      result = @api_client.call_api(:PUT, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'BaseResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: SlidesApi#put_new_presentation. Result: #{result.inspect}"
      end
      return result
    end

  end
end




