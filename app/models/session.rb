require "VIDA"

class Session
	def self.create(options = {})
		user = JSON.parse(VIDA.call("account/signup_with_vendors", options))['user']
		user['avatar_file'] = user['avatar'] # hack for issue#12

		user
	end
end
