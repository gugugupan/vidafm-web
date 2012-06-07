require "VIDA"

class Feedback < ActiveRecord::Base
    class << self
        def create(options)
            o = options.stringify_keys.keep_if { |k, v| ['from', 'content'].include? k }

            JSON.parse VIDA.call("feedback/new", o, nil)
        end
        
    end
end
