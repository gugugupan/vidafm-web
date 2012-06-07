require "VIDA"

class Feedback < ActiveRecord::Base
    class << self
        def create(options)
            o = options
                .stringify_keys
                .keep_if { |v| ['from', 'content'].include? v[0] }
                
            JSON.parse VIDA.call("feedback/new", o, nil)
        end
        
    end
end
