class UserShuffle < ActiveRecord::Base
  attr_accessible :user_id
  attr_accessible :shuffle_result
  attr_accessible :qq_coin_id
  
  attr_accessor   :qq_coin_code
  attr_accessor   :qq_coin_password

=begin
1、Q币抽奖可以抽无数次
2、分享到腾讯微博成功就可以抽一次
3、兑换码直接显示在用户页面上
4、http://pay.qq.com/ipay/index.shtml?n=60&c=qqacct_save&ch=qqcard,kj&aid=pay.index.button.ljcz


中奖几率：
第一次抽奖：70%概率中1Q币，2%概率中10Q币
第二次抽奖：0%概率
第三次抽奖：40%概率中1Q币，1%概率中10Q币
以后：全是0%概率 
=end
  def UserShuffle.get_qq_coin(user_id, session)
      if session[ :qq_coin ].nil?
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
            
            session[ :qq_coin ] = coin || 0
      end
      session[ :qq_coin ]
  end

  def UserShuffle.shuffle(user_id, session) 
    coin = UserShuffle.get_qq_coin(user_id, session)
    UserShuffle.create({:user_id => user_id, :shuffle_result => (coin == 0 ? nil : coin)}) if coin
    session.delete(:qq_coin)
    return coin
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
