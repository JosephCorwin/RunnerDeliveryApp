require 'test_helper'

class RunnerTest < ActiveSupport::TestCase

  def setup
    @user =       users(:michael)
    @other_user = users(:archer)
  end

  test "sanity" do

    #users are not runners by default
    assert_not @user.is_hired?

    #users can be hired
    assert_difference 'Runner.count', 1 do
      @user.is_hired!
    end
    assert @user.is_hired?

    #users can be fired
    @user.is_fired!
    assert_not @user.is_hired?

    #re-hiring a former runner does not create a new runner object
    assert_no_difference 'Runner.count' do
      @user.is_hired!
    end

  end

  test "expected bugs/hacks" do

    #runners cannot be created independantly
    runn_no_user = Runner.new
    runn_si_user = Runner.new(user_id: @other_user.id)
    assert_no_difference 'Runner.count' do
      runn_no_user.save
    end
    assert_no_difference 'Runner.count' do
      runn_si_user.save
    end

  end

end
