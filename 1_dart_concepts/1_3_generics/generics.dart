// Dart Generics Examples
// This file demonstrates the concepts of generics in Dart

// ======= BASIC GENERICS =======

// Generic class
class Box<T> {
  T value;
  
  Box(this.value);
  
  T getValue() {
    return value;
  }
  
  void setValue(T newValue) {
    value = newValue;
  }
  
  @override
  String toString() {
    return 'Box<${T.toString()}>($value)';
  }
}

// Generic method
T findFirst<T>(List<T> list) {
  if (list.isEmpty) {
    throw StateError('List is empty');
  }
  return list.first;
}

// Generic function with multiple type parameters
Map<K, V> zipToMap<K, V>(List<K> keys, List<V> values) {
  if (keys.length != values.length) {
    throw ArgumentError('Lists must have the same length');
  }
  
  final Map<K, V> result = {};
  for (int i = 0; i < keys.length; i++) {
    result[keys[i]] = values[i];
  }
  
  return result;
}

void basicGenerics() {
  print('===== BASIC GENERICS =====');
  
  // Using generic classes
  final intBox = Box<int>(42);
  final stringBox = Box<String>('Hello');
  
  print('intBox: ${intBox}');
  print('stringBox: ${stringBox}');
  
  intBox.setValue(100);
  print('After setValue: ${intBox}');
  
  // Using generic methods
  final nums = [1, 2, 3, 4, 5];
  final first = findFirst<int>(nums);
  print('First from $nums: $first');
  
  // Using generic function with multiple type parameters
  final keys = ['name', 'age', 'city'];
  final values = ['John', 30, 'New York'];
  final personMap = zipToMap<String, dynamic>(keys, values);
  print('Zipped map: $personMap');
}

// ======= BOUNDED GENERICS =======

// Class with type constraint (bounded generics)
class NumericBox<T extends num> {
  T value;
  
  NumericBox(this.value);
  
  T getValue() {
    return value;
  }
  
  // Can perform numeric operations because T is guaranteed to be a number
  T squared() {
    return (value * value) as T;
  }
  
  bool isGreaterThan(NumericBox<T> other) {
    return value > other.value;
  }
  
  @override
  String toString() {
    return 'NumericBox<${T.toString()}>($value)';
  }
}

// Generic method with constraint
void printNumbers<T extends num>(List<T> numbers) {
  print('Numbers: $numbers');
  print('Sum: ${numbers.reduce((a, b) => (a + b) as T)}');
  print('Average: ${numbers.reduce((a, b) => (a + b) as T) / numbers.length}');
}

void boundedGenerics() {
  print('\n===== BOUNDED GENERICS =====');
  
  final intNumBox = NumericBox<int>(5);
  final doubleNumBox = NumericBox<double>(3.14);
  
  print('intNumBox: $intNumBox');
  print('intNumBox squared: ${intNumBox.squared()}');
  
  print('doubleNumBox: $doubleNumBox');
  print('doubleNumBox squared: ${doubleNumBox.squared()}');
  
  print('intNumBox > doubleNumBox? ${intNumBox.isGreaterThan(NumericBox<num>(doubleNumBox.value))}');
  
  // Using printNumbers with different numeric types
  printNumbers<int>([1, 2, 3, 4, 5]);
  printNumbers<double>([1.1, 2.2, 3.3, 4.4, 5.5]);
}

// ======= GENERIC COLLECTIONS =======

// Custom generic collection
class Queue<E> {
  final List<E> _items = [];
  
  void enqueue(E item) {
    _items.add(item);
  }
  
  E? dequeue() {
    if (_items.isEmpty) {
      return null;
    }
    return _items.removeAt(0);
  }
  
  E? peek() {
    if (_items.isEmpty) {
      return null;
    }
    return _items.first;
  }
  
  bool get isEmpty => _items.isEmpty;
  
  @override
  String toString() {
    return 'Queue($_items)';
  }
}

// Generic collection with multiple type parameters
class Pair<F, S> {
  final F first;
  final S second;
  
  Pair(this.first, this.second);
  
  @override
  String toString() {
    return 'Pair($first, $second)';
  }
}

void genericCollections() {
  print('\n===== GENERIC COLLECTIONS =====');
  
  // Built-in generic collections
  print('Built-in collections:');
  final List<int> numbers = [1, 2, 3];
  final Set<String> uniqueNames = {'Alice', 'Bob', 'Charlie'};
  final Map<String, int> ages = {
    'Alice': 30,
    'Bob': 25,
    'Charlie': 35,
  };
  
  print('List<int>: $numbers');
  print('Set<String>: $uniqueNames');
  print('Map<String, int>: $ages');
  
  // Custom generic queue
  print('\nCustom Queue<T>:');
  final stringQueue = Queue<String>();
  stringQueue.enqueue('First');
  stringQueue.enqueue('Second');
  stringQueue.enqueue('Third');
  
  print('Queue: $stringQueue');
  print('Dequeue: ${stringQueue.dequeue()}');
  print('Queue after dequeue: $stringQueue');
  print('Peek: ${stringQueue.peek()}');
  
  // Using Pair class
  print('\nPair<F, S>:');
  final namePair = Pair<String, String>('First Name', 'Last Name');
  final coordinatePair = Pair<double, double>(37.7749, -122.4194);
  final mixedPair = Pair<String, int>('Age', 30);
  
  print('String pair: $namePair');
  print('Coordinate pair: $coordinatePair');
  print('Mixed pair: $mixedPair');
}

// ======= ADVANCED GENERICS =======

// Generic with factory constructor
abstract class JsonSerializable<T> {
  Map<String, dynamic> toJson();
  
  factory JsonSerializable(T value) {
    if (value is int) {
      return NumberSerializer(value) as JsonSerializable<T>;
    } else if (value is String) {
      return StringSerializer(value) as JsonSerializable<T>;
    } else {
      throw UnsupportedError('Type ${value.runtimeType} not supported');
    }
  }
}

class NumberSerializer implements JsonSerializable<int> {
  final int value;
  
  NumberSerializer(this.value);
  
  @override
  Map<String, dynamic> toJson() {
    return {'type': 'number', 'value': value};
  }
}

class StringSerializer implements JsonSerializable<String> {
  final String value;
  
  StringSerializer(this.value);
  
  @override
  Map<String, dynamic> toJson() {
    return {'type': 'string', 'value': value};
  }
}

// Generic mixin
mixin Loggable<T> {
  void log(T value) {
    print('[LOG] ${T.toString()}: $value');
  }
}

class Logger<T> with Loggable<T> {
  List<T> history = [];
  
  void record(T value) {
    log(value);
    history.add(value);
  }
}

// Generic extension
extension FilterExtension<T> on List<T> {
  List<T> whereNotNull() {
    return this.where((element) => element != null).toList();
  }
  
  List<R> mapIndexed<R>(R Function(int index, T item) transform) {
    List<R> result = [];
    for (int i = 0; i < this.length; i++) {
      result.add(transform(i, this[i]));
    }
    return result;
  }
}

// Type checking with generics
bool isExactlyType<T, S>() => T == S;

void advancedGenerics() {
  print('\n===== ADVANCED GENERICS =====');
  
  // Using factory generic constructor
  final numberSerializer = JsonSerializable<int>(42);
  final stringSerializer = JsonSerializable<String>('Hello');
  
  print('Number serialized: ${numberSerializer.toJson()}');
  print('String serialized: ${stringSerializer.toJson()}');
  
  // Using generic mixin
  final numberLogger = Logger<int>();
  final stringLogger = Logger<String>();
  
  numberLogger.record(42);
  numberLogger.record(99);
  stringLogger.record('Hello');
  
  print('Number log history: ${numberLogger.history}');
  print('String log history: ${stringLogger.history}');
  
  // Using generic extensions
  final List<String?> names = ['Alice', null, 'Bob', null, 'Charlie'];
  final nonNullNames = names.whereNotNull();
  print('Non-null names: $nonNullNames');
  
  final indexedItems = ['Apple', 'Banana', 'Cherry'].mapIndexed(
      (index, item) => '[$index] $item');
  print('Indexed items: $indexedItems');
  
  // Type checking
  print('Is List<int> exactly List<num>? ${isExactlyType<List<int>, List<num>>()}');
  print('Is List<int> exactly List<int>? ${isExactlyType<List<int>, List<int>>()}');
}

// ======= PRACTICAL EXAMPLES =======

// Generic Repository Pattern
abstract class Repository<T, ID> {
  Future<T?> findById(ID id);
  Future<List<T>> findAll();
  Future<T> save(T entity);
  Future<void> delete(ID id);
}

class User {
  final int id;
  final String name;
  final String email;
  
  User(this.id, this.name, this.email);
  
  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

class InMemoryUserRepository implements Repository<User, int> {
  final Map<int, User> _storage = {};
  
  @override
  Future<User?> findById(int id) async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate delay
    return _storage[id];
  }
  
  @override
  Future<List<User>> findAll() async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate delay
    return _storage.values.toList();
  }
  
  @override
  Future<User> save(User entity) async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate delay
    _storage[entity.id] = entity;
    return entity;
  }
  
  @override
  Future<void> delete(int id) async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate delay
    _storage.remove(id);
  }
}

// Generic State Container
class StateContainer<T> {
  T _state;
  List<Function(T)> _listeners = [];
  
  StateContainer(this._state);
  
  T get state => _state;
  
  void setState(T newState) {
    _state = newState;
    _notifyListeners();
  }
  
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener(_state);
    }
  }
  
  void addListener(Function(T) listener) {
    _listeners.add(listener);
  }
  
  void removeListener(Function(T) listener) {
    _listeners.remove(listener);
  }
}

void practicalExamples() async {
  print('\n===== PRACTICAL EXAMPLES =====');
  
  // Repository pattern example
  print('Repository pattern example:');
  final userRepo = InMemoryUserRepository();
  
  // Add some users
  await userRepo.save(User(1, 'Alice', 'alice@example.com'));
  await userRepo.save(User(2, 'Bob', 'bob@example.com'));
  
  // Find users
  final user1 = await userRepo.findById(1);
  print('Found user: $user1');
  
  final allUsers = await userRepo.findAll();
  print('All users: $allUsers');
  
  // Delete a user
  await userRepo.delete(1);
  final usersAfterDelete = await userRepo.findAll();
  print('Users after delete: $usersAfterDelete');
  
  // State container example
  print('\nState container example:');
  final counter = StateContainer<int>(0);
  
  // Add listener
  counter.addListener((count) {
    print('Counter changed to: $count');
  });
  
  // Update state
  counter.setState(1);
  counter.setState(2);
  counter.setState(3);
  
  // String state container
  final textState = StateContainer<String>('');
  textState.addListener((text) {
    print('Text changed to: "$text"');
  });
  
  textState.setState('Hello');
  textState.setState('Hello World');
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART GENERICS EXAMPLES\n');
  
  basicGenerics();
  boundedGenerics();
  genericCollections();
  advancedGenerics();
  practicalExamples();
  
  print('\nAll examples completed!');
}
