void main() {
  // final animal = Animal();
  final platypus = Platypus();
  print(platypus.isAlive);
  platypus.eat();
  platypus.move();
  platypus.layEggs();
  print(platypus);
}

abstract class Animal {
  bool isAlive = true;
  void eat();
  void move();

  @override
  String toString() {
    return "I'm a $runtimeType"; // print type at run-time
  }
}

class Platypus extends Animal {
  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }

  void layEggs() {
    print('Plop plop');
  }
}
