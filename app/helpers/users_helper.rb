module UsersHelper
	# @params: 
	# 	date: 2012-01-01 00:00:00 +0800 
	# @return: ['2012', '01']
	def year_and_month_of date
		exact_time_parts(date)[0, 2]
	end


	# @params: 
	# 	date: 2012-01-01 00:00:00 +0800 
	# @return: '01'
	def day_of date
		exact_time_parts(date)[2]
	end

	private

	def exact_time_parts date
		date = date.to_s
		date.split(/[-\ \/:]/)
	end
end
