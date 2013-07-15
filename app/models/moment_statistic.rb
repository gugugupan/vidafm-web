class MomentStatistic < ActiveRecord::Base
   attr_accessible :moment_id, :user_id, :shared_count, :played_count 
   attr_accessible :total_score 
   
   def MomentStatistic.add_shared_count(moment_id,user_id)
     m = MomentStatistic.find_or_initialize_by_moment_id(moment_id)
     m.user_id = user_id
     m.shared_count = m.shared_count + 1
     m.total_score = m.shared_count + m.played_count

     m.save
   end
   
   def MomentStatistic.add_played_count(moment_id)
     m = MomentStatistic.find_or_initialize_by_moment_id(moment_id)
     m.played_count = m.played_count + 1
     m.total_score = m.shared_count + m.played_count

     m.save
   end

   def MomentStatistic.hot(page)
     hot_list= MomentStatistic.order("`total_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end 
end
