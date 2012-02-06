# render_execjs #

Render executable JavaScript within Rails.

## Installation ##

Add `render_execjs` to your `Gemfile`

    gem 'render_execjs', '~> 0.0.2'
    # gem 'coffee-script' # Uncomment this line if you'd like to render executable CoffeeScript

Run the `render_execjs:install` generator to create the optional configuration initializer file

    rails generate render_execjs:install

## Usage ##

In your controller:

    render execjs: "return 'some JavaScript';"

It also supports CoffeeScript!

    render execcs: "return 'some CoffeeScript'"

That's it!

Note that it will render whatever is returned from JavaScript.

## Configuration ##

You can configure the following options:

    environment # The environment in which to execute the JavaScript. For example, you can load the Jade templating library into this.
    coffeescript_environment # Will take CoffeeScript, compile it, and set environment to that

`render_execjs` supports four syntaxes for setting configuration options (using the environment option as an example):

    RenderExecJS.configure do
      self.environment = "'js environment'"
      environment "'js environment'"
    end

    RenderExecJS.environment = "'js environment'"
    RenderExecJS.environment "'js environment'"

And two for getting configuration options:

    RenderExecJS.configure do
      self.environment # => will return the environment
    end

    RenderExecJS.environment # => will also return the environment

## Why would I want to render JavaScript from Rails? ##

Make sure that you're logged into your Twitter, now click on this link: [http://twitter.com/tazsingh](http://twitter.com/tazsingh).
Notice how it loads your Twitter profile first, then the page that you've requested?

It has to initialize the JavaScript environment before it can render the page you've requested.
A solution to this, in Rails, is to use something like Mustache to render the same structure but with different logic;
thus giving the browser the page you've requested as the base to initialize from.
However this means duplication of logic.

Wouldn't it be nice to write logic and structure once, using a pretty templating system, that works on both client and server?

This is the problem that `render_execjs` is attempting to solve. Note that this is an experiment and suggestions are welcome!

## Testing ##

`render_execjs` currently uses [Appraisal](https://github.com/thoughtbot/appraisal) to test against multiple versions of Rails.
Install it with: `rake appraisal:install`

Now you can run:

    rake appraisal spec         # To run specs against both Rails 3.1 and 3.2
    rake appraisal:rails31 spec # To test against Rails 3.1
    rake appraisal:rails32 spec # To test against Rails 3.2

Note that the testing system is currently undergoing an overhaul, so the above will change.

## License ##

MIT