// Dart Async Programming Examples
// This file demonstrates async concepts in Dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

// ======= FUTURES =======
// Futures represent a potential value or error that will be available at some time in the future

// Basic Future usage
Future<String> fetchUserData() {
  // Simulate network request with a delayed Future
  return Future.delayed(
    Duration(seconds: 2),
    () => '{"id": 1, "name": "John Doe", "email": "john@example.com"}',
  );
}

void futuresBasics() async {
  print('===== FUTURES BASICS =====');
  print('Fetching user data...');
  
  // Method 1: Using callbacks
  fetchUserData().then((data) {
    print('User data (using then): $data');
  }).catchError((error) {
    print('Error: $error');
  }).whenComplete(() {
    print('Future completed (using callbacks)');
  });
  
  // Method 2: Using async/await
  try {
    final data = await fetchUserData();
    print('User data (using await): $data');
  } catch (error) {
    print('Error: $error');
  } finally {
    print('Future completed (using async/await)');
  }
}

// Chaining Futures
Future<Map<String, dynamic>> getUserProfile() async {
  // Get raw data
  final jsonString = await fetchUserData();
  
  // Parse JSON
  final userData = jsonDecode(jsonString) as Map<String, dynamic>;
  
  // Simulate fetching additional data
  await Future.delayed(Duration(seconds: 1));
  
  // Add more profile information
  userData['premium'] = true;
  userData['lastActive'] = DateTime.now().toIso8601String();
  
  return userData;
}

void futuresChaining() async {
  print('\n===== FUTURES CHAINING =====');
  print('Getting user profile...');
  
  final profile = await getUserProfile();
  print('User profile: $profile');
}

// Parallel Futures
Future<void> parallelFutures() async {
  print('\n===== PARALLEL FUTURES =====');
  
  // Run multiple futures in parallel with Future.wait
  final results = await Future.wait([
    fetchData(1, 2),
    fetchData(2, 1),
    fetchData(3, 3),
  ]);
  
  print('All results: $results');
}

Future<String> fetchData(int id, int delay) async {
  await Future.delayed(Duration(seconds: delay));
  return 'Data $id after $delay seconds';
}

// Future API examples
void futureApiExamples() async {
  print('\n===== FUTURE API EXAMPLES =====');
  
  // Future.value - creates a future that completes with a value immediately
  final immediate = Future.value('Immediate value');
  print('Future.value: ${await immediate}');
  
  // Future.error - creates a future that completes with an error
  Future.error('Simulated error').catchError((e) => print('Future.error caught: $e'));
  
  // Future.sync - runs synchronously if possible
  final sync = Future.sync(() => 'Sync calculation');
  print('Future.sync: ${await sync}');
  
  // Future.microtask - schedules a microtask
  Future.microtask(() => print('Running in microtask'));
  
  // Future.any - completes when any future completes
  final any = await Future.any([
    Future.delayed(Duration(seconds: 2), () => 'Slow'),
    Future.delayed(Duration(seconds: 1), () => 'Fast'),
  ]);
  print('Future.any result: $any');
  
  // Future.timeout - adds a timeout to a future
  try {
    await Future.delayed(Duration(seconds: 3), () => 'Delayed')
        .timeout(Duration(seconds: 1));
  } catch (e) {
    print('Future.timeout exception: $e');
  }
}

// ======= STREAMS =======
// Streams provide a sequence of asynchronous events

// Basic Stream usage
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}

void streamsBasics() async {
  print('\n===== STREAMS BASICS =====');
  
  // Using a Stream with await for
  print('Counting with await for:');
  Stream<int> stream = countStream(5);
  await for (final count in stream) {
    print('Count: $count');
  }
  
  // Using Stream with callbacks
  print('\nCounting with listen:');
  countStream(3).listen(
    (data) => print('Received: $data'),
    onError: (e) => print('Error: $e'),
    onDone: () => print('Stream completed'),
  );
}

// StreamController example
void streamControllerExample() {
  print('\n===== STREAM CONTROLLER =====');
  
  // Create a StreamController
  final controller = StreamController<String>();
  
  // Listen to the stream
  final subscription = controller.stream.listen(
    (data) => print('Received: $data'),
    onError: (e) => print('Error: $e'),
    onDone: () => print('Stream closed'),
  );
  
  // Add data to the stream
  controller.sink.add('Hello');
  controller.sink.add('World');
  
  // Add error to the stream
  controller.sink.addError('Something went wrong');
  
  // More data
  controller.sink.add('Still working');
  
  // Schedule clean up
  Future.delayed(Duration(seconds: 1), () {
    controller.sink.add('Goodbye');
    subscription.cancel();
    controller.close();
  });
}

// Stream transformations
void streamTransformations() async {
  print('\n===== STREAM TRANSFORMATIONS =====');
  
  final numberStream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  
  // map - transforms each event
  print('Map:');
  await numberStream
      .map((x) => x * 2)
      .listen((data) => print('  $data'))
      .asFuture();
  
  // where - filters events
  print('Where:');
  await Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .where((x) => x % 2 == 0)
      .listen((data) => print('  $data'))
      .asFuture();
  
  // take - limits the number of events
  print('Take:');
  await Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .take(3)
      .listen((data) => print('  $data'))
      .asFuture();
  
  // skip - skips a number of events
  print('Skip:');
  await Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .skip(7)
      .listen((data) => print('  $data'))
      .asFuture();
  
  // distinct - removes consecutive duplicates
  print('Distinct:');
  await Stream.fromIterable([1, 1, 2, 2, 2, 3, 3, 1, 1, 4])
      .distinct()
      .listen((data) => print('  $data'))
      .asFuture();
}

// Stream API examples
void streamApiExamples() async {
  print('\n===== STREAM API EXAMPLES =====');
  
  // Stream.value - creates a single-value stream
  print('Stream.value:');
  await Stream.value('Single value')
      .listen((data) => print('  $data'))
      .asFuture();
  
  // Stream.fromIterable - creates a stream from an iterable
  print('Stream.fromIterable:');
  await Stream.fromIterable(['one', 'two', 'three'])
      .listen((data) => print('  $data'))
      .asFuture();
  
  // Stream.fromFuture - creates a stream from a future
  print('Stream.fromFuture:');
  await Stream.fromFuture(Future.delayed(
          Duration(milliseconds: 500), () => 'Future completed'))
      .listen((data) => print('  $data'))
      .asFuture();
  
  // Stream.periodic - creates a stream that emits events periodically
  print('Stream.periodic (first 3 events):');
  final subscription = Stream.periodic(Duration(milliseconds: 300), (i) => i)
      .take(3)
      .listen((data) => print('  Event: $data'));
  
  await subscription.asFuture();
}

// ======= ISOLATES =======
// Isolates are independent workers that don't share memory but can pass messages

// Basic Isolate example
void isolateBasics() async {
  print('\n===== ISOLATES BASICS =====');
  
  // Create a ReceivePort to receive messages from the isolate
  final receivePort = ReceivePort();
  
  // Spawn an isolate and pass the send port
  final isolate = await Isolate.spawn(
    isolateFunction,
    receivePort.sendPort,
  );
  
  // Listen for messages from the isolate
  receivePort.listen((message) {
    print('Received from isolate: $message');
    
    if (message == 'done') {
      // Close the port and kill the isolate
      receivePort.close();
      isolate.kill();
    }
  });
}

// Function to run in isolate
void isolateFunction(SendPort sendPort) {
  print('Isolate started');
  
  // Send messages back to the main isolate
  sendPort.send('Hello from isolate');
  
  // Perform CPU-intensive work
  int sum = 0;
  for (int i = 0; i < 10000000; i++) {
    sum += i;
  }
  
  sendPort.send('Sum: $sum');
  sendPort.send('done');
}

// Compute-intensive task example
Future<List<int>> computePrimes(int n) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(
    _calculatePrimes,
    [receivePort.sendPort, n],
  );
  
  // Get the result from the isolate
  final result = await receivePort.first as List<int>;
  receivePort.close();
  
  return result;
}

void _calculatePrimes(List<dynamic> params) {
  final SendPort sendPort = params[0];
  final int n = params[1];
  
  final primes = <int>[];
  
  // Simple prime number calculation
  for (int i = 2; i <= n; i++) {
    bool isPrime = true;
    for (int j = 2; j * j <= i; j++) {
      if (i % j == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      primes.add(i);
    }
  }
  
  // Send the result back and exit the isolate
  Isolate.exit(sendPort, primes);
}

void isolateCompute() async {
  print('\n===== ISOLATE COMPUTE EXAMPLE =====');
  
  print('Calculating primes up to 10000...');
  final startTime = DateTime.now();
  
  final primes = await computePrimes(10000);
  
  final duration = DateTime.now().difference(startTime);
  print('Found ${primes.length} prime numbers');
  print('First 10 primes: ${primes.take(10).toList()}');
  print('Last 10 primes: ${primes.skip(primes.length - 10).toList()}');
  print('Calculation took ${duration.inMilliseconds} ms');
}

// ======= ASYNC PATTERNS =======

// Timeout pattern
Future<String> fetchWithTimeout(Duration timeout) async {
  try {
    return await Future.delayed(Duration(seconds: 3), () => 'Data fetched')
        .timeout(timeout);
  } on TimeoutException {
    return 'Fetch timed out';
  }
}

// Retry pattern
Future<T> retry<T>(Future<T> Function() fn, {
  int maxRetries = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  int attempts = 0;
  
  while (true) {
    try {
      attempts++;
      return await fn();
    } catch (e) {
      if (attempts >= maxRetries) {
        rethrow;
      }
      
      print('Attempt $attempts failed, retrying in ${delay.inSeconds}s...');
      await Future.delayed(delay);
      
      // Optional: exponential backoff
      delay = delay * 2;
    }
  }
}

// Debounce function for Stream
StreamTransformer<T, T> debounce<T>(Duration duration) {
  return StreamTransformer<T, T>.fromHandlers(
    handleData: (T data, EventSink<T> sink) {
      Timer? timer;
      timer?.cancel();
      timer = Timer(duration, () => sink.add(data));
    },
  );
}

// Async patterns demonstration
void asyncPatterns() async {
  print('\n===== ASYNC PATTERNS =====');
  
  // Timeout pattern
  print('Timeout pattern:');
  final result1 = await fetchWithTimeout(Duration(seconds: 1));
  print('Result with 1s timeout: $result1');
  
  final result2 = await fetchWithTimeout(Duration(seconds: 5));
  print('Result with 5s timeout: $result2');
  
  // Retry pattern
  print('\nRetry pattern:');
  int counter = 0;
  
  try {
    final result = await retry(() async {
      counter++;
      if (counter < 3) {
        throw Exception('Simulated failure');
      }
      return 'Success on attempt $counter';
    }, maxRetries: 5, delay: Duration(milliseconds: 200));
    
    print('Final result: $result');
  } catch (e) {
    print('Failed after multiple retries: $e');
  }
}

// ======= MAIN FUNCTION =======
void main() async {
  print('DART ASYNC PROGRAMMING EXAMPLES\n');
  
  // Futures examples
  await futuresBasics();
  await futuresChaining();
  await parallelFutures();
  await futureApiExamples();
  
  // Streams examples
  await streamsBasics();
  streamControllerExample();
  await Future.delayed(Duration(seconds: 2)); // Wait for streamController to complete
  await streamTransformations();
  await streamApiExamples();
  
  // Isolates examples
  await isolateBasics();
  await Future.delayed(Duration(seconds: 1)); // Wait for isolate to complete
  await isolateCompute();
  
  // Async patterns
  await asyncPatterns();
  
  print('\nAll examples completed!');
}
