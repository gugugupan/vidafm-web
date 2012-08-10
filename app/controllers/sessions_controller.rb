#encoding: utf-8
class SessionsController < ApplicationController
  def create
    session[:current_user] = Session.create(:from => auth_provider, :token => auth_token, :secret => auth_secret)
    cur_user
    if cookies[:refer_url]
      href = cookies.delete(:refer_url)

      redirect_to href
    else
      redirect_to "/home"
      #redirect_to :back
    end
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
end
