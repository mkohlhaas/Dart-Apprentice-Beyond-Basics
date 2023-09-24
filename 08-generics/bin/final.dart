// ignore_for_file: unused_local_variable

void main() {
  usingGenerics();
  creatingGenericClasses();
  creatingGenericFunctions();
  genericsOfSpecifiedSubtypes();
}

void usingGenerics() {
  print('// usingGenerics');

  List<Object> snacks = ['chips', 'nuts', 42];

  List<int> integerList = [3, 1, 4];
  List<double> doubleList = [3.14, 8.0, 0.001];
  List<bool> booleanList = [true, false, false];

  Set<int> integerSet = {3, 1, 4};
  Map<int, String> intToStringMap = {1: 'one', 2: 'two', 3: 'three'};
}

void creatingGenericClasses() {
  print('\n// creatingGenericClasses');

  final intTree = createIntTree();
  final stringTree = createStringTree();
}

class Node<T> {
  Node(this.value);
  T value;

  Node<T>? left;
  Node<T>? right;

  // in-order traversal
  @override
  String toString() {
    final l = left?.toString() ?? '';
    final val = value.toString();
    final r = right?.toString() ?? '';
    return '$l $val $r';
  }
}

Node<int> createIntTree() {
  final zero = Node(0);
  final one = Node(1);
  final five = Node(5);
  final seven = Node(7);
  final eight = Node(8);
  final nine = Node(9);

  seven.left = one;
  seven.right = nine;
  one.left = zero;
  one.right = five;
  nine.left = eight;

  return seven;
}

Node<String> createStringTree() {
  final zero = Node('zero');
  final one = Node('one');
  final five = Node('five');
  final seven = Node('seven');
  final eight = Node('eight');
  final nine = Node('nine');

  seven.left = one;
  seven.right = nine;
  one.left = zero;
  one.right = five;
  nine.left = eight;

  return seven;
}

void creatingGenericFunctions() {
  print('\n// creatingGenericFunctions');

  final tree = createTree([7, 1, 9, 0, 5, 8]);
  // final tree = createTree(['seven', 'one', 'nine', 'zero', 'five', 'eight']);

  print(tree?.value);
  print(tree?.left?.value);
  print(tree?.right?.value);
  print(tree?.left?.left?.value);
  print(tree?.left?.right?.value);
  print(tree?.right?.left?.value);
  print(tree?.right?.right?.value);
}

Node<E>? createTree<E>(List<E> nodes, [int index = 0]) {
  if (index >= nodes.length) return null;

  final node = Node(nodes[index]);

  final leftChildIndex = 2 * index + 1;
  final rightChildIndex = 2 * index + 2;

  node.left = createTree(nodes, leftChildIndex);
  node.right = createTree(nodes, rightChildIndex);

  return node;
}

void genericsOfSpecifiedSubtypes() {
  print('\n// genericsOfSpecifiedSubtypes');

  var tree = BinarySearchTree<num>();
  tree.insert(7);
  tree.insert(1);
  tree.insert(9);
  tree.insert(0);
  tree.insert(5);
  tree.insert(8);
  print(tree);
}

class BinarySearchTree<E extends Comparable<E>> {
  Node<E>? root;

  void insert(E value) {
    root = _insertAt(root, value);
  }

  Node<E> _insertAt(Node<E>? node, E value) {
    if (node == null) {
      return Node(value);
    }

    if (value.compareTo(node.value) < 0) {
      node.left = _insertAt(node.left, value);
    } else {
      node.right = _insertAt(node.right, value);
    }

    return node;
  }

  @override
  String toString() => root.toString();
}
