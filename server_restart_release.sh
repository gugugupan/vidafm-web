kill -9 $(cat ./tmp/pids/unicorn.pid)
sleep 10
echo `bundle exec unicorn -c /home/vidafm/dev/vida_web_release/vidafm/config/unicorn_release.rb -E production -D`


