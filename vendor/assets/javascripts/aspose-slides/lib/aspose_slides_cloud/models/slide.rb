module AsposeSlidesCloud
  # 
  class Slide < BaseObject
    attr_accessor :width, :height, :shapes, :theme, :placeholders, :images, :comments, :background, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'width' => :'Width',
        
        # 
        :'height' => :'Height',
        
        # 
        :'shapes' => :'Shapes',
        
        # 
        :'theme' => :'Theme',
        
        # 
        :'placeholders' => :'Placeholders',
        
        # 
        :'images' => :'Images',
        
        # 
        :'comments' => :'Comments',
        
        # 
        :'background' => :'Background',
        
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
        :'width' => :'Float',
        :'height' => :'Float',
        :'shapes' => :'ResourceUriElement',
        :'theme' => :'ResourceUriElement',
        :'placeholders' => :'ResourceUriElement',
        :'images' => :'ResourceUriElement',
        :'comments' => :'ResourceUriElement',
        :'background' => :'ResourceUriElement',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Width']
        self.width = attributes[:'Width']
      end
      
      if attributes[:'Height']
        self.height = attributes[:'Height']
      end
      
      if attributes[:'Shapes']
        self.shapes = attributes[:'Shapes']
      end
      
      if attributes[:'Theme']
        self.theme = attributes[:'Theme']
      end
      
      if attributes[:'Placeholders']
        self.placeholders = attributes[:'Placeholders']
      end
      
      if attributes[:'Images']
        self.images = attributes[:'Images']
      end
      
      if attributes[:'Comments']
        self.comments = attributes[:'Comments']
      end
      
      if attributes[:'Background']
        self.background = attributes[:'Background']
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
