require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::ColumnParser do
  before :each do
    @parser = Sequel::Schema::ColumnParser.new
    @column = [:example_column, 
               { :type => :integer, 
                 :default => "1", 
                 :ruby_default => 1, 
                 :primary_key => false, 
                 :db_type => "smallint(11)", 
                 :allow_null => true }]
  end

    it "should return a numeric column for integers" do
    @parser.parse(@column).should be_kind_of(Sequel::Schema::NumericColumn)
  end

  it "should return a textual column for varchar" do
    @column.last[:db_type] = "varchar(255)"
    @parser.parse(@column).should be_kind_of(Sequel::Schema::TextualColumn)
  end

  it "should return an enumerate column for enum" do
    @column.last[:db_type] = "enum('one', 'two')"
    @parser.parse(@column).should be_kind_of(Sequel::Schema::EnumeratedColumn)
  end

  it "should return a plain column for an unknown type" do
    @column.last[:db_type] = "foo(255)"
    @parser.parse(@column).should be_kind_of(Sequel::Schema::Column)
  end

  it "should contain the :name of the column" do
    @parser.parse(@column).name.should == :example_column
  end

  it "should contain the :type of the column" do
    @parser.parse(@column).type.should == :smallint
  end

  it "should have the type :integer when db type is int(11)" do
    @column.last[:db_type] = "int(11)"
    @parser.parse(@column).type.should == :integer
  end

  it "should have the type :boolean when db type is tinyint(1)" do
    @column.last[:db_type] = "tinyint(1)"
    @parser.parse(@column).type.should == :boolean
  end

  it "should have the type :tinyint when db type is tinyint(2)" do
    @column.last[:db_type] = "tinyint(2)"
    @parser.parse(@column).type.should == :tinyint
  end

  it "should have the type :text when db type is text" do
    @column.last[:db_type] = "text"
    @parser.parse(@column).type.should == :text
  end

  it "should be enum when enum values contain brackets" do
    @column.last[:db_type] = "enum('foo (bar)', 'baz')"
    @parser.parse(@column).type.should == :enum
  end

  it "should use the ruby default if it is present." do
    @parser.parse(@column).default.should == 1
  end

  it "should have a default of 1" do
    @parser.parse(@column).default.should == 1
  end

  it "should parse the allow null flag" do
    @parser.parse(@column).allow_null?.should == true
  end
end
