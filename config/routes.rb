Bluerain::Application.routes.draw do

  get "others/qb"
  post "others/getqb"

  match "/d/iphone" => redirect("http://itunes.apple.com/cn/app/id454984086?ls=1")
  match "/d/android_sina" => redirect("http://pics.vida.fm/vida_sina_20130117.apk")
  android_url = ""
  YAML::load_documents(File.open("config/download.yml")) do |doc|
    android_url = doc["android"]["base_url"] + doc["android"]["path"]
  end
  match "/d/android" => redirect(android_url)

  match "/v1" => redirect("http://itunes.apple.com/cn/app/id454984086")
  match "/v2" => redirect("http://itunes.apple.com/cn/app/id454984086")
  match "/v3" => redirect("http://goo.gl/qWeJx")
  match "/v4" => redirect("http://goo.gl/qWeJx")
  match "/v5" => redirect("http://itunes.apple.com/cn/app/id454984086?ls=1")
  #match "/v5" => redirect("http://goo.gl/CKRnH")
  
  match "/v6" => redirect("http://goo.gl/FfF5V")
  match "/r/:link" => redirect("http://goo.gl/%{link}")
  match "/v/weibo-signin" => redirect("http://3g.sina.com.cn/prog/wapsite/sso/register.php")
  match "/v/kaixin001-signin" => redirect("http://iphone.kaixin001.com/reg/prepare.php")
  get "android_download" => "misc#android_download"

  # 智能下载连接
  match "/dd" => "misc#auto_download"

  root :to => "misc#index"
  match "home" => "misc#friend"
  match "ajax_notification" => "misc#ajax_notification"
  get "/misc/ajax_get_new_page"
  
  resources :users, :only => "show", :constraints => {:id => /[0-9]+/} do
    get "ajax_following_list" , :on => :member
    get "ajax_get_new_page" , :on => :member
    put "following", :on => :member 
  end

  resources :moments, :only => "show", :constraints => {:id => /[0-9]+/} do
    get "ajax_get_new_page" , :on => :member
    get "sharelist" , :on => :member 
    post "share" , :on => :member
    post "comment" , :on => :member 
    get "allcomments", :on => :member 
    put "like", :on => :member
  end

  resources :activities, :only => "show" , :constraints => {:id => /[0-9]+/} do
    put "like", :on => :member 
    post "comment", :on => :member
    get "allcomments", :on => :member
  end

  get "/discover/index" 
  get "/discover/category" 
  get "/discover/staruser" 
  get "/discover/public" 
  get "/discover/ajax_get_new_page" 

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/auth/logout' => 'sessions#destroy'

  match '/auth2/douban' => 'sessions#login2douban'
  match '/auth2/douban/callback' => 'sessions#createdouban'
  match '/auth2/kaixin' => 'sessions#login2kaixin'
  match '/auth2/kaixin/callback' => 'sessions#createkaixin'

  match "contact" => "misc#about", :as => :about  # Hack to rename the legal route "about" to "contact".
  match "business" => "misc#business", :as => :business
  post "create_feedback" => "misc#create_feedback"
  
  get ":controller/:action"
end
