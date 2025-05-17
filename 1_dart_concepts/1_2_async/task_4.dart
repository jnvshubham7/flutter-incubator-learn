import 'dart:isolate';
import 'dart:math';
import 'dart:async';

/// A class to calculate prime numbers and their sum
class PrimeCalculator {
  /// Calculate the sum of prime numbers up to [max]
  static Future<int> calculatePrimeSum(int max) async {
    // Determine the number of isolates based on system information
    // For simplicity, we'll use a fixed number here
    final isolateCount = 4;
    
    // Calculate how many numbers each isolate should process
    final rangeSize = max ~/ isolateCount;
    
    // Create a list to store the futures for each isolate
    final List<Future<int>> isolateFutures = [];
    
    // Create isolates for each range
    for (int i = 0; i < isolateCount; i++) {
      final start = i * rangeSize + 1;
      final end = (i == isolateCount - 1) ? max : (i + 1) * rangeSize;
      
      isolateFutures.add(_sumPrimesInRange(start, end));
    }
    
    // Wait for all isolates to complete and sum their results
    final results = await Future.wait(isolateFutures);
    return results.reduce((sum, element) => sum + element);
  }
  
  /// Calculate the sum of prime numbers in the range [start, end] using an isolate
  static Future<int> _sumPrimesInRange(int start, int end) async {
    final receivePort = ReceivePort();
    
    // Create an isolate to calculate the sum of primes in the given range
    await Isolate.spawn(
      _isolatePrimeCalculation,
      [start, end, receivePort.sendPort]
    );
    
    // Wait for the result from the isolate
    return await receivePort.first as int;
  }
  
  /// Helper method to run inside an isolate for prime calculation
  static void _isolatePrimeCalculation(List<dynamic> args) {
    final int start = args[0] as int;
    final int end = args[1] as int;
    final SendPort sendPort = args[2] as SendPort;
    
    int sum = 0;
    
    // Find primes using the Sieve of Eratosthenes algorithm
    final sieve = _sieveOfEratosthenes(end);
    
    // Sum the primes in our range
    for (int i = max(start, 2); i <= end; i++) {
      if (sieve[i]) {
        sum += i;
      }
    }
    
    // Send the result back to the main isolate
    sendPort.send(sum);
  }
  
  /// Implementation of the Sieve of Eratosthenes algorithm
  static List<bool> _sieveOfEratosthenes(int max) {
    final sieve = List<bool>.filled(max + 1, true);
    sieve[0] = false;
    sieve[1] = false;
    
    for (int i = 2; i * i <= max; i++) {
      if (sieve[i]) {
        for (int j = i * i; j <= max; j += i) {
          sieve[j] = false;
        }
      }
    }
    
    return sieve;
  }
}

void main() async {
  const int max = 1000000;
  
  print('Calculating sum of primes up to $max...');
  
  final stopwatch = Stopwatch()..start();
  final sum = await PrimeCalculator.calculatePrimeSum(max);
  stopwatch.stop();
  
  print('The sum of all primes from 1 to $max is $sum');
  print('Calculation took ${stopwatch.elapsedMilliseconds} ms');
}
