import 'dart:convert';

void main() {
  // dividingByZero();
  // noSuchMethod();
  // formatException();
  // readingStackTraces();
  // debugging();
  // catchingExceptions();
  handlingSpecificExceptions();
  // handlingMultipleExceptions();
  // finallyBlock();
  // writingCustomExceptions();
}

void dividingByZero() {
  print('// dividingByZero');
  print(1 / 0); // does not crash; returns Infinity
  // 1 ~/ 0; // IntegerDivisionByZeroException
}

void noSuchMethod() {
  print('// noSuchMethod');

  // ignore: avoid_init_to_null
  dynamic x = null; // run-time error
  // int x = null; // compile-time error
  print(x.isEven); // NoSuchMethodError
}

void formatException() {
  print('// formatException');

  // const malformedJson = 'abc';
  // jsonDecode(malformedJson);

  int.parse('42');
  // int.parse('hello'); // FormatException

  int.parse('DAD', radix: 16);
  int.parse('FED', radix: 16);
  int.parse('BEEF', radix: 16);
  int.parse('DEAD', radix: 16);
  int.parse('C0FFEE', radix: 16);
}

void readingStackTraces() {
  print('// readingStackTraces');
  functionOne();
}

void functionOne() {
  print('// functionOne');
  functionTwo();
}

void functionTwo() {
  print('\n// functionTwo');
  functionThree();
}

void functionThree() {
  print('\n// functionThree');
  int.parse('hello');
}

void debugging() {
  print('\n// debugging');

  final characters = ' abcdefghijklmnopqrstuvwxyz!';
  // final characters = ' abcdefghijklmnopqrstuvwxyz';
  final data = [4, 1, 18, 20, 0, 9, 19, 0, 6, 21, 14, 27];
  final buffer = StringBuffer();
  for (final index in data) {
    final letter = characters[index];
    buffer.write(letter);
  }
  print(buffer);
}

void catchingExceptions() {
  print('\n// catchingExceptions');

  const json = 'abc';
  // const json = '{"name":"bob"}';
  try {
    dynamic result = jsonDecode(json);
    print(result);
  } catch (e) {
    // catch (e, s) if you want to access to the StackTrace object
    print('There was an error.');
    print(e);
  }
}

void handlingSpecificExceptions() {
  print('\n// handlingSpecificExceptions');

  const json = 'abc';
  try {
    dynamic result = jsonDecode(json);
    print('$result');
  } on FormatException {
    print('The JSON string was invalid.');
  }
}

void handlingMultipleExceptions() {
  print('\n// handlingMultipleExceptions');

  const numberStrings = ["42", "hello"];
  try {
    for (final numberString in numberStrings) {
      final number = int.parse(numberString);
      print(number ~/ 0);
    }
  } on FormatException {
    handleFormatException();
  } on UnsupportedError {
    handleDivisionByZero();
  }
}

void handleFormatException() {
  print("You tried to parse a non-numeric string.");
}

void handleDivisionByZero() {
  print("You can't divide by zero.");
}

void finallyBlock() {
  print('\n// finallyBlock');

  final database = FakeDatabase();
  database.open();
  try {
    final data = database.fetchData();
    final number = int.parse(data);
    print('The number is $number.');
  } on FormatException {
    print("Dart didn't recognize that as a number.");
  } finally {
    database.close();
  }
}

class FakeDatabase {
  void open() => print('Opening the database.');
  void close() => print('Closing the database.');
  String fetchData() => 'forty-two';
}

class PasswordTooShort implements Exception {
  PasswordTooShort(this.message);
  final String message;
}

class NoNumber implements Exception {
  NoNumber(this.message);
  final String message;
}

class NoUppercase implements Exception {
  NoUppercase(this.message);
  final String message;
}

class NoLowercase implements Exception {
  NoLowercase(this.message);
  final String message;
}

void writingCustomExceptions() {
  print('\n// writingCustomExceptions');

  // const password = 'password1234';
  const password = '1234';

  // on ... catch ...
  try {
    validatePassword(password);
    print('Password is valid');
  } on PasswordTooShort catch (e, s) {
    print('Stacktrace:\n${s.toString()}');
    print(e.message);
  } on NoLowercase catch (e) {
    print(e.message);
  } on NoUppercase catch (e) {
    print(e.message);
  } on NoNumber catch (e) {
    print(e.message);
  }
}

void validatePassword(String password) {
  print('\n// validatePassword');

  validateLength(password);
  validateLowercase(password);
  validateUppercase(password);
  validateNumber(password);
}

void validateLength(String password) {
  print('\n// validateLength');
  final goodLength = RegExp(r'.{12,}');
  if (!password.contains(goodLength)) {
    throw PasswordTooShort('Password must be at least 12 characters!');
  }
}

void validateLowercase(String password) {
  print('\n// validateLowercase');
  final lowercase = RegExp(r'[a-z]');
  if (!password.contains(lowercase)) {
    throw NoLowercase('Password must have a lowercase letter!');
  }
}

void validateUppercase(String password) {
  print('\n// validateUppercase');
  final uppercase = RegExp(r'[A-Z]');
  if (!password.contains(uppercase)) {
    throw NoUppercase('Password must have an uppercase letter!');
  }
}

void validateNumber(String password) {
  print('\n// validateNumber');
  final number = RegExp(r'[0-9]');
  if (!password.contains(number)) {
    throw NoNumber('Password must have a number!');
  }
}
