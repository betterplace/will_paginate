require 'rails/dom/testing/assertions'
require 'minitest'

module ViewExampleGroup

  include Rails::Dom::Testing::Assertions
  include MiniTest::Assertions

  def assertions
    @assertions ||= 0
  end

  def assertions=(value)
    @assertions = value
  end

  def assert_select(*a, &b)
    if Nokogiri::XML::Element === a[0]
      a[0] = Nokogiri::HTML.parse(a[0].to_s)
    end
    super
  end

  def paginate(collection = {}, options = {}, &block)
    if collection.instance_of? Hash
      page_options = { :page => 1, :total_entries => 11, :per_page => 4 }.merge(collection)
      collection = [1].paginate(page_options)
    end

    locals = { :collection => collection, :options => options }

    self.rendered = render(locals)

    if block_given?
      classname = options[:class] || WillPaginate::ViewHelpers.pagination_options[:class]
      assert_select("div.#{classname}", 1, 'no main DIV', &block)
    end

    self.rendered
  end

  attr_accessor :rendered

  def document_root_element
    Nokogiri::HTML.parse(@rendered)
  end

  def response_from_page_or_rjs
    document_root_element.root
  end

  def validate_page_numbers(expected, links, param_name = :page)
    param_pattern = /\W#{Regexp.escape(param_name.to_s)}=([^&]*)/

    expect(links.map { |el|
      unescape_href(el) =~ param_pattern
      $1 ? $1.to_i : $1
    }).to eq(expected)
  end

  def assert_links_match(pattern, links = nil, numbers = nil)
    links ||= assert_select 'div.pagination a[href]' do |elements|
      elements
    end

    pages = [] if numbers

    links.each do |el|
      href = unescape_href(el)
      expect(href).to match(pattern)
      if numbers
        href =~ pattern
        pages << ($1.nil?? nil : $1.to_i)
      end
    end

    expect(pages).to eq(numbers) if numbers
  end

  def assert_no_links_match(pattern)
    assert_select 'div.pagination a[href]' do |elements|
      elements.each do |el|
        expect(unescape_href(el)).not_to match(pattern)
      end
    end
  end

  def unescape_href(el)
    CGI.unescape CGI.unescapeHTML(el['href'])
  end

  def build_message(message, pattern, *args)
    built_message = pattern.dup
    for value in args
      built_message.sub! '?', value.inspect
    end
    built_message
  end

end

RSpec.configure do |config|
  config.include ViewExampleGroup, :type => :view, :file_path => %r{spec/view_helpers/}
end
