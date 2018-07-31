module AsposeSlidesCloud
  # 
  class OrderedMergeRequest < BaseObject
    attr_accessor :presentations
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'presentations' => :'Presentations'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'presentations' => :'Array<PresentationToMerge>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Presentations']
        if (value = attributes[:'Presentations']).is_a?(Array)
          self.presentations = value
        end
      end
      
    end

  end
end
