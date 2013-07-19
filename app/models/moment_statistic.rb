class MomentStatistic < ActiveRecord::Base
   attr_accessible :moment_id, :user_id, :shared_count, :played_count 
   attr_accessible :total_score 
   attr_accessible :recommended
   
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

   def MomentStatistic.hot(page, offset = PAGE_OFFSET)
     hot_list= MomentStatistic.order("`total_score` desc").offset(page*offset).limit(offset)
   end 

      
   def MomentStatistic.hot_recommended(page, offset = PAGE_OFFSET)
     hot_recommended= MomentStatistic.where(recommended: 2).offset(page*offset).limit(offset)
   end 

   def MomentStatistic.editor_recommended(page, offset = PAGE_OFFSET)
     editor_recommended= MomentStatistic.where(recommended: 1).offset(page*offset).limit(offset)
   end 
end
