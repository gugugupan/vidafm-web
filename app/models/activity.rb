require "VIDA"

class Activity 
  def self.like( activity_id , current_user )
    data = VIDA.call( "like/add" , { :type=>"Activity" , :type_id => activity_id } , current_user )
    JSON.parse( data[ :body ] ) 
  end
=begin
  def self.remove(options = {})
  	options[:user].symbolize_keys!
    JSON.parse(VIDA.call("moment/remove", {:activity_id => options[:activity_id]}, {:token => options[:user][:token], :secret => options[:user][:secret]}))
  end
=end
end
