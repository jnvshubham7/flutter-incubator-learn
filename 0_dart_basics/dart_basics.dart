// Dart Basics
// This file demonstrates the core concepts of Dart

// Variables and Data Types
void variablesAndDataTypes() {
  print('VARIABLES AND DATA TYPES:');
  
  // Numbers
  int age = 30;                   // Integer
  double price = 9.99;            // Double
  num value = 42;                 // Can be either int or double
  
  // Strings
  String name = 'John Doe';
  String multiLine = '''
    This is a
    multi-line string
  ''';
  
  // Booleans
  bool isActive = true;
  
  // Lists (Arrays)
  List<int> numbers = [1, 2, 3, 4, 5];
  List<dynamic> mixed = [1, 'two', true, 4.5];
  
  // Maps (Key-Value pairs)
  Map<String, dynamic> person = {
    'name': 'Alice',
    'age': 25,
    'isStudent': true
  };
  
  // Sets (Unique collections)
  Set<int> uniqueNumbers = {1, 2, 3, 3, 4}; // Will contain 1, 2, 3, 4
  
  // Type inference with var, final, and const
  var inferredType = 'Dart infers this is a String';
  final cannotReassign = 'This value cannot be changed';
  const compileTimeConstant = 'This is determined at compile time';
  
  print('Integer: $age');
  print('Double: $price');
  print('Num: $value');
  print('String: $name');
  print('Boolean: $isActive');
  print('List: $numbers');
  print('Map: $person');
  print('Set: $uniqueNumbers');
  print('Inferred Type: $inferredType');
  
  // Null safety
  String? nullableString; // Can be null
  // String nonNullable = null; // Error in Dart with null safety
  
  print('Nullable string: $nullableString');
  
  // Late variables - initialization deferred until first use
  late String lateInitialized;
  lateInitialized = 'Initialized later';
  print('Late variable: $lateInitialized');
}

// Control Flow
void controlFlow() {
  print('\nCONTROL FLOW:');
  
  // If-else statements
  int number = 42;
  if (number > 50) {
    print('Number is greater than 50');
  } else if (number == 50) {
    print('Number is equal to 50');
  } else {
    print('Number is less than 50');
  }
  
  // Switch statements
  String grade = 'B';
  switch (grade) {
    case 'A':
      print('Excellent!');
      break;
    case 'B':
      print('Good job!');
      break;
    case 'C':
      print('Fair.');
      break;
    default:
      print('Undefined grade.');
  }
  
  // For loops
  print('For loop:');
  for (int i = 0; i < 3; i++) {
    print('Index: $i');
  }
  
  // For-in loops
  print('For-in loop:');
  List<String> fruits = ['apple', 'banana', 'orange'];
  for (String fruit in fruits) {
    print('Fruit: $fruit');
  }
  
  // While loops
  print('While loop:');
  int counter = 0;
  while (counter < 3) {
    print('Counter: $counter');
    counter++;
  }
  
  // Do-while loops
  print('Do-while loop:');
  int doCounter = 0;
  do {
    print('DoCounter: $doCounter');
    doCounter++;
  } while (doCounter < 3);
  
  // Break and continue
  print('Break example:');
  for (int i = 0; i < 5; i++) {
    if (i == 3) break;
    print('Break loop: $i');
  }
  
  print('Continue example:');
  for (int i = 0; i < 5; i++) {
    if (i == 2) continue;
    print('Continue loop: $i');
  }
}

// Functions
int add(int a, int b) {
  return a + b;
}

// Optional parameters
String greet(String name, [String? title]) {
  if (title != null) {
    return 'Hello, $title $name!';
  }
  return 'Hello, $name!';
}

// Named parameters
String createUser({required String name, int age = 18, String? country}) {
  return 'User: $name, Age: $age${country != null ? ", Country: $country" : ""}';
}

// First-class functions
int calculate(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

void functions() {
  print('\nFUNCTIONS:');
  
  // Regular function call
  print('5 + 3 = ${add(5, 3)}');
  
  // Optional parameters
  print(greet('Alice'));
  print(greet('Bob', 'Mr.'));
  
  // Named parameters
  print(createUser(name: 'Charlie'));
  print(createUser(name: 'Diana', age: 25));
  print(createUser(name: 'Edward', age: 30, country: 'UK'));
  
  // Anonymous functions (lambda/closure)
  var multiply = (int x, int y) => x * y;
  print('5 * 3 = ${multiply(5, 3)}');
  
  // Higher-order functions
  print('10 + 5 = ${calculate(10, 5, add)}');
  print('10 - 5 = ${calculate(10, 5, (a, b) => a - b)}');
  
  // IIFE (Immediately Invoked Function Expression)
  print((() {
    var result = 'I am executed immediately!';
    return result;
  })());
}

// Classes and Objects
class Person {
  // Properties
  String name;
  int age;
  
  // Constructor
  Person(this.name, this.age);
  
  // Named constructor
  Person.guest() : name = 'Guest', age = 18;
  
  // Methods
  void introduce() {
    print('Hello, my name is $name and I am $age years old.');
  }
  
  // Getters and setters
  String get greeting => 'Mr/Ms. $name';
  
  set setAge(int value) {
    if (value >= 0) {
      age = value;
    }
  }
}

void classesAndObjects() {
  print('\nCLASSES AND OBJECTS:');
  
  // Creating an object
  var person1 = Person('Alice', 30);
  person1.introduce();
  
  // Using named constructor
  var guest = Person.guest();
  guest.introduce();
  
  // Using getters and setters
  print('Greeting: ${person1.greeting}');
  person1.setAge = 31;
  print('New age: ${person1.age}');
}

// Main function - entry point of the program
void main() {
  print('DART BASICS DEMONSTRATION\n');
  
  variablesAndDataTypes();
  controlFlow();
  functions();
  classesAndObjects();
  
  print('\nEnd of demonstration');
}
