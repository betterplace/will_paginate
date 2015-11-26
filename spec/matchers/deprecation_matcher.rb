class DeprecationMatcher
  def initialize(message)
    @message = message
  end

  def matches?(block)
    @actual = hijack_output(&block)
    PhraseMatcher.new("DEPRECATION WARNING: #{@message}").matches?(@actual)
  end

  def supports_block_expectations?
    true
  end

  def failure_message
    "expected deprecation warning #{@message.inspect}, got #{@actual.inspect}"
  end

  private

  def hijack_output
    logger = Class.new {
      def initialize
        @output = ''
      end

      attr_reader :output

      def warn(*a)
        @output << a.join(?\n)
      end
    }.new
    Rails.singleton_class.class_eval do
      define_method(:logger) { logger }
    end
    yield
  ensure
    Rails.singleton_class.class_eval do
      undef_method :logger
    end
    return logger.output
  end
end
