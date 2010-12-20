require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::Column do
  it "should have a name" do
    Sequel::Schema::Column.new('foo', 'varchar').name.should == :foo
  end

  it "should have a type" do
    Sequel::Schema::Column.new('foo', 'varchar').type.should == :varchar
  end

  it "should not allow NULL values by default" do
    Sequel::Schema::Column.new('foo', 'varchar').allow_null?().should == false
  end
  
  it "can allow NULL values" do
    Sequel::Schema::Column.new('foo', 'varchar',
                                 :allow_null => true).allow_null?().should == true
  end

  it "can have a default" do
    Sequel::Schema::Column.new('foo', 'varchar', :default => 'hi').default.should == 'hi'
  end
end

