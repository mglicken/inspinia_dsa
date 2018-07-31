module AsposeSlidesCloud
  # 
  class Theme < BaseObject
    attr_accessor :name, :color_scheme, :font_scheme, :format_scheme, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'name' => :'Name',
        
        # 
        :'color_scheme' => :'ColorScheme',
        
        # 
        :'font_scheme' => :'FontScheme',
        
        # 
        :'format_scheme' => :'FormatScheme',
        
        # 
        :'self_uri' => :'SelfUri',
        
        # 
        :'alternate_links' => :'AlternateLinks',
        
        # 
        :'links' => :'Links'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'name' => :'String',
        :'color_scheme' => :'ResourceUriElement',
        :'font_scheme' => :'ResourceUriElement',
        :'format_scheme' => :'ResourceUriElement',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Name']
        self.name = attributes[:'Name']
      end
      
      if attributes[:'ColorScheme']
        self.color_scheme = attributes[:'ColorScheme']
      end
      
      if attributes[:'FontScheme']
        self.font_scheme = attributes[:'FontScheme']
      end
      
      if attributes[:'FormatScheme']
        self.format_scheme = attributes[:'FormatScheme']
      end
      
      if attributes[:'SelfUri']
        self.self_uri = attributes[:'SelfUri']
      end
      
      if attributes[:'AlternateLinks']
        if (value = attributes[:'AlternateLinks']).is_a?(Array)
          self.alternate_links = value
        end
      end
      
      if attributes[:'Links']
        if (value = attributes[:'Links']).is_a?(Array)
          self.links = value
        end
      end
      
    end

  end
end
