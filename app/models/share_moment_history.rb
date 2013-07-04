class ShareMomentHistory < SyncHistory
   def ShareMomentHistory.shared(user_id,page)
     begin_date = Date.new(2013,5,1)
     syncs = SyncHistory.where("created_at >= ?", begin_date).where(user_id: user_id).offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
     syncs.map(&:moment_id) 
   end
end
