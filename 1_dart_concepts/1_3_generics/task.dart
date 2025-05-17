void main() {
  // Test with integers
  final intList = [1, 5, 3, 9, 7];
  print('Max integer: ${findMax(intList)}');
  
  // Test with strings
  final stringList = ['apple', 'banana', 'orange', 'kiwi', 'grape'];
  print('Max string: ${findMax(stringList)}');
  
  // Test with doubles
  final doubleList = [1.5, 3.7, 2.1, 5.9, 4.3];
  print('Max double: ${findMax(doubleList)}');
  
  // Test with custom comparable class
  final personList = [
    Person('Alice', 25),
    Person('Bob', 30),
    Person('Charlie', 22),
    Person('David', 40),
  ];
  print('Oldest person: ${findMax(personList)}');
  
  // Test with empty list - this will throw an exception
  try {
    findMax(<int>[]);
  } catch (e) {
    print('Exception for empty list: $e');
  }
}

/// Finds and returns the maximum element from a list of comparable objects.
/// 
/// The generic type [T] must implement the [Comparable] interface so that
/// elements can be compared with each other.
/// 
/// Throws [StateError] if the list is empty.
/// 
/// Example:
/// ```
/// final numbers = [1, 5, 3, 9, 7];
/// final max = findMax(numbers); // Returns 9
/// ```
T findMax<T extends Comparable<T>>(List<T> list) {
  if (list.isEmpty) {
    throw StateError('Cannot find maximum in an empty list');
  }
  
  T maxElement = list[0];
  
  for (T element in list) {
    if (element.compareTo(maxElement) > 0) {
      maxElement = element;
    }
  }
  
  return maxElement;
}

/// A sample class that implements [Comparable] for testing purposes.
class Person implements Comparable<Person> {
  final String name;
  final int age;
  
  Person(this.name, this.age);
  
  @override
  int compareTo(Person other) {
    // Compare by age
    return age.compareTo(other.age);
  }
  
  @override
  String toString() => '$name (age: $age)';
}
