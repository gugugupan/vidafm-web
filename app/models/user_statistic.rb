class UserStatistic < ActiveRecord::Base
   attr_accessible :user_id, :create_count, :create_played_count, :shared_count, :shared_played_count
end
