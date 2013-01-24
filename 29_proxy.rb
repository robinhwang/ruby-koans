class  Television
  attr_accessor :channel

  def power
    if @power == :on
      @power = :off
    else
      @power = :on
    end
  end

  def on?
    @power == :on
  end
end
#-------------------
class Proxy
  attr_reader :messages

  def initialize(target_object)
    @object = target_object
    @messages = []
  end

  def method_missing(method_name, *args, &block)
    @messages << method_name
    @object.send method_name, *args, &block
  end

  def called?(method_name)
    @messages.include? method_name
  end
# === means included in it
  def number_of_times_called(method_name)
    @messages.find_all{ |m| m === method_name }.count
  end
end

class AboutProxy
  def test_proxy_method_returns_wrapped_object
    tv = Proxy.new(Television.new)

    assert tv.instance_of?(Proxy)
  end

  def test_tv_methods_still_perform_their_function
    tv = Proxy.new(Television.new)

    tv.channel = 10
    tv.power

    assert_equal 10, tv.channel
    assert tv.on?
  end

  def test_proxy_records_messages_sent_to_tv
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel

    assert_equal [:power, :channel=], tv.messages
  end

  def test_proxy_handles_invalid_messages
    tv = Proxy.new(Television.new)

    assert_raise(NoMethodError) do
      tv.no_such_method
    end
  end

  def test_proxy_reports_methods_have_been_called
    tv = Proxy.new(Television.new)

    tv.power
    tv.power

    assert tv.called?(:power)
    assert !tv.called?(:channel)
  end

  def test_proxy_counts_methods_calls
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel = 48
    tv.power

    assert_equal 2, tv.number_of_times_called(:power)
    assert_equal 1, tv.number_of_times_called(:channel=)
    assert_equal 0, tv.number_of_times_called(:on?)
  end

  def test_proxy_can_record_more_than_just_tv_objects
    proxy = Proxy.new("Code Mash 2009")

    proxy.upcase!
    result = proxy.split

    assert_equal ["CODE", "MASH", "2009"], result
    assert_equal [:upcase, :split], proxy.messages
  end
end