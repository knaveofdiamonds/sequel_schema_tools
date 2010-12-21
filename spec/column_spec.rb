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

describe Sequel::Schema::NumericColumn do
  it "should not be unsigned by default" do
    Sequel::Schema::NumericColumn.new('foo', 'integer').should_not be_unsigned
  end
  
  it "can be unsigned" do
    Sequel::Schema::NumericColumn.new('foo', 'integer', :unsigned => true).should be_unsigned
  end
end

describe Sequel::Schema::EnumeratedColumn do
  it "should have no elements by default" do
    Sequel::Schema::EnumeratedColumn.new('foo', 'enum').elements.should == []
  end

  it "can have elements" do
    Sequel::Schema::EnumeratedColumn.new('foo', 'enum', :elements => ['one']).
      elements.should == ['one']
  end
end

describe Sequel::Schema::TextualColumn do
  it "should have a size of 255 by default" do
    Sequel::Schema::TextualColumn.new('foo', 'char').size.should == 255
  end

  it "can have a size" do
    Sequel::Schema::TextualColumn.new('foo', 'enum', :size => 30).size.should == 30
  end

  it "can have a charset" do
    Sequel::Schema::TextualColumn.new('foo', 'enum', :charset => 'utf8').charset.
      should == 'utf8'
  end
end

