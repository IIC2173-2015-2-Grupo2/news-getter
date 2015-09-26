FROM ruby:2.2.3-onbuild
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "5000"]
