require 'abstract_unit'
require 'active_support/legacy_methods'

class LegacyMethodsTest < Test::Unit::TestCase
  class TestClass
    def public_method
    end

    protected

    def protected_method
    end

    private

    def private_method
    end
  end

  def test_respond_to_for_public_methods
    test_object = TestClass.new
    assert ActiveSupport.legacy_respond_to?(test_object, :public_method)
    assert ActiveSupport.legacy_respond_to?(test_object, :public_method, true)
  end

  def test_respond_to_for_protected_methods
    test_object = TestClass.new
    assert ActiveSupport.legacy_respond_to?(test_object, :protected_method)
    assert ActiveSupport.legacy_respond_to?(test_object, :protected_method, true)
  end

  def test_respond_to_for_private_methods
    test_object = TestClass.new
    assert !ActiveSupport.legacy_respond_to?(test_object, :private_method)
    assert ActiveSupport.legacy_respond_to?(test_object, :private_method, true)
  end
end
