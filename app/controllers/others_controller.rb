require 'csv'

class OthersController < ApplicationController
  def qb
    render :layout => "layouts/others_layout"
  end

  #领取Q币
  def getqb
    # TODO::
    puts "qq:::", params[ :qq ]
    
    file = "public/qb.csv"

    CSV.open( file, 'ab' ) do |writer|
        writer << [params[ :qq ], Time.now]
    end

    render :json => {result: "success"}
  end

end
