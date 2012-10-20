module Kurohige
  module Event
    def self.included(base)
      class << base
        include ClassMethods
      end
    end

    module ClassMethods
      def event(name)
        @_events ||= {}
        @_events[name] = Object.new.tap { |o|
          def o.trigger(&block)
            @_trigger = block
          end

          def o.fire(&block)
            @_fire = block
          end

          def o.trigger!
            @_trigger && @_trigger.call
          end

          def o.fire!
            @_fire && @_fire.call
          end

          yield o
        }
      end

      def execute
        @_events ||= {}
        @_events.each_pair do |name, event|
          event.fire! if event.trigger!
        end
      end

      def clear
        @_events = {}
      end
    end
  end
end

