# News-Getter
[![Build Status](https://travis-ci.org/IIC2173-2015-2-Grupo2/news-getter.svg)](https://travis-ci.org/IIC2173-2015-2-Grupo2/news-getter)


Make sure you have **Ruby 2.2.3** installed.
You can use [RVM](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv).

##Setup
- correr script config_db.rb
- whenever --update-cron

Ojo que puede que haya que adaptar el archivo config/scheduler.rb dependiendo del computador.


###Explicacion Simple
Tenemos clases de tipo sourse como Emol o CNN que tienen un metodo fetch_news que devuelve
un arreglo de noticias. Estas clases son usadas por los workers al hacer work. Tambien se usa Postman para
enviar las noticias. El scheduler se encarga de administrar a los trabajadores.


#### `rbenv`
```sh
$ rbenv install 2.2.3
$ rbenv global 2.2.3
$ ruby -v
```

## Local

### Setup

Install [bunlder](http://bundler.io/):
```sh
$ gem install --no-ri --no-rdoc bundler

# if using rbenv
$ rbenv rehash
```

Install gems:
```sh
$ bundle install
```

### Run
```sh
$ rackup -p 5000

# Available on:
# http://localhost:5000/
```

## Docker

```sh
# Create VM
$ docker-machine create --driver virtualbox news-getter

# Setup
$ eval "$(docker-machine env news-getter)"
```

### Run

Run on port 5000, to see the Virtual Machine IP:
```sh
$ docker-machine ip news-getter
```

Build and run:
```sh
$ make docker
```
