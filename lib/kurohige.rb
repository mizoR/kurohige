require "kurohige/version"

module Kurohige
  lambda {
    events = {}

    Kernel.send :define_method, :event_clear do
      events = {}
    end

    Kernel.send :define_method, :event_size do
      events.length
    end

    Kernel.send :define_method, :event do |name, &block|
      name = name.to_s
      events[name] = Object.new.tap { |o|
        class << o
          def execute
            @fire.call if (@trigger && @trigger.call && @fire)
          end

          private
          def fire(&block)
            @fire = block
          end

          def fire!
            @fire.call
          end

          def trigger(&block)
            @trigger = block
          end

          def trigger!
            @trigger && @trigger.call
          end
        end

        o.instance_eval(&block)
      }
    end

    Kernel.send :define_method, :event_each do |&block|
      events.each_pair do |name, event|
        block.call(name, event)
      end
    end
  }.call

end
