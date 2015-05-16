_ = require 'underscore'

class MagicNumberValidator

  constructor: (@number) ->
    @digits               = @number.toString(10).split('').map(Number)
    @digitsSum            = @digits.reduce (sum, digit)   -> sum + digit
    @digitsMultiplication = @digits.reduce ((multi, digit) -> multi * digit), 1
    @digitsOdd            = @digits.filter (digit) -> digit %% 2 is 1

    if @digitOdd?
      @digitsOddMultiplication = @digitsOdd.reduce ((multi, digit) -> multi * digit), 1
    else
      @digitOdd = []
      @digitsOddMultiplication = 0

  isValid: =>
    return false if @checkProperty0() isnt @containsDigit(0)
    return false if @checkProperty1() isnt @containsDigit(1)
    return false if @checkProperty2() isnt @containsDigit(2)
    return false if @checkProperty3() isnt @containsDigit(3)
    return false if @checkProperty4() isnt @containsDigit(4)
    return false if @checkProperty5() isnt @containsDigit(5)
    return false if @checkProperty6() isnt @containsDigit(6)
    return false if @checkProperty7() isnt @containsDigit(7)
    return false if @checkProperty8() isnt @containsDigit(8)
    return false if @checkProperty9() isnt @containsDigit(9)
    true

  containsDigit: (digit) => digit in @digits

  # NOTICE: One of the digits is the sum of the others
  checkProperty0: =>
    for digit in @digits
      return true if digit is (@digitsSum - digit)
    false

  # NOTICE: The digits form a decreasing sequence
  checkProperty1: =>
    digitCurrent = 10
    for digit in @digits
      if digitCurrent > digit
        digitCurrent = digit
      else
        return false
    true

  # NOTICE: It has at least 2 odd digits
  checkProperty2: => @digitsOdd.length >= 2

  # NOTICE: All digits are different
  checkProperty3: => @digits.length is _.uniq(@digits).length

  # NOTICE: The 4th digit is even
  checkProperty4: => ((@digits[3] or 1) %% 2) is 0

  # NOTICE: The product of all digits is not a multiple of 5
  checkProperty5: => (@digitsMultiplication %% 5) isnt 0

  # NOTICE: The number contains 3 odd digits in a row
  checkProperty6: =>
    oddDigitsCount = 0
    for digit in @digits
      if digit %% 2 is 1
        oddDigitsCount++
        return true if oddDigitsCount >= 3
      else
        oddDigitsCount = 0
    false

  # NOTICE: It is a prime number
  checkProperty7: =>
    return false if @number < 2
    for value in [2..@number]
      return false if @number %% value is 0
    true

  # NOTICE: It has at least 2 even digits in a row
  checkProperty8: =>
    evenDigitsCount = 0
    for digit in @digits
      if digit %% 2 is 0
        evenDigitsCount++
        return true if evenDigitsCount >= 2
      else
        evenDigitsCount = 0
    false

  # NOTICE: The product of all odd digits is a square number
  checkProperty9: =>
    return false if @digitsOdd.length is 0
    Math.sqrt(@digitsOddMultiplication) is Math.abs(Math.sqrt(@digitsOddMultiplication))

exports.find = ->

  # validator = new MagicNumberValidator(40048)
  # if validator.isValid()
  #   console.log "The magic number is 40048!"

  for number in [0..10000]
    validator = new MagicNumberValidator(number)

    if validator.isValid()
      console.log "The magic number is #{number}!"
      return

exports.find()
