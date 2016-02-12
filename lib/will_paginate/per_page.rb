module WillPaginate
  module PerPage
    def per_page
      WillPaginate.safe_per_page(@per_page || WillPaginate.per_page_default)
    end

    def per_page=(limit)
      @per_page = limit.to_i
    end

    def self.extended(base)
      base.extend Inheritance if base.is_a? Class
    end

    module Inheritance
      def inherited(subclass)
        super
        subclass.per_page = per_page
      end
    end
  end

  class << self
    attr_reader :per_page_default, :per_page_maximum

    def per_page_default=(default)
      @per_page_default = default.to_i
    end

    def per_page_maximum=(maximum)
      @per_page_maximum = maximum && maximum.to_i
    end

    def safe_per_page(per_page)
      [per_page, WillPaginate.per_page_maximum].compact.min
    end
  end

  self.per_page_default = 30
end
