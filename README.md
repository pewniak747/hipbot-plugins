# hipbot-plugins

[![Build Status](https://travis-ci.org/netguru/hipbot-plugins.png?branch=master)](https://travis-ci.org/netguru/hipbot-plugins)
[![Code Climate](https://codeclimate.com/github/netguru/hipbot-plugins.png)](https://codeclimate.com/github/netguru/hipbot-plugins)
[![Gem Version](https://badge.fury.io/rb/hipbot-plugins.png)](http://badge.fury.io/rb/hipbot-plugins)

This is a collection of open-source plugins for [Hipbot](https://github.com/pewniak747/hipbot), initially developped at [Netguru](http://netguru.co).

## Installation

Add this line to your hipbot's Gemfile:

    gem 'hipbot-plugins'

And then execute:

    $ bundle

## Usage

To include all plugins, put this in your `bot.rb` file:

```ruby
require 'hipbot'
require 'hipbot-plugins'
```
or include them selectively:
```ruby
require 'hipbot'
require 'hipbot-plugins/human'
require 'hipbot-plugins/ascii'
require 'hipbot-plugins/dictionary'
require 'hipbot-plugins/excuses'
require 'hipbot-plugins/github'
require 'hipbot-plugins/google'
require 'hipbot-plugins/help'
require 'hipbot-plugins/human'
require 'hipbot-plugins/meme_generator'
require 'hipbot-plugins/numbers_api'
require 'hipbot-plugins/rapportive'
require 'hipbot-plugins/wolfram_alpha'
```

## Plugins

### Hipbot::Plugins::Human

By including this plugin, hipbot gains human traits!

```ruby
# Cleverbot
gem 'cleverbot', github: 'bartoszkopinski/cleverbot', branch: 'master'
```

Hipbot responds to:

  - `hello`
  - `open the pod bay door`
  - `make me a sandwich`
  - `slap @someone`
  - `choose`
  - `comfort me`
  - everything else with AI simulation from Cleverbot

### Hipbot::Plugins::Google

Adds various responses for searching the Interwebs

Hipbot responds to:

  - `google something I want to know`
  - `image something I want to see`
  - `youtube something I want to watch`
  - `something vs somethingelse vs someoranother vs ...`
  - `translate en:pl something I want to translate`

### Hipbot::Plugins::Github

Can generate links to github

Hipbot responds to:

  - `github some_method_i_want_to_search_in_my_organization`
  - `compare master to production`

(For this to work you need to define `project` and `organization` methods as a response helpers: https://github.com/pewniak747/hipbot#response-helpers)

### Hipbot::Plugins::MemeGenerator

Create instant memes using memecaptain.com!

Hipbot responds to:

  - `memes`
  - `meme allthethings "create all" "the memes!"`

### Hipbot::Plugins::Dictionary

Explains reality using http://urbandictionary.com and http://dictionary.reference.com/

```ruby
# Dictionary
gem 'dictionary-rb'
```

Hipbot responds to:

  - `explain the meaning of life, the universe and everything`

### Hipbot::Plugins::WolframAlpha

Adds the ability to use wolframalpha.com computational search engine. You need to register for api key.

```ruby
# Wolfram Alpha
gem 'wolfram', '~> 0.2.1'
```

``` ruby
class MyCompanyBot < Hipbot::Bot
  configure do |c|
    # ...
    Hipbot::Plugins::WolframAlpha.configure do |c|
      c.appid = 'my-api-key'
    end
  end
end
```

Hipbot responds to:

  - `wolfram plot x^2 + 3x - 1`

### Hipbot::Plugins::NumbersAPI

Provides random number factoids from [NumbersAPI](http://numbersapi.com)

Hipbot responds to:

  - `trivia`
  - `trivia math`
  - `trivia date`
  - `trivia year`
  - `trivia 42`
  - `trivia math 42`
  - `trivia date 12 31`
  - `trivia year 42`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
