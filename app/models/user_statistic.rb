class UserStatistic < ActiveRecord::Base
   attr_accessible :user_id, :create_count, :create_played_count, :shared_count, :shared_played_count
   attr_accessible :create_score, :share_score
   
   def UserStatistic.add_create_played_count(creating_user_id)
      t = Time.new
      u = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).where(user_id: creating_user_id).first
      if u != nil
         u.create_played_count = u.create_played_count + 1
      else
         u = UserStatistic.create({:user_id => creating_user_id, :create_played_count => 1})
      end
   
      u.create_score = u.create_count * 10 + u.create_played_count * 5
      u.save
   end


   def UserStatistic.add_shared_played_count(sharing_user_id)
      t = Time.new
      u = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).where(user_id: sharing_user_id).first
      if u != nil
         u.shared_played_count = u.shared_played_count + 1
      else
         u = UserStatistic.create({:user_id => sharing_user_id, :shared_played_count => 1})
      end
   
      u.share_score = u.shared_count * 1 + u.shared_played_count * 10
      u.save
   end

   def UserStatistic.every_day_star
      t = Time.new
      star1 = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).order("`create_score` desc").first
          
      star2 = UserStatistic.where(:created_at=>t.beginning_of_day .. t.end_of_day).order("`share_score` desc").first
      return star1, star2
   end   

   def UserStatistic.create_sort(page)
     UserStatistic.order("`create_score` desc").offset(page*5).limit(5)
   end

   def UserStatistic.shared_sort(page)
     UserStatistic.order("`share_score` desc").offset(page*5).limit(5)
   end
end
