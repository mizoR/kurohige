# -*- coding: utf-8 -*-
require 'spec_helper'

describe Kurohige do
  describe '@_events' do
    context 'has 3 empty events' do
      before { 3.times { |i| Kurohige.event "event #{i}" do; end } }
      after  { Kurohige.clear }

      it { Kurohige.instance_eval { @_events.size }.should == 3 }
      it { -> { Kurohige.execute }.should_not raise_error(Exception) }
    end

    context 'has 2 events and cleared 3 events' do
      before {
        3.times { |i| Kurohige.event "event #{i}" do; end }
        Kurohige.clear
        2.times { |i| Kurohige.event "event #{i}" do; end }
      }
      after { Kurohige.clear }

      it { Kurohige.instance_eval { @_events.size }.should == 2 }
      it { -> { Kurohige.execute }.should_not raise_error(Exception) }
    end

    context 'has 3 events of same name' do
      before { 3.times { |i| Kurohige.event "same name" do; end } }
      after  { Kurohige.clear }

      it { Kurohige.instance_eval { @_events.size }.should == 1 }
      it { -> { Kurohige.execute }.should_not raise_error(Exception) }
    end
  end

  describe '.event' do
    context 'true' do
      before {
        (0..9).each { |i|
          Kurohige.event "event #{i}" do |env|
            env.trigger { i > 3 }
            env.fire    { print i }
          end
        }
      }

      after { Kurohige.clear }

      it { Kurohige.instance_eval { @_events.size }.should == 10 }
      it { capture(:stdout) { Kurohige.execute }.should == "456789" }
    end
  end
end
