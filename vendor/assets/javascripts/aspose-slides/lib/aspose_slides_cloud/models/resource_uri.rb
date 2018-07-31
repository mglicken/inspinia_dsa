module AsposeSlidesCloud
  # 
  class ResourceUri < BaseObject
    attr_accessor :href, :relation, :link_type, :title
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'href' => :'Href',
        
        # 
        :'relation' => :'Relation',
        
        # 
        :'link_type' => :'LinkType',
        
        # 
        :'title' => :'Title'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'href' => :'String',
        :'relation' => :'String',
        :'link_type' => :'String',
        :'title' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Href']
        self.href = attributes[:'Href']
      end
      
      if attributes[:'Relation']
        self.relation = attributes[:'Relation']
      end
      
      if attributes[:'LinkType']
        self.link_type = attributes[:'LinkType']
      end
      
      if attributes[:'Title']
        self.title = attributes[:'Title']
      end
      
    end

  end
end
