_ = require 'underscore'

class MagicNumberValidator

  properties: => [
    @hasOneOfTheDigitsThatIsSumOfTheOthers   # Property 0
    @isDecreasingSequence                    # Property 1
    @hasAtLeast2OddDigits                    # Property 2
    @areAllDigitsDifferent                   # Property 3
    @isThe4thDigitEven                       # Property 4
    @productOfAllDigitsIsNotMultipleOf5      # Property 5
    @contains3OddDigitsInARow                # Property 6
    @isPrimeNumber                           # Property 7
    @containsAtLeast2EvenDigitsInARow        # Property 8
    @isTheProductOfAllOddDigitsASquareNumber # Property 9
  ]

  constructor: (@number) ->
    @digits    = @number.toString(10).split('').map(Number)
    @digitsOdd = @digits.filter (digit) -> digit %% 2 is 1

    @sumDigits        = @digits.reduce (sum, digit) -> sum + digit
    @productDigits    = @digits.reduce ((product, digit) -> product * digit), 1
    @productDigitsOdd = @digitsOdd.reduce ((product, digit) -> product * digit), 1

  isValid: =>
    for digit in [0...9]
      return false if @properties()[digit]() isnt @containsDigit(digit)
    true

  containsDigit: (digit) => digit in @digits

  hasOneOfTheDigitsThatIsSumOfTheOthers: =>
    for digit in @digits
      return true if digit is (@sumDigits - digit)
    false

  isDecreasingSequence: =>
    digitCurrent = 10
    for digit in @digits
      if digitCurrent >= digit
        digitCurrent = digit
      else
        return false
    true

  hasAtLeast2OddDigits: => @digitsOdd.length >= 2

  areAllDigitsDifferent: => @digits.length is _.uniq(@digits).length

  isThe4thDigitEven: => ((@digits[3] or 1) %% 2) is 0

  productOfAllDigitsIsNotMultipleOf5: => (@productDigits %% 5) isnt 0

  detectEvenOddDigitsRow: (lengthMin, moduloResult) =>
    countDigits = 0
    for digit in @digits
      if digit %% 2 is moduloResult
        countDigits++
        return true if countDigits >= lengthMin
      else
        countDigits = 0
    false

  contains3OddDigitsInARow: => @detectEvenOddDigitsRow(3, 1)

  containsAtLeast2EvenDigitsInARow: => @detectEvenOddDigitsRow(2, 0)

  isPrimeNumber: =>
    return false if @number < 2
    for value in [2..@number]
      return false if @number isnt value and @number %% value is 0
    true

  isTheProductOfAllOddDigitsASquareNumber: =>
    if @digitsOdd.length > 0
      squareValue = Math.sqrt @productDigitsOdd
      squareValue is Math.ceil(squareValue)
    else
      false

exports.create = (number) -> new MagicNumberValidator number

exports.findSmallest = ->
  for number in [0..40048]
    if new MagicNumberValidator(number).isValid()
      return console.log "The magic number is #{number}!"

exports.findSmallest()
