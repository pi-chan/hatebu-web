[![Build Status](https://travis-ci.org/xoyip/hatebu-web.png?branch=master)](https://travis-ci.org/xoyip/hatebu-web)

[![Coverage Status](https://coveralls.io/repos/xoyip/hatebu-web/badge.png)](https://coveralls.io/r/xoyip/hatebu-web)

Sample application for Hatena OAuth.

## Requirements

- Ruby/Rails
- MySQL
- Hatena ID

If you don't like MySQL, use another database as you like.

## Create Hatena application

[Hatena Developer Center](http://developer.hatena.ne.jp/ja/documents/auth/apis/oauth/consumer)

## Setup config/application.yml

Create config/application.yml and write your settings for DB and OAuth.

```ruby
production: # <- if you run this app only in localhost, use 'development'
  DB_NAME: your_db_name
  DB_USER: your_user_name
  DB_PASSWORD: your_password
  HATENA_CONSUMER_KEY: your_consumer_key
  HATENA_CONSUMER_SECRET: your_cosumer_secret
```

## Run

```
$ rake db:migrate
$ rails server
```



