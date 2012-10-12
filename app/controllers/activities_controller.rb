class ActivitiesController < ApplicationController
	def show
		data = Moment.fetch( nil, current_user , { :activity_id => params[ :id ] , :page => 0 , :page_size => 1 } ) 
    	render( "misc/error" , :layout => false ) and return if data[ 'result' ] == 1
    	redirect_to( user_url(data['data']['user_id']) , :notice => 401 ) and return if data[ 'result' ] == 401 
		redirect_to "/moments/#{ data[ "data" ] [ "items" ] [ 0 ] [ "moment_id" ] }" , :notice => params[ :id ]
	end

	def like 
		if current_user 
			@result = Activity.like( :activity_id => params[:id ] , :user => current_user )
		else
			render "misc/need_authentication"
		end
	end

	def comment
		if current_user
			@result = Comment.create( :comment_type => "Activity" , :type_id => params[ :id ] , :content => params[ :content ] , :user => current_user )
		else
			render "misc/need_authentication" , :locals => { :comment_box => "#{params[ :id ]}comment" }
		end
	end

	def allcomments 
		@comments = Comment.fetch( :type => "Activity" , :type_id => params[ :id ] ) [ "data" ]
	end
end
