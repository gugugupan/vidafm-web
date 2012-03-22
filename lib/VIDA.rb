class VIDA
	class << self
		def call(methods, *options)
			params = options[0]
			user = options[1].try(:symbolize_keys)
			resource = "'#{api_url}/#{methods}'"
			cmd = "curl -A 'Platform/web' -d " + '"' + "#{params.to_param}" + '" '
			cmd += "-s "
			cmd += "-u #{user[:token]}:#{user[:secret]} " if user
			cmd += resource
			puts "\nCMD:#{cmd}\n"
			`#{cmd}`
		end
		

		def api_url
			"http://api.vida.fm"
		end
	end
end