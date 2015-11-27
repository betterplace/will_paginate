require 'spec_helper'
require 'will_paginate/view_helpers'
require 'will_paginate/array'
require 'active_support'
require 'active_support/inflections'

describe WillPaginate::ViewHelpers do

  before(:all) do
    # make sure default translations aren't loaded
    I18n.load_path.clear
    I18n.available_locales = [ :en ]
  end

  before(:each) do
    I18n.reload!
  end

  include WillPaginate::ViewHelpers

  describe "will_paginate" do
    it "should render" do
      collection = WillPaginate::Collection.new(1, 2, 4)
      renderer   = double 'Renderer'
      expect(renderer).to receive(:prepare).with(collection, instance_of(Hash), self)
      expect(renderer).to receive(:to_html).and_return('<PAGES>')

      expect(will_paginate(collection, :renderer => renderer)).to eq('<PAGES>')
    end

    it "should return nil for single-page collections" do
      collection = double 'Collection', :total_pages => 1
      expect(will_paginate(collection)).to be_nil
    end

    it "should call html_safe on result" do
      collection = WillPaginate::Collection.new(1, 2, 4)

      html = double 'HTML'
      expect(html).to receive(:html_safe).and_return(html)
      renderer = double 'Renderer'
      allow(renderer).to receive(:prepare)
      expect(renderer).to receive(:to_html).and_return(html)

      expect(will_paginate(collection, :renderer => renderer)).to eql(html)
    end
  end

  describe "pagination_options" do
    let(:pagination_options) { WillPaginate::ViewHelpers.pagination_options }

    it "deprecates setting :renderer" do
      begin
        expect {
          pagination_options[:renderer] = 'test'
        }.to have_deprecation("pagination_options[:renderer] shouldn't be set")
      ensure
        pagination_options.delete :renderer
      end
    end
  end

  describe "page_entries_info" do
    before :all do
      @array = ('a'..'z').to_a
    end

    def info(params, options = {})
      collection = Hash === params ? @array.paginate(params) : params
      page_entries_info collection, {:html => false}.merge(options)
    end

    it "should display middle results and total count" do
      expect(info(:page => 2, :per_page => 5)).to eq("Displaying strings 6 - 10 of 26 in total")
    end

    it "uses translation if available" do
      translation :will_paginate => {
        :page_entries_info => {:multi_page => 'Showing %{from} - %{to}'}
      }
      expect(info(:page => 2, :per_page => 5)).to eq("Showing 6 - 10")
    end

    it "uses specific translation if available" do
      translation :will_paginate => {
        :page_entries_info => {:multi_page => 'Showing %{from} - %{to}'},
        :string => { :page_entries_info => {:multi_page => 'Strings %{from} to %{to}'} }
      }
      expect(info(:page => 2, :per_page => 5)).to eq("Strings 6 to 10")
    end

    it "should output HTML by default" do
      expect(info({ :page => 2, :per_page => 5 }, :html => true)).to eq(
        "Displaying strings <b>6&nbsp;-&nbsp;10</b> of <b>26</b> in total"
      )
    end

    it "should display shortened end results" do
      expect(info(:page => 7, :per_page => 4)).to include_phrase('strings 25 - 26')
    end

    it "should handle longer class names" do
      collection = @array.paginate(:page => 2, :per_page => 5)
      model = double('Class', :name => 'ProjectType', :to_s => 'ProjectType')
      allow(collection.first).to receive(:class).and_return model
      expect(info(collection)).to include_phrase('project types')
    end

    it "should adjust output for single-page collections" do
      expect(info(('a'..'d').to_a.paginate(:page => 1, :per_page => 5))).to eq("Displaying all 4 strings")
      expect(info(['a'].paginate(:page => 1, :per_page => 5))).to eq("Displaying 1 string")
    end

    it "should display 'no entries found' for empty collections" do
      expect(info([].paginate(:page => 1, :per_page => 5))).to eq("No entries found")
    end

    it "uses model_name.human when available" do
      name = double('model name', :i18n_key => :flower_key)
      expect(name).to receive(:human).with(:count => 1).and_return('flower')
      model = double('Class', :model_name => name)
      collection = [1].paginate(:page => 1)

      expect(info(collection, :model => model)).to eq("Displaying 1 flower")
    end

    it "uses custom translation instead of model_name.human" do
      name = double('model name', :i18n_key => :flower_key)
      expect(name).not_to receive(:human)
      model = double('Class', :model_name => name)
      translation :will_paginate => {:models => {:flower_key => 'tulip'}}
      collection = [1].paginate(:page => 1)

      expect(info(collection, :model => model)).to eq("Displaying 1 tulip")
    end

    private

    def translation(data)
      I18n.backend.store_translations(:en, data)
    end
  end
end
