require 'test_helper'

class CachesConstantsTest < ActiveSupport::TestCase
  
  test "test creating const with no option" do
    Model = Class.new(ActiveRecord::Base)
    Model.caches_constants
    assert_equal Model.first, Model::AAA
    assert_equal Model::ALL.first, Model::AAA
    assert_equal Model::ALL.last, Model::BBB
  end

  test "test creating const with name option" do
    Model = Class.new(ActiveRecord::Base)
    Model.caches_constants(:name => :label)
    assert_equal Model.first, Model::AAA_LABEL
  end

  test "test creating const with order option" do
    Model = Class.new(ActiveRecord::Base)
    Model.caches_constants(:order => :id)
    assert_equal Model::ALL.first, Model::AAA
    assert_equal Model::ALL.last, Model::CCC
  end
end
