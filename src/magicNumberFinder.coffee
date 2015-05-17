_ = require 'underscore'

class MagicNumberValidator

  properties: => [
    @hasOneOfTheDigitsThatIsSumOfTheOthers   # Property 0
    @isDecreasingSequence                    # Property 1
    @hasAtLeast2OddDigits                    # Property 2
    @areAllDigitsDifferent                   # Property 3
    @isThe4thDigitEven                       # Property 4
    @productOfAllDigitsIsNotMultipleOf5      # Property 5
    @contains3OddDigitInARow                 # Property 6
    @isPrimeNumber                           # Property 7
    @hasAtLeast2EvenDigitsInARow             # Property 8
    @isTheProductOfAllOddDigitsASquareNumber # Property 9
  ]

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
    for digit in [0...9]
      return false if @properties()[digit]() isnt @containsDigit(digit)
    true

  containsDigit: (digit) => digit in @digits

  hasOneOfTheDigitsThatIsSumOfTheOthers: =>
    for digit in @digits
      return true if digit is (@digitsSum - digit)
    false

  isDecreasingSequence: =>
    digitCurrent = 10
    for digit in @digits
      if digitCurrent > digit
        digitCurrent = digit
      else
        return false
    true

  hasAtLeast2OddDigits: => @digitsOdd.length >= 2

  areAllDigitsDifferent: => @digits.length is _.uniq(@digits).length

  isThe4thDigitEven: => ((@digits[3] or 1) %% 2) is 0

  productOfAllDigitsIsNotMultipleOf5: => (@digitsMultiplication %% 5) isnt 0

  contains3OddDigitInARow: =>
    oddDigitsCount = 0
    for digit in @digits
      if digit %% 2 is 1
        oddDigitsCount++
        return true if oddDigitsCount >= 3
      else
        oddDigitsCount = 0
    false

  isPrimeNumber: =>
    return false if @number < 2
    for value in [2..@number]
      return false if @number %% value is 0
    true

  hasAtLeast2EvenDigitsInARow: =>
    evenDigitsCount = 0
    for digit in @digits
      if digit %% 2 is 0
        evenDigitsCount++
        return true if evenDigitsCount >= 2
      else
        evenDigitsCount = 0
    false

  isTheProductOfAllOddDigitsASquareNumber: =>
    return false if @digitsOdd.length is 0
    Math.sqrt(@digitsOddMultiplication) is Math.abs(Math.sqrt(@digitsOddMultiplication))

exports.create = (number) ->
  new MagicNumberValidator number

exports.findSmaller = ->
  for number in [0..40048]
    if new MagicNumberValidator(number).isValid()
      return console.log "The magic number is #{number}!"

exports.findSmaller()
