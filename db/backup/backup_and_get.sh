heroku pgbackups:capture --app ruby-dev-intro
curl -o latest.dump `heroku pgbackups:url --app ruby-dev-intro`
