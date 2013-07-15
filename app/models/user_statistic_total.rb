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

   def UserStatisticTotal.create_sort(page)
     UserStatisticTotal.order("`create_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end

   def UserStatisticTotal.shared_sort(page)
     UserStatisticTotal.order("`share_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end

   def UserStatisticTotal.create_sort_without_award(page)
     UserStatisticTotal.where(is_award:0).order("`create_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end

   def UserStatisticTotal.create_award_history(page)
     UserStatisticTotal.where(is_award:1).where(award_type:1).order("`award_time` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end
   
   def UserStatisticTotal.shared_sort_without_award(page)
     UserStatisticTotal.where(is_award:0).order("`share_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end

   def UserStatisticTotal.shared_award_hitstory(page)
     UserStatisticTotal.where(is_award:1).where(award_type:2).order("`award_time` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end
end
