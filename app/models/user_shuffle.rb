class UserShuffle < ActiveRecord::Base
  attr_accessible :shuffle_count
  attr_accessible :qq_coin_ids

  def UserShuffle.shuffle(user_id) 
    u = UserShuffle.find_or_initialize_by_user_id(user_id)
    u.shuffle_count = u.shuffle_count + 1

    if u.shuffle_count == 1
       r = rand(1..100)
       if r <= 70
          coin = "1"
       elsif r >= 73
          coin = nil
       else
          coin = "10"
       end    
    elsif u.shuffle_count == 2
       coin = nil
    elsif u.shuffle_count == 3
       r = rand(1..100)
       if r <= 40
          coin = "1"
       elsif r>=42
          coin = nil
       else
          coin = "10"
       end
    else
       coin = nil
    end
  
    puts r
    puts coin 
    u.save
  end

  def add_qq_coins(qq_coin_id)
     begin
       qq_coins = JSON.parse self.qq_coin_ids
     rescue
       qq_coins = []
     end
    
     qq_coins << qq_coin_id 

     self.qq_coin_ids = qq_coins.to_json
     self.save
  end

  def UserShuffle.list_qq_coins(user_id)
    begin 
      qq_coin_ids =  UserShuffle.where(user_id: user_id).first().qq_coin_ids
      qq_coins = JSON.parse qq_coin_ids
    rescue
      qq_coins = []
    end

    return qq_coins
  end  
end
