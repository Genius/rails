require 'abstract_unit'
require 'action_controller/params_hash_with_indifferent_access'
require 'active_support/ordered_hash'

class ParamsHashWithIndifferentAccessTest < Test::Unit::TestCase

  def params_hash(hash)
    ParamsHashWithIndifferentAccess.new(hash)
  end


  def test_nested_hashes_become_params_hashes
    hash = params_hash({ 'urls' => { 'url' => [ { 'address' => '1' }, { 'address' => '2' } ] } })

    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls']['url'][0].is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls']['url'][1].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_nested_indifferent_hashes_become_params_hashes
    hash = params_hash({ 'urls' => { 'url' => [ { 'address' => '1' }, { 'address' => '2' } ] }.with_indifferent_access })

    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls']['url'][0].is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls']['url'][1].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_nested_ordered_hashes_are_not_params_hashes
    hash = params_hash({ 'urls' => ActiveSupport::OrderedHash.new({ 'url' => 'address' }) })

    assert !hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_dup
    hash = params_hash({ 'urls' => { 'url' => 'address' } })

    assert hash.dup.is_a?(ParamsHashWithIndifferentAccess)
    assert hash.dup['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_slice
    hash = params_hash({ 'urls' => { 'url' => 'address' } })

    assert hash.slice('urls').is_a?(ParamsHashWithIndifferentAccess)
    assert hash.slice('urls')['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_merge
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash = hash.merge('foo' => 'bar')

    assert hash.is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_merge_bang
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash.merge!('foo' => 'bar')

    assert hash.is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_nested_params_hash_stays_params_hash_on_values_at
    hash = params_hash({ 'urls' => { 'url' => 'address' } })

    assert hash.values_at('urls')[0].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_slice_bang
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash.slice!('urls')

    assert hash.is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_stays_params_hash_on_reverse_merge
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash = hash.reverse_merge('foo' => { 'bar' => 'baz' })

    assert hash.is_a?(ParamsHashWithIndifferentAccess)
    assert hash['urls'].is_a?(ParamsHashWithIndifferentAccess)
    assert hash['foo'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_converts_other_hash_on_merge
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash = hash.merge('foo' => { 'bar' => 'baz' })

    assert hash['foo'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_converts_other_hash_on_merge_bang
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash.merge!('foo' => { 'bar' => 'baz' })

    assert hash['foo'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_converts_other_hash_on_set_key
    hash = params_hash({ 'urls' => { 'url' => 'address' } })
    hash['foo'] = { 'bar' => 'baz' }

    assert hash['foo'].is_a?(ParamsHashWithIndifferentAccess)
  end

  def test_params_hash_behaves_like_a_hash
    hash = params_hash({ 'urls' => { 'url' => 'address' } })

    hash['setter'] = 'setter value'
    hash = hash.merge('merge' => 'merge value')
    hash.merge!('merge_bang' => 'merge bang value')

    expected_hash = {
      'urls' => {
        'url' => 'address'
      },
      'setter' => 'setter value',
      'merge' => 'merge value',
      'merge_bang' => 'merge bang value',
    }
    assert_equal expected_hash, hash
  end

  def test_params_hash_is_indifferent
    hash = params_hash({ 'urls' => { 'url' => [ { 'address' => '1' }, { 'address' => '2' } ] } })

    assert_equal '2', hash[:urls][:url][1][:address]
  end

  def test_with_indifferent_access_returns_a_params_hash
    hash = params_hash({ 'foo' => 'bar'})
    hash = hash.with_indifferent_access

    assert hash.is_a?(ParamsHashWithIndifferentAccess)
    assert hash['foo'] == 'bar'
  end

end
