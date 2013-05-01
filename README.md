# Checking Credit Cards
Author: David Herse
Last Edited: 16/01/2013
Requires: Ruby 1.9.3

## Description
Takes credit card numbers – checks type and validity – returns array of strings in format "#{type}: #{number} (#{valid})"  

## Usage options

### Run test case
$ ruby tc_cn_check.rb

### In terminal - Pass a single number
$ ruby cn_check.rb 4408 0412 3456 7893

### In terminal - Pass multiple numbers separated by line breaks
$ ruby cn_check.rb "  
4111111111111111  
4012888888881881  
6011111111111117  
"

### In code - Pass a single number
validate_cards("4111111111111111")

### In code - Pass multiple lines
validate_cards("  
4111111111111111  
4111111111111  
4012888888881881  
")
