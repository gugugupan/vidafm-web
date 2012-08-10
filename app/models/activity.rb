require "VIDA"

class Activity 
  def self.like(options = {})
    options[:user].symbolize_keys!
    JSON.parse(VIDA.call("like/add", {:type=>"Activity",:type_id => options[:activity_id]}, {:token => options[:user][:token], :secret => options[:user][:secret]}))
  end

  def self.fetchLikeList(activity_id)
  	cmd = "curl http://api.vida.fm/activities/#{activity_id}/likes"
  	data = `#{cmd}`
  	JSON.parse data
  end

  def self.remove(options = {})
  	options[:user].symbolize_keys!
    JSON.parse(VIDA.call("moment/remove", {:activity_id => options[:activity_id]}, {:token => options[:user][:token], :secret => options[:user][:secret]}))
  end
end
