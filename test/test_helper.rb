require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'test/unit'
require 'active_record'
require File.join(File.dirname(__FILE__), "../init.rb")

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :dbfile  => ":memory:"
)
ActiveRecord::Schema.define(:version => 1) do
  create_table :models do |t|
    t.string :name
    t.string :label
    t.integer :sort_order
    t.timestamps
  end
end

Model = Class.new(ActiveRecord::Base)
Model.create(:name => "aaa", :label => "aaa_label", :sort_order => 1)
Model.create(:name => "bbb", :label => "bbb_label", :sort_order => 3)
Model.create(:name => "ccc", :label => "ccc_label", :sort_order => 2)
