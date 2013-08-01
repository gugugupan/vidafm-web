  task :every_star => :environment do
    star1 = UserStatisticTotal.where(is_award: 0).order("create_score desc").first
    star2 = UserStatisticTotal.where(is_award: 0).order("share_score desc").second

    puts star1.user_id
    puts star2.user_id

    star1.is_award = 1
    star1.award_type = 1
    star1.save

    
    star2.is_award = 1
    star2.award_type = 2
    star2.save
  end
