require "omniauth-local"

Rails.application.config.middleware.use OmniAuth::Builder do
    #provider :douban, '0f8795b0403151382e96c110c093f3a8', 'e1a82d8cd5efbd3b'
    provider :weibo, '1509711052', '90250fd184a42c89483dc8a4c394370c'
    provider :tqq, '801063700', '61f513e3773bfefb23732e35698c85cf'
    provider :renren, 'e404073ab16c4dc78ab94f21560e1c05', '45fe6ed247fd478c82d5a206c2d1955a'
    #provider :kaixin, '497161294179d3e3b1fca3ce574829f6', 'c812f23623ea99a2c720a4642f6f7df1',{:client_options => {:ssl => {:verify => false}}}
end

#  http://api2.vida.fm:15097/user_sync/oauth
#  http%3A%2F%2Fapi2.vida.fm%3A15097%2Fuser_sync%2Foauth
