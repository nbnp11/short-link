# Short link API

This app converts url to short link and saves number of link requests.

### Installing
1. Clone repo: `git clone git@github.com:nbnp11/short-link.git && cd short-link`
   
1. Install dependencies: `bundle`
   
1. Create local DB: `bundle exec rake db:create`
   
1. Run migrations: `bundle exec rake db:migrate`
   
1. Run server: `rails s`
   
### Basic usage
1. Create new short link.
   `curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{ "url": { "link": "google.com" } }' localhost:3000/urls`
   
    You will receive `short_link` param

1. Use that `short_link` params to get url. Url's requests stat will be incremented.
`curl -X GET  localhost:3000/urls/UChg4`
   
1. Get request url's request stat.
   `curl -X GET  localhost:3000/urls/UChg4/stats`
