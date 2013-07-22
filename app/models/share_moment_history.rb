class ShareMomentHistory < SyncHistory
   def ShareMomentHistory.my_shared(user_id,page,offset=PAGE_OFFSET)
     begin_date = Date.new(2013,5,1)
     syncs = SyncHistory.select("moment_id").where("created_at >= ?", begin_date).where(user_id: user_id).where(sent: 1).offset(page*offset).limit(offset)
     moment_ids = syncs.map(&:moment_id) 

     filtered_moments = MomentStatistic.where(moment_id: moment_ids)
   end
   
   def ShareMomentHistory.my_shared_count(user_id)
     begin_date = Date.new(2013,5,1)
     SyncHistory.select("moment_id").where("created_at >= ?", begin_date).where(user_id: user_id).where(sent: 1).count
   end

   def ShareMomentHistory.my_created(user_id,page,offset=PAGE_OFFSET)
     begin_date = Date.new(2013,5,1)
     created_moments= Moment.select("id").where("created_at >= ?", begin_date).where(user_id: user_id).offset(page*offset).limit(offset)
     moment_ids = created_moments.map(&:id) 

     filtered_moments = MomentStatistic.where(moment_id: moment_ids)
   end 
   
   def ShareMomentHistory.my_created_count(user_id)
     begin_date = Date.new(2013,5,1)
     created_moments= Moment.select("id").where("created_at >= ?", begin_date).where(user_id: user_id)
     moment_ids = created_moments.map(&:id) 

     filtered_moments = MomentStatistic.where(moment_id: moment_ids).count
   end
end
