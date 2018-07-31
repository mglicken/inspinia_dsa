module AsposeSlidesCloud
  # 
  class DocumentProperty < BaseObject
    attr_accessor :name, :value, :built_in, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'name' => :'Name',
        
        # 
        :'value' => :'Value',
        
        # 
        :'built_in' => :'BuiltIn',
        
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
        :'value' => :'String',
        :'built_in' => :'BOOLEAN',
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
      
      if attributes[:'Value']
        self.value = attributes[:'Value']
      end
      
      if attributes[:'BuiltIn']
        self.built_in = attributes[:'BuiltIn']
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
