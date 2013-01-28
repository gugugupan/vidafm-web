require "rubygems"
require "faraday"

class VIDA
	class << self
		def call( methods , *options )
			http_params = options[ 0 ] 
			user = options[ 1 ] .symbolize_keys
			http_method = options[ 2 ]
			http_method = "POST" if http_method .nil?

			puts "\n CMD : #{ http_method }   #{ http_params .to_param }   #{ user[ :token ] }:#{ user[ :secret ] }"

			@connection = Faraday.new( :url => dev_api_url ) 
			@connection .basic_auth( user[ :token ] , user[ :secret ] )

			case http_method
			when "GET"
				res = @connection .get methods , http_params
			when "POST"
				res = @connection .post methods , http_params
			end
			res .body
		end

		def api_url
			"http://api2.vida.fm:15097"
		end

		def dev_api_url
			"http://elbrus.vida.fm:15097"
		end
	end
end

# VIDA .call( "feeds" , "" , { :token => "douban35598887" , :secret => "h7p7bb" } , "GET" )