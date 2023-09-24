// Futures have three possible states:
// - Uncompleted.
// - Completed with a value.
// - Completed with an error.

// There are two ways to get at the value after a future completes.
// - with callbacks
// - with async-await

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// activate only one line at a time otherwise code will intersperse
Future<void> main() async {
  // await futureType();
  // await usingCallbacks();
  // await usingAsyncAwait();
  // await usingAsyncAwaitWithErrorHandling();
  await asynchronousNetworkRequest();
  // await creatingFutureFromScratch();
}

Future<void> futureType() async {
  print('// futureType');
  final numberOfAtoms = await countTheAtoms();
  print(numberOfAtoms);

  final myFuture = Future<int>.delayed(
    Duration(seconds: 1),
    () => 42,
  );
  print(myFuture);
}

Future<int> countTheAtoms() async {
  print('// countTheAtoms');
  return 9200000000000000000;
}

// using a callback in '.then'
Future<void> usingCallbacks() async {
  print('// usingCallbacks');
  print('Before the future');

  // ignore: unused_local_variable
  final myFuture = Future<int>.delayed(
    Duration(seconds: 1),
    () => 42,
  )
      .then(
        (value) => print('Value: $value'),
      )
      .catchError(
        (Object error) => print('Error: $error'),
      )
      .whenComplete(
        () => print('Future is complete'),
      );

  print('After the future');
}

// If a function uses the await keyword anywhere in its body, it must return a Future and add the async
// keyword before the opening curly brace. Using async clearly tells Dart this is an asynchronous function and
// that the results will go to the event queue. Because main doesn’t return a value, you use Future<void> .
Future<void> usingAsyncAwait() async {
//                             ^^^^^
  print('// usingAsyncAwait');
  print('Before the future');

  // type of value is 'int'
  final value = await Future<int>.delayed(
//              ^^^^^
//        Future must complete
    Duration(seconds: 1),
    () => 42,
  );
  print('Value: $value');

  print('After the future');
}

Future<void> usingAsyncAwaitWithErrorHandling() async {
  print('// usingAsyncAwaitWithErrorHandling');
  print('Before the future');

  try {
    final value = await Future<int>.delayed(
      Duration(seconds: 1),
      () => 42,
    );
    print('Value: $value');
  } catch (error) {
    print(error);
  } finally {
    print('Future is complete');
  }

  print('After the future');
}

// This is coming back from 'https://jsonplaceholder.typicode.com/todos/1':
// {
//   "userId": 1,
//   "id": 1,
//   "title": "delectus aut autem",
//   "completed": false
// }

Future<void> asynchronousNetworkRequest() async {
  print('// asynchronousNetworkRequest');
  try {
    final url = 'https://jsonplaceholder.typicode.com/todos/1';
    // final url = 'https://jsonplaceholder.typicode.com/todos/does-not-exist';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    final statusCode = response.statusCode;
    print('Status Code: $statusCode');
    if (statusCode != 200) {
      throw HttpException('$statusCode');
    }
    final jsonString = response.body;
    dynamic jsonMap = jsonDecode(jsonString);
    final todo = Todo.fromJson(jsonMap);
    print(todo);
  } on SocketException catch (e) {
    print(e);
  } on HttpException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}

class Todo {
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> jsonMap) {
    return Todo(
      userId: jsonMap['userId'] as int,
      id: jsonMap['id'] as int,
      title: jsonMap['title'] as String,
      completed: jsonMap['completed'] as bool,
    );
  }

  final int userId;
  final int id;
  final String title;
  final bool completed;

  @override
  String toString() {
    return 'Todo:\n  userId: $userId\n'
        '  id: $id\n'
        '  title: $title\n'
        '  completed: $completed';
  }
}

// Create a Future using
// - Future constructors: unnamed constructor, value, error, delayed.
// - a return value from an async method
// - a Completer
Future<void> creatingFutureFromScratch() async {
  print('// creatingFutureFromScratch');
  // activate one of these fake web servers:
  // final web = FakeWebServer();
  // final web = FakeWebServerAsyncMethod();
  // final web = FakeWebServerValueNamedConstructor();
  // final web = FakeWebServerErrorNamedConstructor();
  // final web = FakeWebServerDelayedValue();
  // final web = FakeWebServerDelayedError();
  final web = FakeWebServerCompleter();
  try {
    final city = 'Portland';
    // final city = 'Stuttgart';
    final degrees = await web.fetchTemperature(city);
    print("It's $degrees degrees in $city.");
  } on ArgumentError catch (error) {
    print(error);
  }
}

abstract class DataRepository {
  Future<double> fetchTemperature(String city);
}

// Using unnamed constructor.
class FakeWebServer implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future(() => 42.0);
  }
}

class FakeWebServerAsyncMethod implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) async {
    return 42.0;
  }
}

// Using different constructors.

class FakeWebServerValueNamedConstructor implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.value(42.0);
  }
}

class FakeWebServerErrorNamedConstructor implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.error(ArgumentError("$city doesn't exist."));
  }
}

class FakeWebServerDelayedValue implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.delayed(
      Duration(seconds: 2),
      () => 42.0,
    );
  }
}

class FakeWebServerDelayedError implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    return Future.delayed(
      Duration(seconds: 2),
      () => throw ArgumentError('City does not exist.'),
    );
  }
}

// Using a completer.
class FakeWebServerCompleter implements DataRepository {
  @override
  Future<double> fetchTemperature(String city) {
    final completer = Completer<double>();
    if (city == 'Portland') {
      completer.complete(42.0);
    } else {
      completer.completeError(ArgumentError("City doesn't exist."));
    }
    return completer.future;
  }
}
