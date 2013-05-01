#!/usr/bin/env ruby
#tc_cn_check.rb

require 'test/unit'
require './cn_check.rb'

=begin

=Test Data expected results
VISA:        4111111111111111     (valid)
VISA:        4111111111111        (invalid)
VISA:        4012888888881881     (valid)
AMEX:        378282246310005      (valid)
Discover:    6011111111111117     (valid)
MasterCard:  5105105105105100     (valid)
MasterCard:  5105105105105106     (invalid)
Unknown:     9111111111111111     (invalid)

=end

class CardValidatorTest < Test::Unit::TestCase
 def test_type
   assert_equal('VISA', CreditCard.new('4111111111111111').type)
   assert_equal('VISA', CreditCard.new('4111111111111').type)
   assert_equal('VISA', CreditCard.new('4012888888881881').type)
   assert_equal('AMEX', CreditCard.new('378282246310005').type)
   assert_equal('Discover', CreditCard.new('6011111111111117').type)
   assert_equal('MasterCard', CreditCard.new('5105105105105100').type)
   assert_equal('MasterCard', CreditCard.new('5105 1051 0510 5106').type)
   assert_equal('Unknown', CreditCard.new('9111111111111111').type)

 end

 def test_valid
   assert(CreditCard.new('4111111111111111').valid?)
   assert(!CreditCard.new('4111111111111').valid?)
   assert(CreditCard.new('4012888888881881').valid?)
   assert(CreditCard.new('378282246310005').valid?)
   assert(CreditCard.new('6011111111111117').valid?)
   assert(CreditCard.new('5105105105105100').valid?)
   assert(!CreditCard.new('5105 1051 0510 5106').valid?)
   assert(!CreditCard.new('9111111111111111').valid?)
 end
 
 def test_validate_cards
   
   # test passing in a line seperated list
   puts "\n"
   oupts = validate_cards(
   '4111111111111111
   4111111111111
   4012888888881881
   378282246310005
   6011111111111117
   5105105105105100
   5105 1051 0510 5106
   9111111111111111')

   expected_outputs = [
     'VISA:        4111111111111111     (valid)',
     'VISA:        4111111111111        (invalid)',
     'VISA:        4012888888881881     (valid)',
     'AMEX:        378282246310005      (valid)',
     'Discover:    6011111111111117     (valid)',
     'MasterCard:  5105105105105100     (valid)',
     'MasterCard:  5105105105105106     (invalid)',
     'Unknown:     9111111111111111     (invalid)',
     ]
     
   oupts.to_enum.with_index do|output, i|
     assert_equal(expected_outputs[i], output)
     
   end
   
   # test passing in one number at a time
   assert_equal('VISA:        4111111111111111     (valid)', validate_cards('4111111111111111', true).first)
   assert_equal('VISA:        4111111111111        (invalid)', validate_cards('4111111111111', true).first)
   assert_equal('VISA:        4012888888881881     (valid)', validate_cards('4012888888881881', true).first)
   assert_equal('AMEX:        378282246310005      (valid)', validate_cards('378282246310005', true).first)
   assert_equal('Discover:    6011111111111117     (valid)', validate_cards('6011111111111117', true).first)
   assert_equal('MasterCard:  5105105105105100     (valid)', validate_cards('5105105105105100', true).first)
   assert_equal('MasterCard:  5105105105105106     (invalid)', validate_cards('5105 1051 0510 5106', true).first)
   assert_equal('Unknown:     9111111111111111     (invalid)', validate_cards('9111111111111111', true).first)
   assert_equal('Unknown:     s62fg2626f6s6d6f     (invalid)', validate_cards('s62fg2626f6s6d6f', true).first)
   
 end
 
end