require "test/test_helper"

class VerifiableTest < Test::Unit::TestCase

  def test_has_many_verifiable
    u = User.create!
    p = u.phone_numbers.create!
    assert_equal [], u.phone_numbers
    assert_equal [p], u.unverified_phone_numbers
    code = p.verification_code_for(u)
    u.verify!(p, code)
    assert_equal [p], u.phone_numbers(true)
    assert_equal [], u.unverified_phone_numbers(true)
  end

  def test_verifiable_for
    u = User.create!
    p = u.phone_numbers.create!
    assert_equal [], p.users
    assert_equal [u], p.unverified_users
    code = u.verification_code_for(p)
    p.verify!(u, code)
    assert_equal [u], p.users(true)
    assert_equal [], p.unverified_users(true)
  end

  def test_verification_code_for
    u = User.create!
    p = u.phone_numbers.create!
    assert_equal u.verification_code_for(p), p.verification_code_for(u)
  end

  def test_verify
    u = User.create!
    p = u.phone_numbers.create!
    code = u.verification_code_for(p)
    assert u.verify!(p, code)
  end

  def test_verify_with_bad_code
    u = User.create!
    p = u.phone_numbers.create!
    code = u.verification_code_for(p)
    assert_equal false, u.verify!(p, "xxxx")
  end

end
