// Dart Type Safety Examples
// This file demonstrates the concepts of type safety in Dart

// ======= TYPE SAFETY BASICS =======

// Dart is a statically typed language with type inference
void typeBasics() {
  print('===== TYPE BASICS =====');
  
  // Explicit type declaration
  int age = 30;
  String name = 'John';
  bool isActive = true;
  double price = 9.99;
  
  print('Explicit types:');
  print('age (${age.runtimeType}): $age');
  print('name (${name.runtimeType}): $name');
  print('isActive (${isActive.runtimeType}): $isActive');
  print('price (${price.runtimeType}): $price');
  
  // Type inference with var
  var inferredAge = 30;        // Inferred as int
  var inferredName = 'John';   // Inferred as String
  var inferredActive = true;   // Inferred as bool
  var inferredPrice = 9.99;    // Inferred as double
  
  print('\nType inference with var:');
  print('inferredAge (${inferredAge.runtimeType}): $inferredAge');
  print('inferredName (${inferredName.runtimeType}): $inferredName');
  print('inferredActive (${inferredActive.runtimeType}): $inferredActive');
  print('inferredPrice (${inferredPrice.runtimeType}): $inferredPrice');
  
  // Invalid operations will cause compile-time errors:
  // age = 'thirty';  // Error: A value of type 'String' can't be assigned to a variable of type 'int'
  // name = 30;       // Error: A value of type 'int' can't be assigned to a variable of type 'String'
  
  // dynamic type - turns off static type checking
  dynamic dynamicValue = 'Hello';
  print('\nDynamic type:');
  print('dynamicValue (${dynamicValue.runtimeType}): $dynamicValue');
  
  // dynamic allows changing types at runtime
  dynamicValue = 42;
  print('dynamicValue changed (${dynamicValue.runtimeType}): $dynamicValue');
  
  // Object - base class of all Dart objects
  Object objectValue = 'Hello';
  print('\nObject type:');
  print('objectValue (${objectValue.runtimeType}): $objectValue');
  
  // Object can hold any type, but maintains type safety
  objectValue = 42;
  print('objectValue changed (${objectValue.runtimeType}): $objectValue');
  
  // With Object, you need to cast before using type-specific operations
  if (objectValue is int) {
    print('objectValue + 10 = ${objectValue + 10}');
  }
}

// ======= NULL SAFETY =======

void nullSafety() {
  print('\n===== NULL SAFETY =====');
  
  // Non-nullable types (default in Dart with null safety)
  String nonNullable = 'Hello';
  // nonNullable = null;  // Error: The value 'null' can't be assigned to a variable of type 'String'
  
  // Nullable types with ?
  String? nullable = 'World';
  print('nullable: $nullable');
  
  nullable = null;
  print('nullable after setting to null: $nullable');
  
  // Working with nullable types
  String? nullableName = getUserName();
  
  // Option 1: Null check before using
  if (nullableName != null) {
    print('Name length: ${nullableName.length}');
  }
  
  // Option 2: Null-aware operator (?.)
  print('Name length with null-aware: ${nullableName?.length}');
  
  // Option 3: Null-aware assignment (??=)
  nullableName ??= 'Default Name';
  print('Name after null-aware assignment: $nullableName');
  
  // Option 4: Null coalescing operator (??)
  String displayName = getUserName() ?? 'Guest User';
  print('Display name: $displayName');
  
  // Option 5: Flow analysis (Dart compiler tracks nullability)
  String? flowName = 'Flow Analysis';
  if (flowName != null) {
    // Compiler knows flowName is not null here
    print('Flow name uppercase: ${flowName.toUpperCase()}');
  }
  
  // Option 6: Assertion operator (!) - use with caution!
  String? possiblyNull = 'Not Null';
  String definitelyNotNull = possiblyNull!; // Throws if possiblyNull is null
  print('Definitely not null: $definitelyNotNull');
  
  // Late variables
  print('\nLate variables:');
  late String lateInitialized;
  
  // No error - initialization is deferred
  lateInitialized = 'Initialized later';
  print('Late initialized: $lateInitialized');
}

String? getUserName() {
  // Simulating a function that might return null
  bool userLoggedIn = true;
  return userLoggedIn ? 'Alice' : null;
}

// ======= GENERICS AND TYPE SAFETY =======

// Generic class with type safety
class Box<T> {
  final T value;
  
  Box(this.value);
  
  T getValue() => value;
  
  @override
  String toString() => 'Box<${T.toString()}>($value)';
}

void genericsAndTypeSafety() {
  print('\n===== GENERICS AND TYPE SAFETY =====');
  
  // Typed lists
  List<int> numbers = [1, 2, 3];
  // numbers.add('four');  // Error: The argument type 'String' can't be assigned to the parameter type 'int'
  
  List<String> names = ['Alice', 'Bob', 'Charlie'];
  // names.add(42);  // Error: The argument type 'int' can't be assigned to the parameter type 'String'
  
  print('Typed lists:');
  print('numbers: $numbers');
  print('names: $names');
  
  // Using generic Box class
  Box<int> intBox = Box<int>(42);
  Box<String> stringBox = Box<String>('Hello');
  
  print('\nGeneric Box:');
  print('intBox: $intBox');
  print('intBox value: ${intBox.getValue()}');
  print('stringBox: $stringBox');
  print('stringBox value: ${stringBox.getValue()}');
  
  // Type checking with generics
  print('\nType checking with generics:');
  print('intBox is Box<int>: ${intBox is Box<int>}');
  print('intBox is Box<num>: ${intBox is Box<num>}');
  print('intBox is Box: ${intBox is Box}');
  
  // Covariance and contravariance
  // In Dart, generics are covariant
  List<int> intList = [1, 2, 3];
  
  // This works because List<int> is a subtype of List<num> (covariance)
  List<num> numList = intList;
  print('\nCovariance example:');
  print('intList: $intList');
  print('numList (from intList): $numList');
  
  // But be careful! This can lead to runtime errors if you're not careful
  // numList.add(3.14);  // This will compile but fail at runtime
  
  // Generic methods
  T twice<T extends num>(T value) => (value + value) as T;
  
  print('\nGeneric methods:');
  print('twice(5): ${twice(5)}');
  print('twice(3.14): ${twice(3.14)}');
}

// ======= TYPE CASTING AND CHECKING =======

void typeCastingAndChecking() {
  print('\n===== TYPE CASTING AND CHECKING =====');
  
  // Type checking with 'is' operator
  Object value = 'Hello';
  
  if (value is String) {
    print('value is a String');
    // Smart cast - compiler knows value is a String here
    print('value uppercase: ${value.toUpperCase()}');
  }
  
  value = 42;
  if (value is int) {
    print('value is an int');
    // Smart cast - compiler knows value is an int here
    print('value + 8: ${value + 8}');
  }
  
  // Type checking with 'is!' operator (is not)
  if (value is! String) {
    print('value is not a String');
  }
  
  // Explicit casting with 'as'
  Object someValue = 'Hello world';
  try {
    String stringValue = someValue as String;  // Safe cast
    print('String length: ${stringValue.length}');
    
    // Unsafe cast - will throw exception
    // int intValue = someValue as int;  // This will throw
  } catch (e) {
    print('Cast error: $e');
  }
  
  // Safe casting patterns
  Object mixedValue = [1, 2, 3];
  
  // Pattern 1: Check before cast
  if (mixedValue is List<dynamic>) {
    List<dynamic> list = mixedValue;
    print('List length: ${list.length}');
  }
  
  // Pattern 2: Try-catch for casting
  try {
    Map<String, dynamic> map = mixedValue as Map<String, dynamic>;
    print('Map: $map');
  } catch (e) {
    print('Safe cast failed: $e');
  }
  
  // Pattern 3: Conditional (ternary) cast
  var result = mixedValue is Map ? (mixedValue as Map) : null;
  print('Conditional cast result: $result');
}

// ======= ADVANCED TYPE SAFETY =======

// Function types
typedef IntTransformer = int Function(int);
typedef StringCallback = void Function(String);

// Higher-order function that accepts a function type
int processNumber(int value, IntTransformer transformer) {
  return transformer(value);
}

// Generic type alias
typedef Parser<T> = T Function(String);

// Type interfaces
abstract class Printable {
  String toPrintString();
}

class Person implements Printable {
  final String name;
  final int age;
  
  Person(this.name, this.age);
  
  @override
  String toPrintString() => 'Person: $name, $age years old';
}

// Record type (Dart 2.17+)
(String, int) getPersonData() {
  return ('Alice', 30);
}

// Union types simulation with sealed classes (before Dart 3.0)
abstract class Result {
  const Result();
}

class Success extends Result {
  final String value;
  
  Success(this.value);
}

class Failure extends Result {
  final String error;
  
  Failure(this.error);
}

// Pattern matching with sealed classes
String handleResult(Result result) {
  if (result is Success) {
    return 'Success with: ${result.value}';
  } else if (result is Failure) {
    return 'Failure with: ${result.error}';
  }
  return 'Unknown result';
}

void advancedTypeSafety() {
  print('\n===== ADVANCED TYPE SAFETY =====');
  
  // Using function types
  IntTransformer doubleIt = (int x) => x * 2;
  IntTransformer squareIt = (int x) => x * x;
  
  print('Function types:');
  print('processNumber(5, doubleIt): ${processNumber(5, doubleIt)}');
  print('processNumber(5, squareIt): ${processNumber(5, squareIt)}');
  
  // Using Printable interface
  Printable person = Person('John', 35);
  print('\nUsing interface:');
  print(person.toPrintString());
  
  // Records (Dart 2.17+)
  print('\nRecords:');
  var (name, age) = getPersonData();
  print('Name: $name, Age: $age');
  
  // Result pattern (sealed classes)
  print('\nResult pattern:');
  Result successResult = Success('Operation completed');
  Result failureResult = Failure('Network error');
  
  print(handleResult(successResult));
  print(handleResult(failureResult));
}

// ======= TYPE SAFETY BEST PRACTICES =======

void typeSafetyBestPractices() {
  print('\n===== TYPE SAFETY BEST PRACTICES =====');
  
  // 1. Avoid dynamic unless necessary
  print('1. Avoid using dynamic:');
  print('   - Favor explicit types or type inference');
  print('   - Use dynamic only when interacting with untyped APIs or for specific metaprogramming needs');
  
  // 2. Use nullable types properly
  print('\n2. Proper null handling:');
  String? nullableName = getName();
  
  // Bad: Using ! without checking
  // String forcedName = nullableName!; // May throw
  
  // Good: Check before using or provide fallback
  String safeName = nullableName ?? 'Default';
  print('   Safe name: $safeName');
  
  // 3. Generic type parameters
  print('\n3. Specify generic type parameters:');
  // Bad - loses type information:
  // final badList = [];
  // Good - specifies type:
  final goodList = <String>[];
  
  // 4. Use appropriate collection types
  print('\n4. Use appropriate collection types:');
  print('   - List<T> for ordered collections');
  print('   - Set<T> for unique collections');
  print('   - Map<K, V> for key-value pairs');
  
  // 5. Type-safe API design
  print('\n5. Type-safe API design:');
  print('   - Design APIs with clear parameter and return types');
  print('   - Use named parameters for better readability');
  print('   - Consider using generics for flexible yet type-safe APIs');
  
  // 6. Careful casting
  print('\n6. Careful casting:');
  Object something = 'Hello';
  
  // Unsafe: String forced = something as String;
  
  // Safe approach with type check:
  if (something is String) {
    String safe = something;
    print('   Safe string: $safe');
  }
}

String? getName() {
  return null; // Simulating null for demonstration
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART TYPE SAFETY EXAMPLES\n');
  
  typeBasics();
  nullSafety();
  genericsAndTypeSafety();
  typeCastingAndChecking();
  advancedTypeSafety();
  typeSafetyBestPractices();
  
  print('\nAll examples completed!');
}
