#!/usr/bin/env ruby
# file: cn_check.rb

## CreditCard Class
class CreditCard
  
  attr_accessor :number

  def initialize(number = "")
    
    # Strip any white space
    @number  = number.gsub(/\s*/, '')
    
    # Card rules
    @@type_rules = {
      "AMEX" => {lengths: [15], begins: /^(34|37)/},
      "Discover" => {lengths: [16], begins: /^6011/},
      "MasterCard" => {lengths: [16], begins: /^5[1-5]/},
      "VISA" => {lengths: [13, 16], begins: /^4/}     
    }
    
  end
  
  ## Return the card number type or 'Unknown' based on @@type_rules
  def type
    output = "Unknown"
    @@type_rules.each do |name, rules|
      output = name if @number =~ rules[:begins] && rules[:lengths].include?(@number.length)
    end
    output
  end

  ## test the validity of the number using Luhn algorithm
  def valid?  
    sum = 0    
    @number.split("").reverse.each_with_index do |value, index| 
      value = value.to_i
      # Double every digit starting from the second to last 
      value+=value if(index %2 != 0)
       
      # For digits greater than 9 split them and sum them independently
      value  = value.to_s.split('').collect{|i| i.to_i}.inject(:+) if(value >= 10)      
      sum +=value
      
      # make sure the number is numeric only
    end if @number =~ /^[0-9]+$/
    
    # Valid if that total is a multiple of 10 and it's not zero
    sum % 10 == 0 && sum != 0    
  end
  
end

## function to pass in numbers (excepts single and multi-lined strings)
# Arg: numbers - String (Single, multiline)
# Arg: no_output - suppress puts (usefull for testing)
def validate_cards(numbers = "", no_output = false)
      
    # if a String split it on the new line. Reject any empty values
   numbers_array = numbers.split(/\n/).reject(&:empty?) if numbers.is_a? String 
   
   # used to store the message ouputs
   ouputs = []
   
   # iterate through numbers and print message
   numbers_array.each do |number|
     card = CreditCard.new(number)
     output = "%-12s %-20s %s" % ["#{card.type}:", card.number, "(#{(card.valid? ? 'valid' : 'invalid')})"]
     # output the message
     puts output if !no_output
     # push the message to array
     ouputs << output
   end
    
   # if no numbers, show no numbers message
   puts "No numbers found" if numbers_array.length == 0 && !no_output
    
   #return the messages as array (good for testing)
   ouputs  
   
end

# if running from file
if $0 == __FILE__
  
  # if no arguments show prompt
  abort("Usage: #$0 <credit card number>") if ARGV.length < 1
  
  # send it to validate
  validate_cards(ARGV.join) 

end