# -*- coding: utf-8 -*-
require 'spec_helper'

describe Kurohige do
  describe 'event' do
    context 'has 3 empty events' do
      before { 3.times { |i| event "event #{i}" do; end } }
      after  { event_clear }

      it { event_size.should == 3 }
      it { lambda { event_each { |name, event| event.execute } }.should_not raise_error(Exception) }
    end

    context 'has 3 events of same name' do
      before { 3.times { event "same name" do; end } }
      after  { event_clear }

      it { event_size.should == 1 }
      it { lambda { event_each { |name, event| event.execute } }.should_not raise_error(Exception) }
    end
  end

  describe 'event_clear' do
    context 'has 2 events and cleared 3 events' do
      before {
        3.times { |i| event "event #{i}" do; end }
        event_clear
        2.times { |i| event "event #{i}" do; end }
      }
      after { event_clear }

      it { event_size.should == 2 }
      it { lambda { event_each { |name, event| event.execute } }.should_not raise_error(Exception) }
    end
  end

  describe 'event_each' do
    context 'i > 3 => true' do
      before {
        (0..9).each { |i|
          event "event #{i}" do
            trigger { i > 3 }
            fire    { print i }
          end
        }
      }
      after { event_clear }

      it { event_size.should == 10 }
      it { event_each { |name, event| name.should =~ /event \d/ } }
      it { capture(:stdout) { event_each { |name, event| event.execute } }.should == '456789' }
    end
  end

  describe 'instance valiables' do
    context '@value > 3' do
      (0..9).each { |i|
        before {
          event "event #{i}" do
            trigger { @value = i; (@value > 3) }
            fire    { print @value }
          end
        }
      }
      after { event_clear }

      it { event_size.should == 10 }
      it { capture(:stdout) { event_each { |name, event| event.execute } }.should == '456789' }
      it { @value.should be_nil }
    end
  end

  context 'VERSION' do
    it { Kurohige::VERSION.should == '0.0.1.1' }
  end
end
