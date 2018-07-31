module AsposeSlidesCloud
  # 
  class Placeholder < BaseObject
    attr_accessor :index, :orientation, :size, :type, :shape, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'index' => :'Index',
        
        # 
        :'orientation' => :'Orientation',
        
        # 
        :'size' => :'Size',
        
        # 
        :'type' => :'Type',
        
        # 
        :'shape' => :'Shape',
        
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
        :'index' => :'Integer',
        :'orientation' => :'String',
        :'size' => :'String',
        :'type' => :'String',
        :'shape' => :'ResourceUriElement',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Index']
        self.index = attributes[:'Index']
      end
      
      if attributes[:'Orientation']
        self.orientation = attributes[:'Orientation']
      end
      
      if attributes[:'Size']
        self.size = attributes[:'Size']
      end
      
      if attributes[:'Type']
        self.type = attributes[:'Type']
      end
      
      if attributes[:'Shape']
        self.shape = attributes[:'Shape']
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
