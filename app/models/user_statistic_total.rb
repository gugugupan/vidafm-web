class UserStatisticTotal < ActiveRecord::Base
   attr_accessible :user_id
   attr_accessible :create_score, :share_score

   def UserStatisticTotal.create_sort(page)
     UserStatisticTotal.order("`create_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end

   def UserStatisticTotal.shared_sort(page)
     UserStatisticTotal.order("`share_score` desc").offset(page*PAGE_OFFSET).limit(PAGE_OFFSET)
   end
end
