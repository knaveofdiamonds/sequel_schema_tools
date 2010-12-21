require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sequel::Schema::SchemaParser do
  it "should return a SchemaParser from for_db factory method" do
    Sequel::Schema::SchemaParser.for_db(stub(:database)).should \
      be_kind_of(Sequel::Schema::SchemaParser)
  end
end
