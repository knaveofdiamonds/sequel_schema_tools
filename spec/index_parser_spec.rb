require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::IndexParser do
  before :each do
    @parser = Sequel::Schema::IndexParser.new
  end

  it "should return an array of Indexes" do
    hsh = {:foo_idx => {:columns => [:foo], :unique => true}}

    @parser.parse(hsh).should == [Sequel::Schema::Index.new(:foo_idx, [:foo], true)]
  end
end
