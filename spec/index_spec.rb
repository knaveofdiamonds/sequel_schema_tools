require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::Index do
  it "should have a name" do
    Sequel::Schema::Index.new('foo_idx', :foo).name.should == :foo_idx
  end

  it "should have columns" do
    Sequel::Schema::Index.new('foo_idx', [:foo, :bar]).columns.should == [:foo, :bar]
  end

  it "should have convert a single column symbol to a one element column array" do
    Sequel::Schema::Index.new('foo_idx', :foo).columns.should == [:foo]
  end

  it "should know whether it is a multi-column index" do
    Sequel::Schema::Index.new('foo_idx', :foo).should_not be_multi_column
    Sequel::Schema::Index.new('foo_idx', [:foo, :bar]).should be_multi_column
  end

  it "should not be unique by default" do
    Sequel::Schema::Index.new('foo_idx', :foo).should_not be_unique
  end

  it "can be unique" do
    Sequel::Schema::Index.new('foo_idx', :foo, true).should be_unique
  end

  it "should be comparable with ==" do
    i1 = Sequel::Schema::Index.new('foo_idx', :foo, true)
    i2 = Sequel::Schema::Index.new('foo_idx', :foo, true)

    i1.should == i2
    i1.should be_eql(i2)
    i1.hash.should == i2.hash
  end

  it "should clone the provided columns argument" do
    columns = [:foo, :bar]
    Sequel::Schema::Index.new('foo_idx', columns).columns << :baz
    columns.should == [:foo, :bar]
  end
end
