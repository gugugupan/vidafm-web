Bluerain::Application.routes.draw do

  root :to => "misc#frontpage"

  match "/d/iphone" => redirect("http://itunes.apple.com/cn/app/id454984086?ls=1")
  match "/d/android" => redirect("http://pics.vida.fm/vida-1.7.2.apk")

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

  #get "activities/likelist.js" => "activities#likelist.js"

  resources :users, :only => "show", :constraints => {:id => /[0-9]+/} do
    get "load_more", :on => :member
    get "relation/:relation", :on => :member, :action => 'relation', :as => :relation
  end
  resources :activities, :only => [:show], :constraints => {:id => /[0-9]+/} do
    resources :comments
    put "like", :on => :member
    delete "remove", :on => :member
    get "likelist", :on => :member
  end

  resources :moments, :only => [:show], :constraints => {:id => /[0-9]+/} do
    get "map", :on => :member
  end

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/auth/logout' => 'sessions#destroy'

  match "contact" => "misc#about", :as => :about  # Hack to rename the legal route "about" to "contact".
  post "create_feedback" => "misc#create_feedback"
end
