module AsposeSlidesCloud
  # 
  class PresentationsMergeRequest < BaseObject
    attr_accessor :presentation_paths
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'presentation_paths' => :'PresentationPaths'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'presentation_paths' => :'Array<String>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'PresentationPaths']
        if (value = attributes[:'PresentationPaths']).is_a?(Array)
          self.presentation_paths = value
        end
      end
      
    end

  end
end
