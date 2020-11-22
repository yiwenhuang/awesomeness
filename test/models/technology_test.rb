require 'test_helper'

class TechnologyTest < ActiveSupport::TestCase
  test "unique repository url" do
    t1 = Technology.create(name: "test 1", repo_url: "http://github.com/yiwenhuang/awesomeness")

    t2 = Technology.create(name: "test 2", repo_url: "http://github.com/yiwenhuang/awesomeness")
    assert_nil t2.id
  end

  test "has many categories" do
    t1 = Technology.create(name: "test 1", repo_url: "http://github.com/yiwenhuang/awesomeness")
    t1.categories.create(name: "cat 1", technology_id: t1.id)
    t1.categories.create(name: "cat 2", technology_id: t1.id)

    assert_equal 2, t1.categories.size
  end
end
