require "VIDA"

class Feedback < ActiveRecord::Base
    class << self
        def create(options)
            JSON.parse VIDA.call("feedback/new", options, nil)
        end
        
    end
end
