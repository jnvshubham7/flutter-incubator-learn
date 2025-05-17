// Main entry point for the library
library custom_datetime;

import 'dart:io' show Platform;

/// Custom DateTime implementation supporting microseconds precision
///
/// This class provides platform-specific implementations that extend the
/// standard [DateTime] class to work with microsecond precision on various platforms.
class MicroDateTime {
  // Export the appropriate implementation based on the platform
  static DateTime now() {
    // Use conditional compilation to determine the platform
    if (identical(0, 0.0)) {
      // Web platform (JavaScript)
      return WebMicroDateTime.now();
    } else {
      // Native platforms
      return NativeMicroDateTime.now();
    }
  }

  /// Formats the given DateTime with microsecond precision
  static String formatWithMicroseconds(DateTime dateTime) {
    final microseconds = dateTime is NativeMicroDateTime
        ? dateTime.microsecond
        : dateTime.microsecondsSinceEpoch % 1000;
    
    String formattedDate = 
        '${dateTime.year}-'
        '${_pad(dateTime.month)}-'
        '${_pad(dateTime.day)} '
        '${_pad(dateTime.hour)}:'
        '${_pad(dateTime.minute)}:'
        '${_pad(dateTime.second)}.'
        '${_padMicro(microseconds)}';
    
    return formattedDate;
  }
  
  /// Adds leading zeros to a number to ensure it's 2 digits
  static String _pad(int n) => n.toString().padLeft(2, '0');
  
  /// Adds leading zeros to a microsecond to ensure it's 6 digits
  static String _padMicro(int n) => n.toString().padLeft(6, '0');
}

/// Native implementation of MicroDateTime
class NativeMicroDateTime extends DateTime {
  const NativeMicroDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int microsecond = 0,
  ]) : super(year, month, day, hour, minute, second, 0);

  /// Current timestamp with microsecond precision on native platforms
  static NativeMicroDateTime now() {
    final now = DateTime.now();
    
    // Get the microseconds from the platform
    // This is a simplified example - actual implementation would depend on the native platform
    final int microsecond = now.microsecondsSinceEpoch % 1000000;
    
    return NativeMicroDateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute, 
      now.second,
      microsecond,
    );
  }
  
  /// The microsecond part (0-999999) of this DateTime
  int get microsecond => microsecondsSinceEpoch % 1000000;
}

/// Web implementation of MicroDateTime
class WebMicroDateTime extends DateTime {
  const WebMicroDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0, 
    int minute = 0, 
    int second = 0,
    int microsecond = 0,
  ]) : super(year, month, day, hour, minute, second, 0);

  /// Current timestamp with microsecond precision on web platform
  static WebMicroDateTime now() {
    final now = DateTime.now();
    
    // Web platform has less precision, we approximate microseconds
    // by getting the milliseconds and multiplying by 1000
    final int microsecond = (now.millisecond * 1000) + 
        (now.microsecondsSinceEpoch % 1000);
    
    return WebMicroDateTime(
      now.year, 
      now.month, 
      now.day, 
      now.hour, 
      now.minute, 
      now.second,
      microsecond,
    );
  }
}

void main() {
  final microTime = MicroDateTime.now();
  
  print('Current time with microseconds: ${MicroDateTime.formatWithMicroseconds(microTime)}');
  
  final platformInfo = identical(0, 0.0) ? 'Web (JS)' : 'Native';
  print('Running on platform: $platformInfo');
}
