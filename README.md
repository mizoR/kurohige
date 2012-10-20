# Kurohige

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'kurohige'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kurohige

## Example

    ➜  cat example.rb
    require 'kurohige'
    
    Kurohige.event 'puts message if $value is grater than 3' do |env|
      value = (rand * 10).to_i
      
      env.trigger do
        value > 3
      end
      
      env.fire do
        puts "#{value} greater than 3"
      end
    end
    
    Kurohige.event 'alert if process time is over 0.5 sec' do |env|
      require 'timeout'
      
      sec = rand
      
      env.trigger do
        begin
          timeout(0.5) { sleep sec } && false
        rescue TimeoutError
          true
        end
      end
      
      env.fire do
        puts "WARNING!! #{sec} (> 0.5)"
      end
    end
    
    Kurohige.execute
    
    ➜  ruby example.rb
    6 greater than 3
    WARNING!! 0.8959056017435965 (> 0.5)
    
    ➜  ruby example.rb
    WARNING!! 0.6243299686277085 (> 0.5)
    
    ➜  ruby example.rb
    4 greater than 3

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
