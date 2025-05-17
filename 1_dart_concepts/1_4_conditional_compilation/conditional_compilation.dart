// Dart Conditional Compilation Examples
// This file demonstrates conditional compilation concepts in Dart

// ======= CONDITIONAL COMPILATION BASICS =======

// In Dart, conditional compilation is achieved primarily through the use of:
// 1. Conditional imports
// 2. Compiler constants (`dart.library.*`, `dart.io`, etc.)
// 3. Platform-specific code

import 'dart:io';

// Platform detection constants
void platformConstants() {
  print('===== PLATFORM DETECTION =====');
  
  // Check which platform we're running on using predefined constants
  // These are evaluated at compile time and allow for different code paths
  
  // Platform-specific code
  if (identical(1, 1.0)) {
    print('Running on the web (dart2js/DDC)');
  } else {
    print('Running on VM (JIT or AOT)');
  }
  
  // Using built-in constants
  print('\nBuilt-in constants:');
  
  // dart.library.* constants determine which libraries are available
  const bool hasIO = const bool.fromEnvironment('dart.library.io');
  const bool hasHTML = const bool.fromEnvironment('dart.library.html');
  const bool hasJS = const bool.fromEnvironment('dart.library.js');
  const bool hasFFI = const bool.fromEnvironment('dart.library.ffi');
  
  print('dart.library.io available: $hasIO');
  print('dart.library.html available: $hasHTML');
  print('dart.library.js available: $hasJS');
  print('dart.library.ffi available: $hasFFI');
  
  // Checking specific platforms
  try {
    if (Platform.isIOS) print('Running on iOS');
    if (Platform.isAndroid) print('Running on Android');
    if (Platform.isMacOS) print('Running on macOS');
    if (Platform.isWindows) print('Running on Windows');
    if (Platform.isLinux) print('Running on Linux');
    if (Platform.isFuchsia) print('Running on Fuchsia');
  } catch (e) {
    print('Platform detection not available (likely running on web)');
  }
}

// ======= ENVIRONMENT VARIABLES =======

// Environment variables can be used for configuration
void environmentVariables() {
  print('\n===== ENVIRONMENT VARIABLES =====');
  
  // Defined at compile time with --define=KEY=VALUE
  const String apiKey = String.fromEnvironment('API_KEY', defaultValue: 'default_key');
  const String apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://api.example.com');
  const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: false);
  const int maxConnections = int.fromEnvironment('MAX_CONNECTIONS', defaultValue: 10);
  
  print('API Key: $apiKey');
  print('API URL: $apiUrl');
  print('Debug Mode: $isDebug');
  print('Max Connections: $maxConnections');
  
  // Usage example based on environment variables
  if (isDebug) {
    print('Running in debug mode');
    print('Using extra logging and assertions');
  } else {
    print('Running in production mode');
  }
  
  // Combining environment variables
  final String fullApiUrl = '$apiUrl?key=$apiKey&connections=$maxConnections';
  print('Full API URL: $fullApiUrl');
}

// ======= ASSERTIONS =======

// Assertions are only enabled in debug/development mode
void assertionsExample() {
  print('\n===== ASSERTIONS =====');
  
  print('Assertions are active in development mode but ignored in production');
  
  try {
    int? nullableValue;
    assert(nullableValue != null, 'Value should not be null');
    print('No assertion error (either assertion is disabled or value is not null)');
  } catch (e) {
    print('Assertion error detected: $e');
  }
  
  // Example of a more complex assertion for development-only validation
  void validateUserData(Map<String, dynamic> userData) {
    assert(() {
      if (!userData.containsKey('name')) {
        print('WARNING: User data is missing name field');
        return false;
      }
      if (!userData.containsKey('email')) {
        print('WARNING: User data is missing email field');
        return false;
      }
      return true;
    }(), 'User data validation failed');
  }
  
  validateUserData({'name': 'John'});
}

// ======= CONDITIONAL IMPORTS =======

// Different implementations based on platform
// We'll demonstrate the concept, but this would normally be in separate files

/*
// file: data_source.dart
abstract class DataSource {
  Future<List<String>> getData();
}

// file: mobile_data_source.dart
import 'data_source.dart';
import 'dart:io';

class MobileDataSource implements DataSource {
  @override
  Future<List<String>> getData() async {
    // Mobile-specific implementation
    return ['Mobile data 1', 'Mobile data 2'];
  }
}

// file: web_data_source.dart
import 'data_source.dart';
import 'dart:html';

class WebDataSource implements DataSource {
  @override
  Future<List<String>> getData() async {
    // Web-specific implementation
    return ['Web data 1', 'Web data 2'];
  }
}

// file: data_source_provider.dart
import 'data_source.dart';

// On mobile:
// import 'mobile_data_source.dart' if (dart.library.html) 'web_data_source.dart';

// On web:
// import 'web_data_source.dart' if (dart.library.io) 'mobile_data_source.dart';

DataSource getDataSource() {
  if (kIsWeb) {
    return WebDataSource();
  } else {
    return MobileDataSource();
  }
}
*/

void conditionalImports() {
  print('\n===== CONDITIONAL IMPORTS =====');
  
  print('Conditional imports allow for different implementations based on platform');
  print('Typically used for platform-specific code while maintaining a common interface');
  
  print('\nExample pattern:');
  print("import 'mobile_version.dart' if (dart.library.html) 'web_version.dart';");
  
  print('\nThis allows:');
  print('- Different implementations for different platforms');
  print('- Same API contract through interfaces');
  print('- Code that is compiled only for the target platform');
}

// ======= DEBUGGING UTILITIES =======

// Tools and utilities that should only be included in debug builds
void debuggingUtilities() {
  print('\n===== DEBUGGING UTILITIES =====');
  
  // Simple debug print function
  void debugPrint(String message) {
    if (const bool.fromEnvironment('DEBUG', defaultValue: false)) {
      print('[DEBUG] $message');
    }
  }
  
  debugPrint('This will only show in debug mode');
  
  // More comprehensive debug class that could be conditionally compiled
  class DebugTools {
    static void log(Object message) {
      if (const bool.fromEnvironment('DEBUG', defaultValue: false)) {
        print('[LOG] $message');
      }
    }
    
    static void reportPerformance(String operation, int milliseconds) {
      if (const bool.fromEnvironment('DEBUG', defaultValue: false)) {
        print('[PERF] $operation: ${milliseconds}ms');
      }
    }
    
    static void checkInvariant(bool condition, String message) {
      assert(() {
        if (!condition) {
          print('[INVARIANT VIOLATED] $message');
          return false;
        }
        return true;
      }());
    }
  }
  
  DebugTools.log('Debug log message');
  DebugTools.reportPerformance('Example operation', 42);
  DebugTools.checkInvariant(true, 'This should not trigger');
  DebugTools.checkInvariant(false, 'This might trigger in debug mode');
}

// ======= CONFIGURING FEATURES =======

// Conditional features based on build configuration
void conditionalFeatures() {
  print('\n===== CONDITIONAL FEATURES =====');
  
  // Feature flags
  const bool enableExperimentalFeature = bool.fromEnvironment('EXPERIMENTAL', defaultValue: false);
  const bool enablePremiumFeatures = bool.fromEnvironment('PREMIUM', defaultValue: false);
  
  print('Experimental features enabled: $enableExperimentalFeature');
  print('Premium features enabled: $enablePremiumFeatures');
  
  // Feature-specific code
  if (enableExperimentalFeature) {
    print('Experimental feature code would run here');
  }
  
  if (enablePremiumFeatures) {
    print('Premium feature code would run here');
  }
  
  // Configuration based on target environment
  const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
  
  print('Current environment: $environment');
  
  switch (environment) {
    case 'production':
      print('Using production configuration');
      print('- Live API endpoints');
      print('- Error reporting enabled');
      print('- Analytics enabled');
      break;
    case 'staging':
      print('Using staging configuration');
      print('- Test API endpoints');
      print('- Error reporting enabled');
      print('- Analytics disabled');
      break;
    case 'development':
    default:
      print('Using development configuration');
      print('- Local API endpoints');
      print('- Verbose logging enabled');
      print('- Mock services available');
      break;
  }
}

// ======= PRACTICAL EXAMPLES =======

// Example: Platform-specific UI components
class PlatformButton {
  final String label;
  
  PlatformButton(this.label);
  
  void render() {
    print('\nRendering button on current platform:');
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        _renderCupertinoButton();
      } else if (Platform.isAndroid || Platform.isFuchsia) {
        _renderMaterialButton();
      } else {
        _renderBasicButton();
      }
    } catch (e) {
      // Fallback for web
      print('Rendering web button with label: "$label"');
    }
  }
  
  void _renderMaterialButton() {
    print('Rendering Material button with label: "$label"');
    print('- Elevated style');
    print('- Ripple effect on tap');
  }
  
  void _renderCupertinoButton() {
    print('Rendering Cupertino button with label: "$label"');
    print('- Rounded corners');
    print('- Fade animation on tap');
  }
  
  void _renderBasicButton() {
    print('Rendering basic button with label: "$label"');
  }
}

// Example: Build optimization
void buildOptimization() {
  print('\n===== BUILD OPTIMIZATION =====');
  
  // Code that would be stripped in production
  if (const bool.fromEnvironment('DEBUG', defaultValue: false)) {
    print('This code helps during development but is removed in production:');
    print('- Detailed error messages');
    print('- Performance monitoring');
    print('- Mock service simulations');
    print('- UI debugging tools');
  }
  
  // Performance testing that's only included in benchmark builds
  if (const bool.fromEnvironment('BENCHMARK', defaultValue: false)) {
    print('Running performance benchmarks...');
    // Benchmark code would go here
  }
}

// Accessing platform-specific functionality
void platformSpecificCode() {
  print('\n===== PLATFORM-SPECIFIC CODE =====');
  
  try {
    // This would normally be properly guarded with conditional imports
    // Here we're just demonstrating the concept with try/catch
    
    // File system access (dart:io)
    final directory = Directory.current;
    print('Current directory: ${directory.path}');
    
    // Platform-specific functionality example
    print('Environment variables:');
    Platform.environment.entries.take(3).forEach((entry) {
      print('${entry.key}: ${entry.value}');
    });
  } catch (e) {
    print('Platform-specific code not available on this platform');
    print('Would need web-specific implementation');
  }
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART CONDITIONAL COMPILATION EXAMPLES\n');
  
  platformConstants();
  environmentVariables();
  assertionsExample();
  conditionalImports();
  debuggingUtilities();
  conditionalFeatures();
  
  // Practical examples
  final button = PlatformButton('Click me');
  button.render();
  
  buildOptimization();
  platformSpecificCode();
  
  print('\nAll examples completed!');
  
  print('\nTo run with environment variables:');
  print('dart --define=DEBUG=true --define=API_KEY=my_key conditional_compilation.dart');
}
