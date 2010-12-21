require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::Table do
  it "should have a name" do
    Sequel::Schema::Table.new("example").name.should == "example"
  end

  it "can have arbitrary table options" do
    Sequel::Schema::Table.new("example", :foo => :bar).options.should == {:foo => :bar}
  end
end
