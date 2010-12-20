require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::SchemaParser do
  it "should return a SchemaParser from for_db factory method" do
    Sequel::Schema::SchemaParser.for_db(stub(:database)).should \
      be_kind_of(Sequel::Schema::SchemaParser)
  end
end

describe "Column returned from parsing a column array from DB.schema(:table)" do
  before :each do
    @parser = Sequel::Schema::SchemaParser.for_db(stub(:database))
    @column = [:example_column, 
               { :type => :integer, 
                 :default => "1", 
                 :ruby_default => 1, 
                 :primary_key => false, 
                 :db_type => "smallint(11)", 
                 :allow_null => true }]
  end

  it "should contain the :name of the column" do
    @parser.parse_column(@column).name.should == :example_column
  end

  it "should contain the :type of the column" do
    @parser.parse_column(@column).type.should == :smallint
  end

  it "should have the type :integer when db type is int(11)" do
    @column.last[:db_type] = "int(11)"
    @parser.parse_column(@column).type.should == :integer
  end

  it "should have the type :boolean when db type is tinyint(1)" do
    @column.last[:db_type] = "tinyint(1)"
    @parser.parse_column(@column).type.should == :boolean
  end

  it "should have the type :tinyint when db type is tinyint(2)" do
    @column.last[:db_type] = "tinyint(2)"
    @parser.parse_column(@column).type.should == :tinyint
  end

  it "should have the type :text when db type is text" do
    @column.last[:db_type] = "text"
    @parser.parse_column(@column).type.should == :text
  end

  it "should be enum when enum values contain brackets" do
    @column.last[:db_type] = "enum('foo (bar)', 'baz')"
    @parser.parse_column(@column).type.should == :enum
  end

  it "should use the ruby default if it is present." do
    @parser.parse_column(@column).default.should == 1
  end

  it "should have a default of 1" do
    @parser.parse_column(@column).default.should == 1
  end

  it "should parse the allow null flag" do
    @parser.parse_column(@column).should be_allow_null
  end
end
