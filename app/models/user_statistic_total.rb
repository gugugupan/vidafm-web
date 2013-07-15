class UserStatisticTotal < ActiveRecord::Base
   attr_accessible :user_id, :is_award, :award_type, :award_time, :award_share_url
   attr_accessible :create_score, :share_score

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
