require 'spec_helper'
require 'will_paginate/page_number'

describe WillPaginate::PageNumber do
  describe "valid" do
    let(:page) { described_class.new('12', 'page') }

    it { expect(page).to eq(12) }
    it { expect(page.inspect).to eq('page 12') }
    it { expect(page).to be_a(WillPaginate::PageNumber) }
    it { expect(page).to be_instance_of(WillPaginate::PageNumber) }
    it { expect(page).to be_a(Numeric) }
    it { expect(page).to be_a(Fixnum) }
    it { expect(page).not_to be_instance_of(Fixnum) }

    it "passes the PageNumber=== type check" do |variable|
      expect(WillPaginate::PageNumber === page).to be
    end

    it "passes the Numeric=== type check" do |variable|
      expect(Numeric === page).to be
      expect(Fixnum === page).to be
    end

    context 'with string starting with a number' do
      let(:page) { described_class.new("12\"", 'page') }
      it { expect(page).to eq(12) }
    end
  end

  describe "invalid" do
    def create(value, name = 'page')
      described_class.new(value, name)
    end

    it "defaults to 1 on non-int values" do
      expect(create(nil)).to eq 1
      expect(create('')).to eq 1
      expect(create('Schnitzel')).to eq 1
    end

    it "defaults to 1 on zero or less" do
      expect(create(0)).to eq 1
      expect(create(-1)).to eq 1
    end

    it "doesn't error out for 'offset'" do
      expect(create(0, 'offset')).to eq 0
      expect(create(-1, 'offset')).to eq 0
    end
  end

  describe "coercion method" do
    it "defaults to 'page' name" do
      num = WillPaginate::PageNumber(12)
      expect(num.inspect).to eq('page 12')
    end

    it "accepts a custom name" do
      num = WillPaginate::PageNumber(12, 'monkeys')
      expect(num.inspect).to eq('monkeys 12')
    end

    it "doesn't affect PageNumber instances" do
      num = WillPaginate::PageNumber(12)
      num2 = WillPaginate::PageNumber(num)
      expect(num2.object_id).to eq(num.object_id)
    end
  end
end
