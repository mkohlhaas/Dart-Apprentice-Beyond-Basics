void main() {
  reviewingBasics();
  addingConstructorsAndProperties();
  operatorOverloading();
  addingMethods();
  implementingInterfaces();
  addingMixins();
  usingGenerics();
}

// Dart enums are subclasses of Enum.
enum TrafficLight {
  green('Go!'),
  yellow('Slow down!'),
  red('Stop!'); // trailing semicolon

  const TrafficLight(this.message); // Enums must have const constructors.
  final String message;
}

void reviewingBasics() {
  print('// reviewingBasics');

  // old-fashioned way
  const int green = 0;
  const int yellow = 1;
  const int red = 2;

  void printMessage(int lightColor) {
    switch (lightColor) {
      case green:
        print('Go!');
        break;
      case yellow:
        print('Slow down!');
        break;
      case red:
        print('Stop!');
        break;
      default:
        print('Unrecognized option');
    }
  }

  printMessage(green);

  // still too complicated way
  final color = TrafficLight.green;
  switch (color) {
    case TrafficLight.green:
      print('Go!');
      break;
    case TrafficLight.yellow:
      print('Slow down!');
      break;
    case TrafficLight.red:
      print('Stop!');
      break;
  }
}

void addingConstructorsAndProperties() {
  print('\n// addingConstructorsAndProperties');

  final color = TrafficLight.green;
  print(color.message);
}

class Point {
  const Point(this.x, this.y);
  final double x;
  final double y;

  // operator overloading
  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  @override
  String toString() => 'Point($x, $y)';
}

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  Day operator +(int days) {
    final numberOfDays = Day.values.length;
    final index = (this.index + days) % numberOfDays;
    return Day.values[index];
  }

  Day get next {
    return this + 1;
  }
}

void operatorOverloading() {
  print('\n// operatorOverloading');

  print(3 + 2);
  // ignore: prefer_adjacent_string_concatenation
  print('a' + 'b');

  const pointA = Point(1, 4);
  const pointB = Point(3, 2);
  final pointC = pointA + pointB;
  print(pointC);

  var day = Day.monday;
  day = day + 2;
  print(day.name);
  day += 4;
  print(day.name);
  day++;
  print(day.name);
}

void addingMethods() {
  print('\n// addingMethods');

  final restDay = Day.saturday;
  print(restDay.next);
}

abstract class Serializable {
  String serialize();
}

enum Weather implements Serializable {
  sunny,
  cloudy,
  rainy;

  @override
  String serialize() => name;

  static Weather deserialize(String value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => Weather.sunny,
    );
  }
}

void implementingInterfaces() {
  print('\n// implementingInterfaces');

  final weather = Weather.cloudy;
  String serialized = weather.serialize();
  print(serialized);
  Weather deserialized = Weather.deserialize(serialized);
  print(deserialized);
}

enum Fruit with Describer {
  cherry,
  peach,
  banana,
}

enum Vegetable with Describer {
  carrot,
  broccoli,
  spinach,
}

mixin Describer on Enum {
  void describe() {
    print('This $runtimeType is a $name.');
  }
}

void addingMixins() {
  print('\n// addingMixins');

  final fruit = Fruit.banana;
  final vegi = Vegetable.broccoli;

  fruit.describe();
  vegi.describe();
}

enum Default<T extends Object> {
  font<String>('roboto'),
  size<double>(17.0),
  weight<int>(400);

  const Default(this.value);
  final T value;
}

// generics allow different types for the enum values
void usingGenerics() {
  print('\n// usingGenerics');

  String defaultFont = Default.font.value;
  double defaultSize = Default.size.value;
  int defaultWeight = Default.weight.value;
  print(defaultFont);
  print(defaultSize);
  print(defaultWeight);
}

enum Size {
  small(1),
  medium(5),
  large(10);

  const Size(this.value);
  final int value;
}
