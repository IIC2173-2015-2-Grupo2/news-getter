# News-Getter

Make sure you have **Ruby 2.2.3** installed.
You can use [RVM](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv).

### `rbenv`
```sh
$ rbenv install 2.2.3
$ rbenv global 2.2.3
$ ruby -v
```

## Setup

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

## Run
```sh
$ rackup
```
