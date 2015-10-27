# News-Getter
[![Build Status](https://travis-ci.org/IIC2173-2015-2-Grupo2/news-getter.svg)](https://travis-ci.org/IIC2173-2015-2-Grupo2/news-getter) [![Code Climate](https://codeclimate.com/github/IIC2173-2015-2-Grupo2/news-getter/badges/gpa.svg)](https://codeclimate.com/github/IIC2173-2015-2-Grupo2/news-getter)


Make sure you have **Ruby 2.2.3** installed.
You can use [RVM](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv).

In this repository you will find all the news-getter related files.

## Setup with docker

(you will need docker-compose for this)

Fist we need to build the image of the application. We also need an image of redis that
will be use as a small database. To build and create this images run:

$ docker-compose up

This should create two docker container, one with the up another with redis, and start
running them.

That was easy... But wait we are not sending the news yet beacause the app doesn't know
where to send them. Kill that ignorant process and start a more erudite one.
But before that, let say we want to send the news to:

 www.iwantnews.cl/now

then we have two parts first the host www.iwantnews.cl and then api direction /now.
Two start a process that send news there all we have to do is run:

$ docker-compose run -e URI_ANALYZER=www.iwantnews.cl -e URL_ANALYZER=now news-getter

Thats it. If everything is fine you can get the status by going to
yourdomain.cl/how-are-you (be warn, it's a bit cranky)
Or even better you can get the schedulers log by going yourdomain.cl/log
