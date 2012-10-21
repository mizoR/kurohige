# Kurohige [![Build Status](https://secure.travis-ci.org/mizoR/kurohige.png)](http://travis-ci.org/mizoR/kurohige)

## Installation

Add this line to your application's Gemfile:

    gem 'kurohige'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kurohige

## Example

    $ cat example.rb
    require 'kurohige'
    
    # event 1
    event 'alert if @value is grater than 3' do
      trigger do
        @value = (rand * 10).to_i
        @value > 3
      end
    
      fire do
        print "WARNING!! #{@value} (> 3)"
      end
    end
    
    # event 2
    event 'alert if process time is over 0.5 sec' do
      trigger do
        require 'timeout'
        begin
          @sec = rand
          timeout(0.5) { sleep @sec } && false
        rescue TimeoutError
          true
        end
      end
    
      fire do
        print "WARNING!! #{@sec} (> 0.5)"
      end
    end
    
    event_each do |name, event|
      print name.ljust(40) + ' => '
      event.execute
      puts
    end
    
    $ ruby example.rb
    alert if @value is grater than 3         => WARNING!! 7 (> 3)
    alert if process time is over 0.5 sec    => WARNING!! 0.7669752628608992 (> 0.5)
    
    $ ruby example.rb
    alert if @value is grater than 3         => WARNING!! 5 (> 3)
    alert if process time is over 0.5 sec    =>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
