class UserStatisticTotal < ActiveRecord::Base
   attr_accessible :user_id, :is_award, :award_type, :award_time, :award_share_url
   attr_accessible :create_count, :create_played_count, :shared_count, :shared_played_count
   attr_accessible :create_score, :share_score
   attr_accessible :create_moment_ids, :share_moment_ids
   
   def UserStatisticTotal.add_create_played_count(creating_user_id)
      u = UserStatisticTotal.where(user_id: creating_user_id).first

      if u != nil
         u.create_played_count = u.create_played_count + 1
      else
         u = UserStatisticTotal.create({:user_id => creating_user_id, :create_played_count => 1})
      end
   
      u.create_score = u.create_count * 10 + u.create_played_count * 5
      u.save
   end


   def UserStatisticTotal.add_shared_played_count(sharing_user_id)
      u = UserStatisticTotal.where(user_id: sharing_user_id).first

      if u != nil
         u.shared_played_count = u.shared_played_count + 1
      else
         u = UserStatisticTotal.create({:user_id => sharing_user_id, :shared_played_count => 1})
      end
   
      u.share_score = u.shared_count * 1 + u.shared_played_count * 10
      u.save
   end

   def UserStatisticTotal.add_create_count(creating_user_id,moment_id)
      u = UserStatisticTotal.where(user_id: creating_user_id).first
      if u != nil
         u.create_count = u.create_count + 1
      else
         u = UserStatisticTotal.create({:user_id => creating_user_id, :create_count => 1})
      end

      u.create_score = u.create_count * 10 + u.create_played_count * 5
     
      begin
        create_moment_ids = JSON.parse u.create_moment_ids
      rescue
        create_moment_ids = []
      end

      create_moment_ids << moment_id
      u.create_moment_ids = create_moment_ids.to_json 

      u.save
   end

   def UserStatisticTotal.add_shared_count(sharing_user_id,moment_id)
      u = UserStatisticTotal.where(user_id: sharing_user_id).first

      if u != nil
         u.shared_count = u.shared_count + 1
      else
         u = UserStatisticTotal.create({:user_id => sharing_user_id, :shared_count => 1})
      end

      u.share_score = u.shared_count * 1 + u.shared_played_count * 10

      begin
        share_moment_ids = JSON.parse u.share_moment_ids
      rescue
        share_moment_ids = []
      end

      share_moment_ids << moment_id
      u.share_moment_ids = share_moment_ids.to_json 

      u.save
   end

   def UserStatisticTotal.create_sort(page, offset=PAGE_OFFSET)
     UserStatisticTotal.order("`create_score` desc").offset(page*offset).limit(offset)
   end

   def UserStatisticTotal.shared_sort(page, offset=PAGE_OFFSET)
     UserStatisticTotal.order("`share_score` desc").offset(page*offset).limit(offset)
   end

   def UserStatisticTotal.create_sort_without_award(page, offset=PAGE_OFFSET)
     UserStatisticTotal.where(is_award:0).order("`create_score` desc").offset(page*offset).limit(offset)
   end

   def UserStatisticTotal.create_award_history(page, offset=PAGE_OFFSET)
     UserStatisticTotal.where(is_award:1).where(award_type:1).order("`award_time` desc").offset(page*offset).limit(offset)
   end
   
   def UserStatisticTotal.shared_sort_without_award(page, offset=PAGE_OFFSET)
     UserStatisticTotal.where(is_award:0).order("`share_score` desc").offset(page*offset).limit(offset)
   end

   def UserStatisticTotal.shared_award_hitstory(page, offset=PAGE_OFFSET)
     UserStatisticTotal.where(is_award:1).where(award_type:2).order("`award_time` desc").offset(page*offset).limit(offset)
   end

   def UserStatisticTotal.my_create(user_id,page,offset=5)
      u = UserStatisticTotal.where(user_id: user_id).first
      create_moment_ids = JSON.parse u.create_moment_ids
      return create_moment_ids[page*offset..(page+1)*offset-1]
   end

   def UserStatisticTotal.my_share(user_id,page,offset=5)
      u = UserStatisticTotal.where(user_id: user_id).first
      share_moment_ids = JSON.parse u.share_moment_ids
      return share_moment_ids[page*offset..(page+1)*offset-1]
   end
 
   def UserStatisticTotal.my_profile(user_id)
      u = UserStatisticTotal.where(user_id: user_id).first
      unless u.nil?
          create_rank = UserStatisticTotal.where("create_score > ?", u.create_score).count() + 1      
          share_rank = UserStatisticTotal.where("share_score > ?", u.share_score).count() + 1
          create_score = u.create_score || 0
          share_score = u.share_score || 0
      else
          create_rank = "--"
          share_rank = "--"
          create_score = 0
          share_score = 0
      end      

      return create_score, share_score, create_rank, share_rank
   end
end
