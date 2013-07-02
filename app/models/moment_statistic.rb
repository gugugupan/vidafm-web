class MomentStatistic < ActiveRecord::Base
   attr_accessible :moment_id, :shared_count, :played_count 
   
   def MomentStatistic.add_played_count(moment_id)
     m = MomentStatistic.find_or_initialize_by_moment_id(moment_id)
     m.played_count = m.played_count + 1
     m.save
   end
end
