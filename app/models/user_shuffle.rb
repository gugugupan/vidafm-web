class UserShuffle < ActiveRecord::Base
  attr_accessible :user_id
  attr_accessible :shuffle_result
  attr_accessible :qq_coin_id
  
  attr_accessor   :qq_coin_code
  attr_accessor   :qq_coin_password

  def UserShuffle.shuffle(user_id) 
    shuffle_count = UserShuffle.where(user_id:user_id).count()

    if shuffle_count == 0
       r = rand(1..100)
       if r <= 70
          coin = 1
       elsif r >= 73
          coin = nil
       else
          coin = 10
       end    
    elsif shuffle_count == 1
       coin = nil
    elsif shuffle_count == 2
       r = rand(1..100)
       if r <= 40
          coin = 1
       elsif r>=42
          coin = nil
       else
          coin = 10
       end
    else
       coin = nil
    end
  
    UserShuffle.create({:user_id => user_id, :shuffle_result => coin}) 
  end


  def UserShuffle.list_qq_coins(user_id)
     shuffles =  UserShuffle.where(user_id: user_id).where("shuffle_result IS NOT NULL")

     shuffles.each do |sh|
       if sh.qq_coin_id == nil
          qq_coin = QqCoins.where(coins: sh.shuffle_result).where(is_used: false).first
          if qq_coin != nil
             sh.qq_coin_id = qq_coin.id
             sh.qq_coin_code = qq_coin.code
             sh.qq_coin_password = qq_coin.password

             qq_coin.is_used = true
             
             sh.save
             qq_coin.save
          end
       else 
          qq_coin = QqCoins.find(sh.qq_coin_id) 
          sh.qq_coin_code = qq_coin.code
          sh.qq_coin_password = qq_coin.password
       end 
     end 
    
     return shuffles
  end  
end
