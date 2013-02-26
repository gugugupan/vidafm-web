require "VIDA"

class Feedback 
    class << self
        def create(options)
            JSON.parse( VIDA.call("feedback/new", options, nil)[ :body ] )
        end        
    end
end
