require 'active_record'
require 'will_paginate/per_page'
require 'will_paginate/page_number'
require 'will_paginate/collection'

module WillPaginate
  # = Paginating finders for ActiveRecord models
  #
  # WillPaginate adds +paginate+, +per_page+ and other methods to
  # ActiveRecord::Base class methods and associations.
  #
  # In short, paginating finders are equivalent to ActiveRecord finders; the
  # only difference is that we start with "paginate" instead of "find" and
  # that <tt>:page</tt> is required parameter:
  #
  #   @posts = Post.paginate :all, :page => params[:page], :order => 'created_at DESC'
  #
  module ActiveRecord
    # makes a Relation look like WillPaginate::Collection
    module RelationMethods
      include WillPaginate::CollectionMethods

      attr_accessor :current_page
      attr_writer :total_entries

      def per_page(value = nil)
        if value.present?
          limit(value)
        else
          limit_value
        end
      end

      # TODO: solve with less relation clones and code dups
      def limit(num)
        rel = super
        if rel.current_page
          rel.offset rel.current_page.to_offset(rel.limit_value).to_i
        else
          rel
        end
      end

      # dirty hack to enable `first` after `limit` behavior above
      def first(*args)
        if current_page
          rel = clone
          rel.current_page = nil
          rel.first(*args)
        else
          super
        end
      end

      def offset(value = nil)
        if value.nil? then offset_value
        else super(value)
        end
      end

      def total_entries
        @total_entries ||=
          begin
            if loaded? && size < limit_value && (current_page == 1 || size > 0)
              offset_value + size
            else
              @total_entries_queried = true
              result = count
              result = result.size if result.respond_to?(:size) && !result.is_a?(Integer)
              result
            end
          end
      end

      def count(*args)
        if limit_value
          excluded = [:order, :limit, :offset, :reorder]
          excluded << :includes unless eager_loading?
          rel = except(*excluded)

          column_name = (select_for_count(rel) || :all)
          rel.count(column_name)
        else
          super(*args)
        end
      end

      def size
        if !loaded? and limit_value and group_values.empty?
          [super, limit_value].min
        else
          super
        end
      end

      # overloaded to be pagination-aware
      def empty?
        if !loaded? && offset_value
          result = count
          result = result.size if result.respond_to?(:size) && !result.is_a?(Integer)
          result <= offset_value
        else
          super
        end
      end

      def clone
        copy_will_paginate_data super
      end

      def to_a
        ::WillPaginate::Collection.create(current_page, limit_value) do |col|
          col.replace super
          col.total_entries ||= total_entries
        end
      end

      private

      def copy_will_paginate_data(other)
        other.current_page = current_page unless other.current_page
        other.total_entries = nil if defined? @total_entries_queried
        other
      end

      def select_for_count(rel)
        if rel.select_values.present?
          select = rel.select_values.join(", ")
          select if select !~ /[,*]/
        end
      end
    end

    module Pagination
      def paginate(page:, per_page: nil, total_entries: nil)
        per_page = per_page() if per_page.blank?
        rel = limit(per_page.to_i).page(page)
        rel.total_entries = total_entries.to_i if total_entries.present?
        rel
      end

      def page(num)
        rel = if ::ActiveRecord::Relation === self
                self
              else
                all
              end

        rel = rel.extending(RelationMethods)
        pagenum = ::WillPaginate::PageNumber(num)
        per_page = rel.limit_value || per_page()
        rel = rel.offset(pagenum.to_offset(per_page).to_i)
        rel = rel.limit(per_page) unless rel.limit_value
        rel.current_page = pagenum
        rel
      end
    end

    ::ActiveRecord::Base.extend PerPage
    ::ActiveRecord::Base.extend Pagination

    klasses = [
      ::ActiveRecord::Relation,
      ::ActiveRecord::Associations::CollectionProxy
    ]

    # support pagination on associations and scopes
    klasses.each { |klass| klass.send(:include, Pagination) }
  end
end
