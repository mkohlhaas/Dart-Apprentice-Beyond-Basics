// ignore_for_file: unused_local_variable, unnecessary_type_check

void main() {
  assigningFunctionsToVariables();
  passingFunctionsToFunctions();
  returningFunctionsFromFunctions();
  iteratingOverAList();
  iteratingOverAMap();
  mapping();
  filtering();
  reducing();
  folding();
  sorting();
  combiningHigherOrderMethods();
  voidCallback();
  valueSetterCallback();
  valueGetterCallback();
  tearOffs();
  typedefs();
  closures();
}

void assigningFunctionsToVariables() {
  int number = 4;
  String greeting = 'hello';
  bool isHungry = true;

  // ignore: prefer_function_declarations_over_variables
  Function multiply = (int a, int b) {
    return a * b;
  };
}

void passingFunctionsToFunctions() {
  // ignore: unused_element
  void namedFunction(Function anonymousFunction) {
    // function body
  }
}

void returningFunctionsFromFunctions() {
  // ignore: unused_element
  Function namedFunction() {
    return () => print('hello');
  }
}

void iteratingOverAList() {
  print('// iteratingOverAList');

  const numbers = [1, 2, 3];

  // ignore: avoid_function_literals_in_foreach_calls
  numbers.forEach((int number) {
    print(3 * number);
  });

  // ignore: avoid_function_literals_in_foreach_calls
  numbers.forEach((number) {
    print(3 * number);
  });

  // ignore: avoid_function_literals_in_foreach_calls
  numbers.forEach((number) => print(3 * number));

  for (final number in numbers) {
    print(3 * number);
  }

  // ignore: prefer_function_declarations_over_variables
  final triple = (int x) => print(3 * x);
  numbers.forEach(triple);
}

void iteratingOverAMap() {
  print('\n// iteratingOverAMap');

  final flowerColor = {
    'roses': 'red',
    'violets': 'blue',
  };

  flowerColor.forEach((flower, color) {
    print('$flower are $color');
  });

  print('i \u2764 Dart');
  print('and so do you');
}

void mapping() {
  print('\n// mapping');

  const numbers = [2, 4, 6, 8, 10, 12];

  final looped = <int>[];
  for (final x in numbers) {
    looped.add(x * x);
  }
  print(looped);

  final mapped = numbers.map((x) => x * x);
  print(mapped);
  print(mapped.toList());
}

void filtering() {
  print('\n// filtering');

  final myList = [1, 2, 3, 4, 5, 6];
  final odds = myList.where((element) => element.isOdd);
  print(odds);
}

void reducing() {
  print('\n// reducing');

  const evens = [2, 4, 6, 8, 10, 12];
  final total = evens.reduce((sum, element) => sum + element);
  print(total);

  // final emptyList = <int>[];
  // final result = emptyList.reduce((sum, x) => sum + x); //run-time error
}

void folding() {
  print('\n// folding');

  const evens = [2, 4, 6, 8, 10, 12];
  final total = evens.fold(
    0,
    (sum, element) => sum + element,
  );
  print(total);

  final emptyList = <int>[];
  final result = emptyList.fold(0, (sum, element) => sum + element);
  print(result);
}

void sorting() {
  print('\n// sorting');

  final desserts = ['cookies', 'pie', 'donuts', 'brownies'];
  print(desserts);

  desserts.sort();
  print(desserts);

  desserts.sort((d1, d2) => d1.length.compareTo(d2.length));
  print(desserts);
}

void combiningHigherOrderMethods() {
  print('\n// combiningHigherOrderMethods');

  declarative();
  imperative();
}

void declarative() {
  print('\n// declarative');

  const desserts = ['cake', 'pie', 'donuts', 'brownies'];
  final bigTallDesserts = desserts
      .where((dessert) => dessert.length > 5)
      .map((dessert) => dessert.toUpperCase())
      .toList();
  print(bigTallDesserts);
}

void imperative() {
  print('\n// imperative');

  const desserts = ['cake', 'pie', 'donuts', 'brownies'];
  final bigTallDesserts = <String>[];
  for (final item in desserts) {
    if (item.length > 5) {
      final upperCase = item.toUpperCase();
      bigTallDesserts.add(upperCase);
    }
  }
  print(bigTallDesserts);
}

class Button {
  Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  // final Function onPressed;
  final void Function() onPressed;
}

void voidCallback() {
  print('\n// voidCallback');

  final myButton = Button(
    title: 'Click me!',
    onPressed: () {
      print('Clicked');
    },
  );
  myButton.onPressed();
  myButton.onPressed.call();

  // final anotherButton = Button(
  //   title: 'Click me, too!',
  //   onPressed: (int apple) {
  //     print('Clicked');
  //     return 42;
  //   },
  // );
}

class MyWidget {
  MyWidget({
    required this.onTouch,
  });

  final void Function(double xPosition) onTouch;
}

void valueSetterCallback() {
  print('\n// valueSetterCallback');

  final myWidget = MyWidget(
    onTouch: (x) => print(x),
  );
  myWidget.onTouch(3.14);
}

class AnotherWidget {
  AnotherWidget({
    this.timeStamp,
  });

  final String Function()? timeStamp;
}

void valueGetterCallback() {
  print('\n// valueGetterCallback');

  final myWidget = AnotherWidget(
    timeStamp: () => DateTime.now().toIso8601String(),
  );

  final timeStamp = myWidget.timeStamp?.call();
  print(timeStamp);
}

class StateManager {
  // ignore: unused_field
  int _counter = 0;

  void handleButtonClick() {
    _counter++;
  }
}

void tearOffs() {
  print('\n// tearOffs');

  final manager = StateManager();

  final myButton = Button(
    title: 'Click me!',
    onPressed: manager.handleButtonClick,
  );
  myButton.onPressed();

  const cities = ['Istanbul', 'Ankara', 'Izmir', 'Bursa', 'Antalya'];
  // ignore: avoid_function_literals_in_foreach_calls
  cities.forEach((city) => print(city));
  print('');
  cities.forEach(print);
}

typedef MapBuilder = Map<String, int> Function(List<int>);
typedef ZipCode = int;

class Gizmo {
  Gizmo({
    required this.builder,
  });

  final MapBuilder builder;
}

void typedefs() {
  print('\n// typedefs');

  final gizmo = Gizmo(builder: (list) => {'hi': list.first});

  ZipCode code = 87101;
  int number = 42;

  // run-time type checks
  print(code is ZipCode);
  print(code is int);
  print('');
  print(number is ZipCode);
  print(number is int);
}

void closures() {
  print('\n// closures');

  var counter = 0;
  incrementCounter() {
    counter += 1;
  }

  incrementCounter();
  incrementCounter();
  incrementCounter();
  incrementCounter();
  incrementCounter();
  print(counter);

  Function countingFunction() {
    var counter = 0;
    incrementCounter() {
      counter += 1;
      return counter;
    }

    return incrementCounter;
  }

  final counter1 = countingFunction();
  final counter2 = countingFunction();
  print(counter1());
  print(counter1());
  print(counter1());
  print(counter2());
  print(counter2());
}
