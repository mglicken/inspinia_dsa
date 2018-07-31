module AsposeSlidesCloud
  # 
  class Document < BaseObject
    attr_accessor :document_properties, :slides, :images, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'document_properties' => :'DocumentProperties',
        
        # 
        :'slides' => :'Slides',
        
        # 
        :'images' => :'Images',
        
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
        :'document_properties' => :'ResourceUriElement',
        :'slides' => :'ResourceUriElement',
        :'images' => :'ResourceUriElement',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'DocumentProperties']
        self.document_properties = attributes[:'DocumentProperties']
      end
      
      if attributes[:'Slides']
        self.slides = attributes[:'Slides']
      end
      
      if attributes[:'Images']
        self.images = attributes[:'Images']
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
