class ActivitiesController < ApplicationController
	def like 
		if current_user 
			@result = Activity.like( :activity_id => params[:id ] , :user => current_user )
		else
		end
	end

	def comment
		if current_user
			@result = Comment.create( :comment_type => "Activity" , :type_id => params[ :id ] , :content => params[ :content ] , :user => current_user )
		else
		end
	end
end
