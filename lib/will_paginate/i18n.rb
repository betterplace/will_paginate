module WillPaginate
  module I18n
    def self.locale_dir
      File.expand_path('../locale', __FILE__)
    end

    def self.load_path
      Dir["#{locale_dir}/*.{rb,yml}"]
    end

    def will_paginate_translate(keys, options = {})
      defaults = Array(keys).dup
      defaults << Proc.new if block_given?
      ::I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => :will_paginate))
    end
  end
end
