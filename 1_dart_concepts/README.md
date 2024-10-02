Step 1: Dart concepts
=====================

**Estimated time**: 1 day

These steps describe the basic [Dart] concepts you would need on an everyday basis, which require more attention and practice than the official resources might offer.

**Before completing this step, you should complete all its sub-steps.**




## Task

Write a simple in-memory key-value database with simulated delays (adding and getting values should be asynchronous). It should expose a [`Stream`] of its changes, and use [generics][1] for storing data.




[`Stream`]: https://api.dart.dev/stable/dart-async/Stream-class.html
[Dart]: https://dart.dev

[1]: https://dart.dev/language/generics


Here is the markdown file with questions and answers in code:
```
Step 1: Dart concepts
=====================

**Estimated time**: 1 day

These steps describe the basic [Dart] concepts you would need on an everyday basis, which require more attention and practice than the official resources might offer.

**Before completing this step, you should complete all its sub-steps.**


## Task
```dart
class InMemoryDatabase<K, V> {
  // Implement the methods below
  Future<void> addValue(K key, V value);

  Future<V?> getValue(K key);

  Stream<MapEntry<K, V>> get changes {
    // Implement the stream of changes
  }
}
```

**Questions and Answers**
```dart
// Question 1: How to make a method asynchronous?
// Answer: Use the `Future` class and define a `async` function
Future<void> addValue(K key, V value) async {
  // add value to in-memory database with simulated delay
  await Future.delayed(Duration(milliseconds: 500));
}

// Question 2: How to get a value from the database?
// Answer: Use a `Future` and the `async` keyword
Future<V?> getValue(K key) async {
  // get value from in-memory database with simulated delay
  await Future.delayed(Duration(milliseconds: 500));
  // return the value
}

// Question 3: How to create a stream of changes?
// Answer: Use the `Stream` class and the `async` keyword
Stream<MapEntry<K, V>> get changes {
  StreamController<MapEntry<K, V>> controller = StreamController();
  // add values to the controller with simulated delay
  addValue("key1", "value1");
  addValue("key2", "value2");
  // return the stream
  return controller.stream;
}
```

Note: This is just one possible implementation, and there are many ways to answer these questions. The goal is to get started with the concepts, not to write perfect code.