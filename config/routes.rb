Bluerain::Application.routes.draw do
  root :to => "misc#index_v2"

  match "/d/iphone" => redirect("http://itunes.apple.com/cn/app/id454984086")
  match "/d/android" => redirect("http://vida.fm/download/a1.2.1.apk")

  match "/v1" => redirect("http://itunes.apple.com/cn/app/id454984086")
  match "/v2" => redirect("http://itunes.apple.com/cn/app/id454984086")
  match "/v3" => redirect("http://goo.gl/qWeJx")
  match "/v4" => redirect("http://goo.gl/qWeJx")
  match "/v5" => redirect("http://goo.gl/CKRnH")
  match "/v6" => redirect("http://goo.gl/FfF5V")
  match "/r/:link" => redirect("http://goo.gl/%{link}")
  match "/v/weibo-signin" => redirect("http://3g.sina.com.cn/prog/wapsite/sso/register.php")
  match "/v/kaixin001-signin" => redirect("http://iphone.kaixin001.com/reg/prepare.php")


  resources :activities, :only => [:show] do
    resources :comments
    put "like", :on => :member
  end

  resources :moments, :only => [:show]

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/auth/logout' => 'sessions#destroy'

  get "about" => "misc#about"
  post "create_feedback" => "misc#create_feedback"
end
