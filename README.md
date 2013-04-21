# hipbot-plugins

This is a collection of open-source plugins for https://github.com/pewniak747/hipbot, initially developped at http://netguru.co

## Installation

Add this line to your hipbot's Gemfile:

    gem 'hipbot-plugins'

And then execute:

    $ bundle

## Usage

To include a plugin, use hipbot's configuration (https://github.com/pewniak747/hipbot#customize)

``` ruby
require 'hipbot'
require 'hipbot-plugins'

class MyCompanyBot < Hipbot::Bot
  configure do |c|
    c.name      = 'robot'
    c.jid       = 'changeme@chat.hipchat.com'
    c.password  = 'secret'
    c.plugins   = [ Hipbot::Plugins::Human, Hipbot::Plugins::Google ]
  end
end
```

## Plugins

### Hipbot::Plugins::Human

By including this plugin, hipbot gains human traits! It can also reply using Cleverbot, when it does not understand.

Hipbot responds to:

* hello
* open the pod bay door
* make me a sandwich
* slap @someone
* insult @someone
* choose
* comfort me
* (AI simulation with Cleverbot)

### Hipbot::Plugins::Google

Adds various responses for searching the Interwebs

Hipbot responds to:

* google something I want to know
* image something I want to see
* youtube something I want to watch
* something vs somethingelse vs someoranother vs ...
* translate en:pl something I want to translate

### Github

Can generate links to github

Hipbot responds to:

* github some_method_i_want_to_search_in_my_organization
* compare master to production

( For this to work you need to define `project` and `organization` methods as a response helpers: https://github.com/pewniak747/hipbot#response-helpers )

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
