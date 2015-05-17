# magicnumber

## How to install

```
npm install magicnumber
```

## How to use

#### Retrieve THE magic number

```
var magicNumber = require('magicnumber');
magicNumber.findSmallest();
```

#### Check if a number (123) is a candidate for the magic number

```
var magicNumber = require('magicnumber');
console.log('Is 123 a candidate for the magic number? ' + magicNumber.create(123).isValid());
```

## How to execute unit tests

```
nodeunit test/magicNumberFinder.js
```
