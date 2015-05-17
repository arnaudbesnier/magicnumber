var _                 = require('underscore'),
    magicNumberFinder = require('../lib/magicNumberFinder');

function methodsValidator(test, config) {
    test.expect(config.numbersValid.length + config.numbersInvalid.length);

    _.each(config.numbersValid, function(number) {
      test.ok(magicNumberFinder.create(number)[config.method]());
    });

    _.each(config.numbersInvalid, function(number) {
      test.ok(!magicNumberFinder.create(number)[config.method]());
    });

    test.done();
}

exports.hasOneOfTheDigitsThatIsSumOfTheOthers = function(test) {
    methodsValidator(test, {
        method:         'hasOneOfTheDigitsThatIsSumOfTheOthers',
        numbersValid:   [0, 44, 123, 211, 808, 1113, 6321, 9234, 40048],
        numbersInvalid: [4, 21, 111, 322, 414, 9233, 40049]
    });
};

exports.isDecreasingSequence = function(test) {
    methodsValidator(test, {
        method:         'isDecreasingSequence',
        numbersValid:   [0, 1, 5, 10, 42, 431, 2222, 4332, 11110],
        numbersInvalid: [12, 808, 2223, 9234, 40048, 43219]
    });
};

exports.hasAtLeast2OddDigits = function(test) {
    methodsValidator(test, {
        method:         'hasAtLeast2OddDigits',
        numbersValid:   [11, 13, 123, 155, 9127, 9221, 11011, 33333, 129546],
        numbersInvalid: [0, 1, 10, 12, 100, 122, 808, 40048]
    });
};

exports.areAllDigitsDifferent = function(test) {
    methodsValidator(test, {
        method:         'areAllDigitsDifferent',
        numbersValid:   [2, 3, 10, 19, 102, 123, 1456, 2457, 4356, 987654321],
        numbersInvalid: [11, 122, 808, 1499, 40048, 9876543219]
    });
};

exports.isThe4thDigitEven = function(test) {
    methodsValidator(test, {
        method:         'isThe4thDigitEven',
        numbersValid:   [1004, 1006, 1234, 10045, 10046, 11161, 444444, 543874],
        numbersInvalid: [2, 3, 10, 19, 102, 123, 4355, 10056, 444944]
    });
};

exports.productOfAllDigitsIsNotMultipleOf5 = function(test) {
    methodsValidator(test, {
        method:         'productOfAllDigitsIsNotMultipleOf5',
        numbersValid:   [1, 88, 144, 2364],
        numbersInvalid: [0, 100, 15, 30, 55, 255, 524, 808, 40048]
    });
};

exports.contains3OddDigitsInARow = function(test) {
    methodsValidator(test, {
        method:         'contains3OddDigitsInARow',
        numbersValid:   [111, 357, 9753, 23578, 555087, 89990, 1109998],
        numbersInvalid: [0, 13, 100, 112, 808, 11011, 13477, 40048, 89900]
    });
};

exports.isPrimeNumber = function(test) {
    methodsValidator(test, {
        method:         'isPrimeNumber',
        numbersValid:   [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 97],
        numbersInvalid: [0, 1, 4, 6, 9, 12, 20, 21, 99, 808, 40048]
    });
};

exports.containsAtLeast2EvenDigitsInARow = function(test) {
    methodsValidator(test, {
        method:         'containsAtLeast2EvenDigitsInARow',
        numbersValid:   [20, 22, 100, 808, 2457, 40048, 89900, 124576],
        numbersInvalid: [0, 11, 123, 231, 233, 23456]
    });
};

exports.isTheProductOfAllOddDigitsASquareNumber = function(test) {
    methodsValidator(test, {
        method:         'isTheProductOfAllOddDigitsASquareNumber',
        numbersValid:   [1, 19, 29, 99, 999, 1255, 1299, 10000, 40049],
        numbersInvalid: [0, 7, 15, 22, 777, 808, 40048]
    });
};

exports.containsDigit = function(test) {
    test.expect(20);

    test.ok(magicNumberFinder.create(10234).containsDigit(0));
    test.ok(magicNumberFinder.create(10234).containsDigit(1));
    test.ok(magicNumberFinder.create(10234).containsDigit(2));
    test.ok(magicNumberFinder.create(10234).containsDigit(3));
    test.ok(magicNumberFinder.create(10234).containsDigit(4));
    test.ok(magicNumberFinder.create(56798).containsDigit(5));
    test.ok(magicNumberFinder.create(56798).containsDigit(6));
    test.ok(magicNumberFinder.create(56798).containsDigit(7));
    test.ok(magicNumberFinder.create(56798).containsDigit(8));
    test.ok(magicNumberFinder.create(56798).containsDigit(9));

    test.ok(!magicNumberFinder.create(56798).containsDigit(0));
    test.ok(!magicNumberFinder.create(56798).containsDigit(1));
    test.ok(!magicNumberFinder.create(56798).containsDigit(2));
    test.ok(!magicNumberFinder.create(56798).containsDigit(3));
    test.ok(!magicNumberFinder.create(56798).containsDigit(4));
    test.ok(!magicNumberFinder.create(10234).containsDigit(5));
    test.ok(!magicNumberFinder.create(10234).containsDigit(6));
    test.ok(!magicNumberFinder.create(10234).containsDigit(7));
    test.ok(!magicNumberFinder.create(10234).containsDigit(8));
    test.ok(!magicNumberFinder.create(10234).containsDigit(9));

    test.done();
};

exports.isValid = function(test) {
    var numbersValid   = [808, 2110, 3210, 4048, 4408, 4804, 8044, 8080, 8404, 40048],
        numbersInvalid = [0, 1, 2, 3, 4, 806, 807]
    test.expect(numbersValid.length + numbersInvalid.length);

    _.each(numbersValid, function(number) {
      test.ok(magicNumberFinder.create(number).isValid());
    });

    _.each(numbersInvalid, function(number) {
      test.ok(!magicNumberFinder.create(number).isValid());
    });

    test.done();
};
