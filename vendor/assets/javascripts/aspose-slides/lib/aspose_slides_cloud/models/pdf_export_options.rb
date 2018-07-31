module AsposeSlidesCloud
  # 
  class PdfExportOptions < BaseObject
    attr_accessor :text_compression, :embed_full_fonts, :compliance, :jpeg_quality, :save_metafiles_as_png, :password, :embed_true_type_fonts_for_ascii, :export_format
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'text_compression' => :'TextCompression',
        
        # 
        :'embed_full_fonts' => :'EmbedFullFonts',
        
        # 
        :'compliance' => :'Compliance',
        
        # 
        :'jpeg_quality' => :'JpegQuality',
        
        # 
        :'save_metafiles_as_png' => :'SaveMetafilesAsPng',
        
        # 
        :'password' => :'Password',
        
        # 
        :'embed_true_type_fonts_for_ascii' => :'EmbedTrueTypeFontsForASCII',
        
        # 
        :'export_format' => :'ExportFormat'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'text_compression' => :'String',
        :'embed_full_fonts' => :'BOOLEAN',
        :'compliance' => :'String',
        :'jpeg_quality' => :'String',
        :'save_metafiles_as_png' => :'BOOLEAN',
        :'password' => :'String',
        :'embed_true_type_fonts_for_ascii' => :'BOOLEAN',
        :'export_format' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'TextCompression']
        self.text_compression = attributes[:'TextCompression']
      end
      
      if attributes[:'EmbedFullFonts']
        self.embed_full_fonts = attributes[:'EmbedFullFonts']
      end
      
      if attributes[:'Compliance']
        self.compliance = attributes[:'Compliance']
      end
      
      if attributes[:'JpegQuality']
        self.jpeg_quality = attributes[:'JpegQuality']
      end
      
      if attributes[:'SaveMetafilesAsPng']
        self.save_metafiles_as_png = attributes[:'SaveMetafilesAsPng']
      end
      
      if attributes[:'Password']
        self.password = attributes[:'Password']
      end
      
      if attributes[:'EmbedTrueTypeFontsForASCII']
        self.embed_true_type_fonts_for_ascii = attributes[:'EmbedTrueTypeFontsForASCII']
      end
      
      if attributes[:'ExportFormat']
        self.export_format = attributes[:'ExportFormat']
      end
      
    end

    def text_compression=(text_compression)
      allowed_values = ["None", "Flate"]
      if text_compression && !allowed_values.include?(text_compression)
        fail "invalid value for 'text_compression', must be one of #{allowed_values}"
      end
      @text_compression = text_compression
    end

  end
end
