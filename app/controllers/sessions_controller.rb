#encoding: utf-8
class SessionsController < ApplicationController
  def create
    session[:current_user] = Session.create(:from => auth_provider, :token => auth_token, :secret => auth_secret)
    login_success
  end

  def failure
    render :text => request.env["omniauth.auth"]
  end

  def destroy
    session[:current_user] = nil
    session[:cur_user] = nil
    if cookies[:refer_url]
      href = cookies.delete(:refer_url)
      redirect_to href
    else
      redirect_to "/"
    end
  end

  # 豆瓣登陆（不用omniauth实现）
  def login2douban # hack for douban login API
    # authorization_code
    param = {
      :client_id => "0f8795b0403151382e96c110c093f3a8" ,
      :redirect_uri => "http://api2.vida.fm:15097/user_sync/oauth" ,
      :response_type => "code" ,
      :state => "http://#{ request.host_with_port }/auth2/douban/callback"
    }
    redirect_to "https://www.douban.com/service/auth2/auth?#{ param .to_param }"
  end

  def createdouban
    #access_token
    connection = Faraday.new( :url => "https://www.douban.com/service/auth2/token" )
    result = JSON.parse( connection .post( "" , {
      :client_id => "0f8795b0403151382e96c110c093f3a8" ,
      :client_secret => "e1a82d8cd5efbd3b" ,
      :redirect_uri =>  "http://api2.vida.fm:15097/user_sync/oauth" ,
      :grant_type => "authorization_code" ,
      :code => params[ :code ]
    } ) .body )
    session[:current_user] = Session.create( { :from => "douban" , 
                                               :token => result[ "access_token" ] , 
                                               :secret => "" ,
                                               :expires_in => result[ "expires_in" ] ,
                                               :refresh_token => result[ "refresh_token" ] } )
    login_success
  end

  # 开心登陆（不用omniauth实现）
  def login2kaixin
    # authorization_code
    param = {
      :client_id => "497161294179d3e3b1fca3ce574829f6" ,
      :response_type => "code" ,
      :redirect_uri => "http://#{ request.host_with_port }/auth2/kaixin/callback"
    }
    redirect_to "http://api.kaixin001.com/oauth2/authorize?#{ param .to_param }"
  end

  def createkaixin
    #access_token
    connection = Faraday.new( :url => "https://api.kaixin001.com/oauth2/access_token" )
    result = JSON.parse( connection .post( "" , {
      :client_id => "497161294179d3e3b1fca3ce574829f6" ,
      :client_secret => "c812f23623ea99a2c720a4642f6f7df1" ,
      :redirect_uri =>  "http://#{ request.host_with_port }/auth2/kaixin/callback" ,
      :grant_type => "authorization_code" ,
      :code => params[ :code ]
    } ) .body )
    session[:current_user] = Session.create( { :from => "kaixin001" , 
                                               :token => result[ "access_token" ] , 
                                               :secret => "" ,
                                               :expires_in => result[ "expires_in" ] ,
                                               :refresh_token => result[ "refresh_token" ] } )
    login_success
  end

  private
  def auth_info
    request.env["omniauth.auth"]
  end

  def auth_provider
    return "weiboer" if auth_info['provider'] == 'weibo'
    return "qq" if auth_info[ 'provider' ] == 'tqq'
    return "kaixin001" if auth_info[ 'provider' ] == 'kaixin'
    auth_info['provider']
  end

  def auth_secret
    auth_info['credentials']['secret']
  end

  def auth_token
    auth_info['credentials']['token']
  end

  def login_success
    cur_user
    if cookies[:refer_url]
      href = cookies.delete(:refer_url)

      redirect_to href
    else
      redirect_to "/home"
      #redirect_to :back
    end
  end
end
