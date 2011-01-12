require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::PrimaryKey do
  it "should have a name" do
    Sequel::Schema::PrimaryKey.new([]).name.should == :PRIMARY
  end

  it "should have columns" do
    Sequel::Schema::PrimaryKey.new([:foo, :bar]).columns.should == [:foo, :bar]
  end

  it "should be unique" do
    Sequel::Schema::PrimaryKey.new(:foo).should be_unique
  end
end
