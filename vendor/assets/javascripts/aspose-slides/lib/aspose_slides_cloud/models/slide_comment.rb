module AsposeSlidesCloud
  # 
  class SlideComment < BaseObject
    attr_accessor :author, :text, :created_time
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'author' => :'Author',
        
        # 
        :'text' => :'Text',
        
        # 
        :'created_time' => :'CreatedTime'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'author' => :'String',
        :'text' => :'String',
        :'created_time' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Author']
        self.author = attributes[:'Author']
      end
      
      if attributes[:'Text']
        self.text = attributes[:'Text']
      end
      
      if attributes[:'CreatedTime']
        self.created_time = attributes[:'CreatedTime']
      end
      
    end

  end
end
