Parser demo app
===============
This app is demo for recruitment purpose. It parses included `webserver.log` and aggregates unique and total visits for
specific paths. Code structure demonstrates basic OO with TDD approach using rspec and therefore the whole implementation is a little bit over the top.

### Running
To run it simply make `parser.rb` file executable na then run with
* `./parser.rb webserver.log`

### Test running
To run rspec tests install gem with bundler first
* `bundle install`

and then run `rspec`

* `bundle exec rspec` 