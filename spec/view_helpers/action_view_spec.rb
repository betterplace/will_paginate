require 'spec_helper'
require 'active_support/rescuable' # needed for Ruby 1.9.1
require 'action_controller'
require 'action_view'
require 'will_paginate/view_helpers/action_view'
require 'will_paginate/collection'

Routes = ActionDispatch::Routing::RouteSet.new

Routes.draw do
  get 'dummy/page/:page' => 'dummy#index'
  get 'dummy/dots/page.:page' => 'dummy#dots'
  get 'ibocorp(/:page)' => 'ibocorp#index',
        :constraints => { :page => /\d+/ }, :defaults => { :page => 1 }

  get 'foo/bar' => 'foo#bar'
  get 'baz/list' => 'baz#list'
end

describe WillPaginate::ActionView do

  before(:all) do
    I18n.load_path.concat WillPaginate::I18n.load_path
  end

  before(:each) do
    I18n.reload!
  end

  before(:each) do
    @assigns = {}
    @controller = DummyController.new
    @request = @controller.request
    @template = '<%= will_paginate collection, options %>'
  end

  attr_reader :assigns, :controller, :request

  def render(locals)
    @view = ActionView::Base.new([], @assigns, @controller)
    @view.request = @request
    @view.singleton_class.send(:include, @controller._routes.url_helpers)
    @view.render(:inline => @template, :locals => locals)
  end

  ## basic pagination ##

  it "should render" do
    paginate do |pagination|
      assert_select 'a[href]', 3 do |elements|
        validate_page_numbers [2,3,2], elements
      end
      assert_select 'a.next_page', "Next →"
      assert_select 'span', 1
      assert_select 'span.disabled:first-child', '← Previous'
      assert_select 'em.current', '1'
      expect(pagination.first.inner_text).to eq('← Previous 1 2 3 Next →')
    end
  end

  it "should override existing page param value" do
    request.params :page => 1
    paginate do |pagination|
      assert_select 'a[href]', 3 do |elements|
        validate_page_numbers [2,3,2], elements
      end
    end
  end

  it "should render nothing when there is only 1 page" do
    expect(paginate(:per_page => 30)).to be_empty
  end

  it "should paginate with options" do
    paginate({ :page => 2 }, :class => 'will_paginate', :previous_label => 'Prev', :next_label => 'Next') do
      assert_select 'a[href]', 4 do |elements|
        validate_page_numbers [1,1,3,3], elements
        # test rel attribute values:
        assert_select elements[1], 'a', '1' do |link|
          expect(link.first['rel']).to eq('prev start')
        end
        assert_select elements.first, 'a', "Prev" do |link|
          expect(link.first['rel']).to eq('prev start')
        end
        assert_select elements.last, 'a', "Next" do |link|
          expect(link.first['rel']).to eq('next')
        end
      end
      assert_select '.current', '2'
    end
  end

  it "should paginate using a custom renderer class" do
    paginate({}, :renderer => AdditionalLinkAttributesRenderer) do
      assert_select 'a[default=true]', 3
    end
  end

  it "should paginate using standard renderer instance" do
    renderer = WillPaginate::ActionView::LinkRenderer.new

    paginate({ :per_page => 2 }, :inner_window => 0, :outer_window => 0, :renderer => renderer) do
      assert_select 'span.gap', '…'
    end
  end

  it 'url method has to be implemented in subclass' do
    renderer = WillPaginate::ViewHelpers::LinkRenderer.new
    expect { renderer.instance_eval { url(:foo) } }.to raise_error(NotImplementedError)
  end

  it "should paginate using a custom renderer instance" do
    renderer = WillPaginate::ActionView::LinkRenderer.new
    allow(renderer).to receive(:gap_text).and_return '~~'

    paginate({ :per_page => 2 }, :inner_window => 0, :outer_window => 0, :renderer => renderer) do
      assert_select 'span.gap', '~~'
    end

    renderer = AdditionalLinkAttributesRenderer.new(:title => 'rendered')
    paginate({}, :renderer => renderer) do
      assert_select 'a[title=rendered]', 3
    end
  end

  it "should have classnames on previous/next links" do
    paginate do |pagination|
      assert_select 'span.disabled.previous_page:first-child'
      assert_select 'a.next_page[href]:last-child'
    end
  end

  it "should match expected markup" do
    paginate
    expected = <<-HTML.strip_heredoc.chomp.gsub(?\n, ' ')
    <div class="pagination"><span class="previous_page disabled">&#8592; Previous</span>
    <em class="current">1</em>
    <a rel="next" href="/foo/bar?page=2">2</a>
    <a href="/foo/bar?page=3">3</a>
    <a class="next_page" rel="next" href="/foo/bar?page=2">Next &#8594;</a></div>
    HTML
    expected_dom = Nokogiri::HTML.fragment(expected)
    expect(Nokogiri::HTML.fragment(rendered).to_s).to eq(expected_dom.to_s)
  end

  it "should output escaped URLs" do
    paginate({:page => 1, :per_page => 1, :total_entries => 2},
             :page_links => false, :params => { :tag => '<br>' })

    assert_select 'a[href]', 1 do |links|
      query = links.first['href'].split('?', 2)[1]
      expect(query.split('&').sort).to eq(%w(page=2 tag=%3Cbr%3E))
    end
  end

  ## advanced options for pagination ##

  it "should be able to render without container" do
    paginate({}, :container => false)
    assert_select 'div.pagination', 0, 'main DIV present when it shouldn\'t'
    assert_select 'a[href]', 3
  end

  it "should be able to render without page links" do
    paginate({ :page => 2 }, :page_links => false) do
      assert_select 'a[href]', 2 do |elements|
        validate_page_numbers [1,3], elements
      end
    end
  end

  ## other helpers ##

  it "should render a paginated section" do
    @template = <<-ERB
      <%= paginated_section collection, options do %>
        <%= content_tag :div, '', :id => "developers" %>
      <% end %>
    ERB

    paginate
    assert_select 'div.pagination', 2
    assert_select 'div.pagination + div#developers', 1
  end

  it "should not render a paginated section with a single page" do
    @template = <<-ERB
      <%= paginated_section collection, options do %>
        <%= content_tag :div, '', :id => "developers" %>
      <% end %>
    ERB

    paginate(:total_entries => 1)
    assert_select 'div.pagination', 0
    assert_select 'div#developers', 1
  end

  ## parameter handling in page links ##

  it "should preserve parameters on GET" do
    request.params :foo => { :bar => 'baz' }
    paginate
    assert_links_match /foo\[bar\]=baz/
  end

  it "doesn't allow tampering with host, port, protocol" do
    request.params :host => 'disney.com', :port => '99', :protocol => 'ftp'
    paginate
    assert_links_match %r{^/foo/bar}
    assert_no_links_match /disney/
    assert_no_links_match /99/
    assert_no_links_match /ftp/
  end

  it "should not preserve parameters on POST" do
    request.post
    request.params :foo => 'bar'
    paginate
    assert_no_links_match /foo=bar/
  end

  it "should add additional parameters to links" do
    paginate({}, :params => { :foo => 'bar' })
    assert_links_match /foo=bar/
  end

  it "should add anchor parameter" do
    paginate({}, :params => { :anchor => 'anchor' })
    assert_links_match /#anchor$/
  end

  it "should remove arbitrary parameters" do
    request.params :foo => 'bar'
    paginate({}, :params => { :foo => nil })
    assert_no_links_match /foo=bar/
  end

  it "should override default route parameters" do
    paginate({}, :params => { :controller => 'baz', :action => 'list' })
    assert_links_match %r{\Wbaz/list\W}
  end

  it "should paginate with custom page parameter" do
    paginate({ :page => 2 }, :param_name => :developers_page) do
      assert_select 'a[href]', 4 do |elements|
        validate_page_numbers [1,1,3,3], elements, :developers_page
      end
    end
  end

  it "should paginate with complex custom page parameter" do
    request.params :developers => { :page => 2 }

    paginate({ :page => 2 }, :param_name => 'developers[page]') do
      assert_select 'a[href]', 4 do |links|
        assert_links_match /\?developers\[page\]=\d+$/, links
        validate_page_numbers [1,1,3,3], links, 'developers[page]'
      end
    end
  end

  it "should paginate with custom route page parameter" do
    request.symbolized_path_parameters.update :controller => 'dummy', :action => 'index'
    paginate :per_page => 2 do
      assert_select 'a[href]', 6 do |links|
        assert_links_match %r{/page/(\d+)$}, links, [2, 3, 4, 5, 6, 2]
      end
    end
  end

  it "should paginate with custom route with dot separator page parameter" do
    request.symbolized_path_parameters.update :controller => 'dummy', :action => 'dots'
    paginate :per_page => 2 do
      assert_select 'a[href]', 6 do |links|
        assert_links_match %r{/page\.(\d+)$}, links, [2, 3, 4, 5, 6, 2]
      end
    end
  end

  it "should paginate with custom route and first page number implicit" do
    request.symbolized_path_parameters.update :controller => 'ibocorp', :action => 'index'
    paginate :page => 2, :per_page => 2 do
      assert_select 'a[href]', 7 do |links|
        assert_links_match %r{/ibocorp(?:/(\d+))?$}, links, [nil, nil, 3, 4, 5, 6, 3]
      end
    end
    # Routes.recognize_path('/ibocorp/2').should == {:page=>'2', :action=>'index', :controller=>'ibocorp'}
    # Routes.recognize_path('/ibocorp/foo').should == {:action=>'foo', :controller=>'ibocorp'}
  end

  ## internal hardcore stuff ##

  it "should be able to guess the collection name" do
    collection = double
    expect(collection).to receive(:total_pages).and_return(1)

    @template = '<%= will_paginate options %>'
    controller.controller_name = 'developers'
    assigns['developers'] = collection

    paginate(nil)
  end

  it "should fail if the inferred collection is nil" do
    @template = '<%= will_paginate options %>'
    controller.controller_name = 'developers'

    expect {
      paginate(nil)
    }.to raise_error(ActionView::TemplateError, /@developers/)
  end

  ## i18n

  it "is able to translate previous/next labels" do
    translation :will_paginate => {
      :previous_label => 'Go back',
      :next_label => 'Load more'
    }

    paginate do |pagination|
      assert_select 'span.disabled:first-child', 'Go back'
      assert_select 'a[rel=next]', 'Load more'
    end
  end

  it "renders using ActionView helpers on a custom object" do
    helper = Class.new {
      attr_reader :controller
      include ActionView::Helpers::UrlHelper
      include Routes.url_helpers
      include WillPaginate::ActionView
    }.new
    helper.default_url_options[:controller] = 'dummy'

    collection = WillPaginate::Collection.new(2, 1, 3)
    self.rendered = helper.will_paginate(collection)

    assert_select 'a[href]', 4 do |links|
      urls = links.map {|l| l['href'] }.uniq
      expect(urls).to eq(['/dummy/page/1', '/dummy/page/3'])
    end
  end

  it "renders using ActionDispatch helper on a custom object" do
    helper = Class.new {
      include ActionDispatch::Routing::UrlFor
      include Routes.url_helpers
      include WillPaginate::ActionView
    }.new
    helper.default_url_options.update \
      :only_path => true,
      :controller => 'dummy'

    collection = WillPaginate::Collection.new(2, 1, 3)
    self.rendered = helper.will_paginate(collection)

    assert_select 'a[href]', 4 do |links|
      urls = links.map {|l| l['href'] }.uniq
      expect(urls).to eq(['/dummy/page/1', '/dummy/page/3'])
    end
  end

  private

  def translation(data)
    I18n.available_locales # triggers loading existing translations
    I18n.backend.store_translations(:en, data)
  end
end

class AdditionalLinkAttributesRenderer < WillPaginate::ActionView::LinkRenderer
  def initialize(link_attributes = nil)
    super()
    @additional_link_attributes = link_attributes || { :default => 'true' }
  end

  def link(text, target, attributes = {})
    super(text, target, attributes.merge(@additional_link_attributes))
  end
end

class DummyController
  attr_reader :request
  attr_accessor :controller_name

  include ActionController::UrlFor
  include Routes.url_helpers

  def initialize
    @request = DummyRequest.new
  end

  def params
    @request.params
  end

  def env
    {}
  end

  def _prefixes
    []
  end
end

class IbocorpController < DummyController
end

class DummyRequest
  attr_accessor :symbolized_path_parameters
  alias :path_parameters :symbolized_path_parameters

  def initialize
    @get = true
    @params = {}
    @symbolized_path_parameters = { :controller => 'foo', :action => 'bar' }
  end

  def engine_script_name(*a)
    '/'
  end

  def routes
    null = Class.new { define_method(:method_missing) { |*| null } }.new
  end

  def get?
    @get
  end

  def post
    @get = false
  end

  def relative_url_root
    ''
  end

  def script_name
    ''
  end

  def params(more = nil)
    @params.update(more) if more
    @params
  end

  def host_with_port
    'example.com'
  end
  alias host host_with_port

  def optional_port
    ''
  end

  def protocol
    'http:'
  end
end
