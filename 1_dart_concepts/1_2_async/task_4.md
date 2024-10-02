void main() {
  // Write a program calculating a sum of all prime numbers from 1 to N using
  // [Isolate]s to speed up the algorithm.
}


Here is a simple Dart program that calculates the sum of all prime numbers up to a given number `N`. The program uses isolate to speed up the algorithm by distributing the calculation of prime numbers over multiple isolates.

```dart
import 'dart:io';
import 'dart:isolate';
import 'dart:async';

const maxPrimeNumber = 100000;  // Max number of primes to calculate
const smallPrimeNumbers = (maxPrimeNumber + 7).bitLength;  // Calculate the number of bits

void main() async {
  int start = 2;
  SendPort primeSumPort = null;
  ReceivePort primeSumPortReceive = ReceivePort();

  await Isolate.spawn(
    _isolatePrimeSum,
    [start, primeSumPortReceive.sendPort, ReceiveStream.fromStream(primeSumPortReceive)],
  );

  ReceivePort primeNumbersPort = ReceivePort();

  await Isolate.spawn(
    _isolatePrimeNumbers,
    [maxPrimeNumber, primeNumbersPort.sendPort],
  );

  primeSumPort = await primeSumPortReceive.first;
  ReceivePort resultPort = ReceivePort();
  sendPortSend(primeSumPort, resultPort.sendPort);

  int result = await resultPort.first;

  print('Sum of all prime numbers: $result');
}

void _isolatePrimeNumbers(SendPort port, dynamic args) async {
  int max = args[0];
  SendPort primeNumbersPort = args[1];

  List<bool> sieve = List.filled(max + 1, true);
  sieve[0] = sieve[1] = false;

  for (int i = 2; i * i <= max; i++) {
    if (sieve[i]) {
      for (int j = i * i; j <= max; j += i) {
        sieve[j] = false;
      }
    }
  }

  List<int> primeNumbers = List<int>();
  for (int i = 2; i <= max; i++) {
    if (sieve[i]) {
      primeNumbers.add(i);
    }
  }

  port.send(primeNumbers);
}

void _isolatePrimeSum(SendPort port, dynamic args) async {
  int start = args[0];
  SendPort primeSumPort = args[1];
  Stream PRimes = Stream.fromFuture(args[2]);

  int sum = 0;
  await for (int prime in PRimes.skipWhile((x) => x < start)) {
    sum += prime;
  }

  primeSumPort.send(sum);
}
```

This program will calculate the sum of all prime numbers up to `maxPrimeNumber` and print the result. The calculation is distributed over multiple isolates: one isolate calculates the prime numbers and sends them over a SendPort to the main isolate; the main isolate then calculates the sum of the primes received from the isolate and sends the result back over another SendPort. This approach can significantly speed up the algorithm for large `maxPrimeNumber` values.