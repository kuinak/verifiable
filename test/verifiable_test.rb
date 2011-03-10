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

  def test_custom_code
    u = User.create!
    p = PhoneNumber.create!
    v = Verifiable::Verification.create!(:code => "abcd", :object => u, :verifiable => p)
    assert_equal [], u.phone_numbers
    assert_equal [p], u.unverified_phone_numbers
    code = p.verification_code_for(u)
    assert_equal "abcd", code
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

  def test_has_many_verifiable_and_verifiable_for
    # ringtones have verifiable phone numbers and can be verified for users
    u = User.create!
    p = u.phone_numbers.create!
    r = u.ringtones.create!
    r.phone_numbers << p
    u.verify!(p, p.verification_code_for(u))
    u.verify!(r, r.verification_code_for(u))
    r.verify!(p, p.verification_code_for(r))
    assert_equal [u], r.users(true)
    assert_equal [], r.unverified_users(true)
    assert_equal [r], u.ringtones(true)
    assert_equal [], u.unverified_ringtones(true)
    assert_equal [p], r.phone_numbers(true)
    assert_equal [], r.unverified_phone_numbers(true)
    assert_equal [r], p.ringtones(true)
    assert_equal [], p.unverified_ringtones(true)
  end

end
