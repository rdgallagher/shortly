Short.ly
========

Life is too short for long URLs! So it's a URL shortener, implemented in [Ruby on Rails](http://rubyonrails.org/).

It's pretty basic. It uses Rails' [SecureRandom](http://apidock.com/rails/ActiveSupport/SecureRandom) interface (moved from ActiveSupport to core in 3.2) to generate a 6-ish character URL-safe Base64 encoded string alias for your long URL and checks that it is unique.

Short.ly was developed as part of [General Assembly](http://generalassemb.ly/)'s awesome Rails for Developers course, the content of which is [available on GitHub](https://github.com/generalassembly/ga-ruby-on-rails-for-devs).

Dependencies
------------

Short.ly uses [MongoDB](http://www.mongodb.org/), strictly for the fun of it. So you'll need to install that, the easiest way for Mac probably being via [Homebrew](http://mxcl.github.com/homebrew/):

  `brew install mongodb`

And mainly because of its name, we're running the [Unicorn](http://unicorn.bogomips.org/)* app server. Just type `unicorn` in the app root, or mimic the way it gets run on [Heroku](http://heroku.com/) by typing `foreman start` - you will need the [Heroku Toolbelt](https://toolbelt.heroku.com/).

* okay, it's [fast on Heroku](http://blog.railsonfire.com/2012/05/06/Unicorn-on-Heroku.html) too!

Enjoy
-----

The rest is pretty self-explanatory, and life's too short - so just enjoy!