require 'abstract_unit'
require 'action_controller/params_hash_with_indifferent_access'

class ParamsTest < ActionController::TestCase

  class ParamsTestController < ActionController::Base

    def some_action
      render :text => 'response'
    end

  end

  tests ParamsTestController

  def setup
    ActionController::Routing::Routes.reload
  end

  def test_params_is_a_params_hash_with_indifferent_access
    get :some_action, { 'key' => 'value' }
    assert @controller.params.is_a?(ParamsHashWithIndifferentAccess)
  end

end
