abstract class Bird {
  void fly();
  void layEggs();
}

class Robin extends Bird with EggLayer, Flyer {}

abstract class Animal {
  bool isAlive = true;
  void eat();
  void move();

  @override
  String toString() {
    return "I'm a $runtimeType";
  }
}

class Platypus extends Animal with EggLayer {
  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }
}

mixin EggLayer {
  void layEggs() {
    print('Plop plop');
  }
}

mixin Flyer {
  void fly() {
    print('Swoosh swoosh');
  }
}

void main() {
  final platypus = Platypus();
  final robin = Robin();
  platypus.layEggs();
  robin.layEggs();
}
