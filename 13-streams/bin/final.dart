import 'dart:async';
import 'dart:convert';
import 'dart:io';

// activate just one line to make more sense of the output
Future<void> main() async {
  await readAsString();
  // readFromStream();
  // await readFromStreamAsynchronousForLoop();
  // errorHandlingUsingCallbacks();
  // await errorHandlingUsingTryCatch();
  // cancellingStreams();
  // transformingStreams();
  // creatingStreamsFromScratch();
}

Future<void> readAsString() async {
  print('// readAsString');
  final file = File('assets/text.txt');
  final contents = await file.readAsString();
  print(contents);
}

void readFromStream() {
  print('// readFromStream');
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data.length);
    },
  );
}

Future<void> readFromStreamAsynchronousForLoop() async {
  print('// readFromStreamAsynchronousForLoop');
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  await for (final data in stream) {
    print(data.length);
  }
}

void errorHandlingUsingCallbacks() {
  print('// errorHandlingUsingCallbacks');
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data.length);
    },
    onError: (Object error) {
      print(error);
    },
    onDone: () {
      print('All finished');
    },
  );
}

Future<void> errorHandlingUsingTryCatch() async {
  print('// errorHandlingUsingTryCatch');
  try {
    final file = File('assets/text_long.txt');
    final stream = file.openRead();
    await for (var data in stream) {
      print(data.length);
    }
  } on Exception catch (error) {
    print(error);
  } finally {
    print('All finished');
  }
}

void cancellingStreams() {
  print('// cancellingStreams');
  final file = File('assets/text_long.txt');
  final stream = file.openRead();
  StreamSubscription<List<int>>? subscription;
  subscription = stream.listen(
    (data) {
      print(data.length);
      subscription?.cancel();
    },
    cancelOnError: true,
    onDone: () {
      print('All finished');
    },
  );
}

void transformingStreams() {
  print('// transformingStreams');
  viewingBytes();
  decodingBytes();
}

// print as bytes
void viewingBytes() {
  print('// viewingBytes');
  final file = File('assets/text.txt');
  final stream = file.openRead();
  stream.listen(
    (data) {
      print(data);
    },
  );
}

// print as proper text
Future<void> decodingBytes() async {
  print('// decodingBytes');
  final file = File('assets/text.txt');
  final byteStream = file.openRead();
  final stringStream = byteStream.transform(utf8.decoder);
  await for (var data in stringStream) {
    print(data);
  }
}

void creatingStreamsFromScratch() {
  print('// creatingStreamsFromScratch');
  usingConstructors();
  reviewingSynchronousGenerators();
  usingAsynchronousGenerators();
  usingStreamControllers();
}

void usingConstructors() {
  print('// usingConstructors');
  final first = Future(() => 'Row');
  final second = Future(() => 'row');
  final third = Future(() => 'row');
  final fourth = Future.delayed(
    Duration(milliseconds: 300),
    () => 'your boat',
  );

  final stream = Stream<String>.fromFutures([
    first,
    second,
    third,
    fourth,
  ]);

  stream.listen((data) {
    print(data);
  });
}

void reviewingSynchronousGenerators() {
  print('// reviewingSynchronousGenerators');
  final squares = hundredSquares();
  for (final square in squares) {
    print(square);
  }
}

Iterable<int> hundredSquares() sync* {
  print('// hundredSquares');
  for (int i = 1; i <= 10; i++) {
    yield i * i;
  }
}

void usingAsynchronousGenerators() {
  print('// usingAsynchronousGenerators');
  final stream = consciousness();
  stream.listen((data) {
    print(data);
  });
}

// async* function returns a Stream
Stream<String> consciousness() async* {
  print('// consciousness');
  final data = ['con', 'scious', 'ness'];
  for (final part in data) {
    await Future<void>.delayed(Duration(milliseconds: 500));
    yield part;
  }
}

void usingStreamControllers() {
  print('// usingStreamControllers');
  final controller = StreamController<String>();
  final stream = controller.stream;
  final sink = controller.sink;

  stream.listen(
    (value) => print(value),
    onError: (Object error) => print(error),
    onDone: () => print('Sink closed'),
  );

  sink.add('grape');
  sink.add('grape');
  sink.add('grape');
  sink.addError(Exception('cherry'));
  sink.add('grape');
  sink.close();
}
