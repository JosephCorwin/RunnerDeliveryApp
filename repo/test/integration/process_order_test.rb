require 'test_helper'

class ProcessOrderTest < ActionDispatch::IntegrationTest

  def setup
    @boss = users(:boss)
    @cust = users(:michael)
    @arch = users(:archer)
    @run1 = users(:flash)
    @run2 = users(:dash)
  end

end
