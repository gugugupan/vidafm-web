class UserStatistic < ActiveRecord::Base
   attr_accessible :user_id, :create_count, :create_played_count, :shared_count, :shared_played_count
   
   def UserStatistic.add_create_played_count(creating_user_id)
      t = Time.new
      u = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).where(user_id: creating_user_id).first
      if u != nil
         u.create_played_count = u.create_played_count + 1
         u.save
      else
         u = UserStatistic.create({:user_id => creating_user_id, :create_played_count => 1})
      end
   end


   def UserStatistic.add_shared_played_count(sharing_user_id)
      t = Time.new
      u = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).where(user_id: sharing_user_id).first
      if u != nil
         u.shared_played_count = u.shared_played_count + 1
         u.save
      else
         u = UserStatistic.create({:user_id => sharing_user_id, :shared_played_count => 1})
      end
   end
end
