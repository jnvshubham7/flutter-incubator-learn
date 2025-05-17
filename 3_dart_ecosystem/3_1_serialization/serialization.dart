// Dart Serialization Examples
// This file demonstrates JSON serialization and deserialization in Dart

import 'dart:convert';

// ======= BASIC SERIALIZATION =======

// Simple class with manual serialization
class Person {
  final String name;
  final int age;
  final String? email;
  
  Person({
    required this.name,
    required this.age,
    this.email,
  });
  
  // Convert a Person object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      if (email != null) 'email': email,
    };
  }
  
  // Create a Person object from a JSON map
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String?,
    );
  }
  
  @override
  String toString() => 'Person(name: $name, age: $age, email: $email)';
}

void basicSerializationExample() {
  print('===== BASIC SERIALIZATION =====');
  
  // Create a Person object
  final person = Person(name: 'John Doe', age: 30, email: 'john@example.com');
  
  // Serialize to JSON map
  final Map<String, dynamic> personJson = person.toJson();
  print('Person object: $person');
  print('Serialized to JSON map: $personJson');
  
  // Serialize to JSON string
  final String personJsonString = jsonEncode(personJson);
  print('Serialized to JSON string: $personJsonString');
  
  // Deserialize from JSON string
  final Map<String, dynamic> decodedJson = jsonDecode(personJsonString);
  final Person deserializedPerson = Person.fromJson(decodedJson);
  print('Deserialized back to Person: $deserializedPerson');
}

// ======= HANDLING COLLECTIONS =======

class Team {
  final String name;
  final List<Person> members;
  
  Team({
    required this.name,
    required this.members,
  });
  
  // Convert a Team object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'members': members.map((member) => member.toJson()).toList(),
    };
  }
  
  // Create a Team object from a JSON map
  factory Team.fromJson(Map<String, dynamic> json) {
    final List<dynamic> membersList = json['members'] as List;
    
    return Team(
      name: json['name'] as String,
      members: membersList
          .map((member) => Person.fromJson(member as Map<String, dynamic>))
          .toList(),
    );
  }
  
  @override
  String toString() => 'Team(name: $name, members: $members)';
}

void collectionsSerializationExample() {
  print('\n===== HANDLING COLLECTIONS =====');
  
  // Create team with members
  final team = Team(
    name: 'Development',
    members: [
      Person(name: 'Alice', age: 28, email: 'alice@example.com'),
      Person(name: 'Bob', age: 32),
      Person(name: 'Charlie', age: 24, email: 'charlie@example.com'),
    ],
  );
  
  // Serialize to JSON
  final teamJson = team.toJson();
  final teamJsonString = jsonEncode(teamJson);
  
  print('Team object: $team');
  print('Serialized to JSON string:');
  print(teamJsonString);
  
  // Deserialize from JSON
  final decodedTeamJson = jsonDecode(teamJsonString);
  final deserializedTeam = Team.fromJson(decodedTeamJson);
  
  print('Deserialized back to Team:');
  print(deserializedTeam);
}

// ======= NESTED OBJECTS =======

class Address {
  final String street;
  final String city;
  final String country;
  final String? postalCode;
  
  Address({
    required this.street,
    required this.city,
    required this.country,
    this.postalCode,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'country': country,
      if (postalCode != null) 'postalCode': postalCode,
    };
  }
  
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as String?,
    );
  }
  
  @override
  String toString() =>
      'Address(street: $street, city: $city, country: $country, postalCode: $postalCode)';
}

class Employee {
  final String name;
  final int id;
  final String department;
  final Address address;
  final List<String> skills;
  
  Employee({
    required this.name,
    required this.id,
    required this.department,
    required this.address,
    required this.skills,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'department': department,
      'address': address.toJson(),
      'skills': skills,
    };
  }
  
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'] as String,
      id: json['id'] as int,
      department: json['department'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      skills: (json['skills'] as List).map((e) => e as String).toList(),
    );
  }
  
  @override
  String toString() =>
      'Employee(name: $name, id: $id, department: $department, address: $address, skills: $skills)';
}

void nestedObjectsExample() {
  print('\n===== NESTED OBJECTS =====');
  
  // Create complex object with nested structure
  final employee = Employee(
    name: 'Maria Garcia',
    id: 12345,
    department: 'Engineering',
    address: Address(
      street: '123 Main St',
      city: 'San Francisco',
      country: 'USA',
      postalCode: '94105',
    ),
    skills: ['Dart', 'Flutter', 'Firebase'],
  );
  
  // Serialize to JSON
  final employeeJson = employee.toJson();
  final employeeJsonString = jsonEncode(employeeJson);
  
  print('Employee object: $employee');
  print('Serialized to JSON string:');
  // Pretty print JSON for readability
  final prettyJson = 
      JsonEncoder.withIndent('  ').convert(employeeJson);
  print(prettyJson);
  
  // Deserialize from JSON
  final decodedEmployeeJson = jsonDecode(employeeJsonString);
  final deserializedEmployee = Employee.fromJson(decodedEmployeeJson);
  
  print('Deserialized back to Employee:');
  print(deserializedEmployee);
}

// ======= DATE AND TIME SERIALIZATION =======

class Event {
  final String title;
  final DateTime date;
  final Duration duration;
  
  Event({
    required this.title,
    required this.date,
    required this.duration,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(), // Convert DateTime to ISO8601 string
      'duration': duration.inSeconds, // Store duration as seconds
    };
  }
  
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String), // Parse ISO8601 string
      duration: Duration(seconds: json['duration'] as int), // Create duration from seconds
    );
  }
  
  @override
  String toString() {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final durationStr = '${hours}h ${minutes}m';
    return 'Event(title: $title, date: ${_formatDateTime(date)}, duration: $durationStr)';
  }
  
  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

void dateTimeSerializationExample() {
  print('\n===== DATE AND TIME SERIALIZATION =====');
  
  // Create an event
  final event = Event(
    title: 'Flutter Conference',
    date: DateTime(2023, 6, 15, 9, 0), // June 15, 2023, 9:00 AM
    duration: Duration(hours: 8, minutes: 30), // 8 hours and 30 minutes
  );
  
  // Serialize to JSON
  final eventJson = event.toJson();
  final eventJsonString = jsonEncode(eventJson);
  
  print('Event object: $event');
  print('Serialized to JSON: $eventJson');
  
  // Deserialize from JSON
  final decodedEventJson = jsonDecode(eventJsonString);
  final deserializedEvent = Event.fromJson(decodedEventJson);
  
  print('Deserialized back to Event: $deserializedEvent');
}

// ======= HANDLING ENUMS =======

enum UserRole { admin, editor, viewer }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.admin:
        return 'ADMIN';
      case UserRole.editor:
        return 'EDITOR';
      case UserRole.viewer:
        return 'VIEWER';
    }
  }
  
  static UserRole fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMIN':
        return UserRole.admin;
      case 'EDITOR':
        return UserRole.editor;
      case 'VIEWER':
        return UserRole.viewer;
      default:
        throw ArgumentError('Invalid UserRole value: $value');
    }
  }
}

class User {
  final String username;
  final UserRole role;
  final bool isActive;
  
  User({
    required this.username,
    required this.role,
    this.isActive = true,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'role': role.value, // Convert enum to string
      'isActive': isActive,
    };
  }
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      role: UserRoleExtension.fromString(json['role'] as String), // Convert string back to enum
      isActive: json['isActive'] as bool,
    );
  }
  
  @override
  String toString() => 'User(username: $username, role: $role, isActive: $isActive)';
}

void enumSerializationExample() {
  print('\n===== HANDLING ENUMS =====');
  
  // Create users with different roles
  final users = [
    User(username: 'johndoe', role: UserRole.admin),
    User(username: 'janedoe', role: UserRole.editor),
    User(username: 'guestuser', role: UserRole.viewer, isActive: false),
  ];
  
  // Serialize to JSON
  final usersJson = users.map((user) => user.toJson()).toList();
  final usersJsonString = jsonEncode(usersJson);
  
  print('Users:');
  users.forEach((user) => print('- $user'));
  
  print('Serialized to JSON:');
  print(usersJsonString);
  
  // Deserialize from JSON
  final decodedUsersJson = jsonDecode(usersJsonString) as List<dynamic>;
  final deserializedUsers = decodedUsersJson
      .map((json) => User.fromJson(json as Map<String, dynamic>))
      .toList();
  
  print('Deserialized back to Users:');
  deserializedUsers.forEach((user) => print('- $user'));
}

// ======= ERROR HANDLING =======

void errorHandlingExample() {
  print('\n===== ERROR HANDLING =====');
  
  // Missing required field
  final invalidPersonJson = '{"name": "John"}'; // Missing age field
  
  try {
    final decodedJson = jsonDecode(invalidPersonJson);
    final person = Person.fromJson(decodedJson);
    print('This should not print: $person');
  } catch (e) {
    print('Error deserializing person with missing field: $e');
  }
  
  // Wrong type
  final wrongTypeJson = '{"name": "John", "age": "thirty"}'; // Age is a string, not an int
  
  try {
    final decodedJson = jsonDecode(wrongTypeJson);
    final person = Person.fromJson(decodedJson);
    print('This should not print: $person');
  } catch (e) {
    print('Error deserializing person with wrong type: $e');
  }
  
  // Invalid JSON syntax
  final invalidJsonSyntax = '{"name": "John", "age": 30,}'; // Extra comma
  
  try {
    final decodedJson = jsonDecode(invalidJsonSyntax);
    print('This should not print: $decodedJson');
  } catch (e) {
    print('Error parsing invalid JSON syntax: $e');
  }
  
  // A more robust approach: validation in fromJson
  class RobustPerson {
    final String name;
    final int age;
    final String? email;
    
    RobustPerson({required this.name, required this.age, this.email});
    
    factory RobustPerson.fromJson(Map<String, dynamic> json) {
      // Validate required fields
      if (json['name'] == null) {
        throw FormatException('Missing required field: name');
      }
      
      if (json['age'] == null) {
        throw FormatException('Missing required field: age');
      }
      
      // Validate types
      if (json['name'] is! String) {
        throw FormatException('Field "name" must be a string');
      }
      
      if (json['age'] is! int) {
        // Try to convert to int if possible
        int? age;
        if (json['age'] is String) {
          try {
            age = int.parse(json['age'] as String);
          } catch (_) {
            throw FormatException('Field "age" could not be parsed as an integer');
          }
        } else {
          throw FormatException('Field "age" must be an integer');
        }
        
        // Create with converted value
        return RobustPerson(
          name: json['name'] as String,
          age: age!,
          email: json['email'] as String?,
        );
      }
      
      // Normal creation
      return RobustPerson(
        name: json['name'] as String,
        age: json['age'] as int,
        email: json['email'] as String?,
      );
    }
    
    @override
    String toString() => 'RobustPerson(name: $name, age: $age, email: $email)';
  }
  
  print('\nTrying a more robust approach:');
  
  // Test with string age
  try {
    final stringAgeJson = '{"name": "John", "age": "30"}';
    final decodedJson = jsonDecode(stringAgeJson);
    final person = RobustPerson.fromJson(decodedJson);
    print('Successfully parsed with string age conversion: $person');
  } catch (e) {
    print('Error: $e');
  }
  
  // Test with missing field
  try {
    final missingFieldJson = '{"name": "John"}';
    final decodedJson = jsonDecode(missingFieldJson);
    final person = RobustPerson.fromJson(decodedJson);
    print('This should not print: $person');
  } catch (e) {
    print('Robust handling caught missing field: $e');
  }
}

// ======= PRACTICAL COMPLETE EXAMPLE =======

// Using a real-world example of a product catalog
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> categories;
  final Map<String, String> attributes;
  final bool inStock;
  final DateTime createdAt;
  
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categories,
    required this.attributes,
    required this.inStock,
    required this.createdAt,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categories': categories,
      'attributes': attributes,
      'inStock': inStock,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(), // Handle both int and double
      categories: (json['categories'] as List).map((e) => e as String).toList(),
      attributes: Map<String, String>.from(json['attributes'] as Map),
      inStock: json['inStock'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  
  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)}, inStock: $inStock)';
  }
}

class Catalog {
  final List<Product> products;
  final int totalProducts;
  final String currency;
  
  Catalog({
    required this.products,
    required this.totalProducts,
    required this.currency,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
      'totalProducts': totalProducts,
      'currency': currency,
    };
  }
  
  factory Catalog.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productsList = json['products'] as List;
    
    return Catalog(
      products: productsList
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(),
      totalProducts: json['totalProducts'] as int,
      currency: json['currency'] as String,
    );
  }
  
  @override
  String toString() {
    return 'Catalog(totalProducts: $totalProducts, currency: $currency)';
  }
  
  void printProducts() {
    print('Products:');
    for (final product in products) {
      print('- $product');
    }
  }
}

void practicalExampleCatalog() {
  print('\n===== PRACTICAL COMPLETE EXAMPLE =====');
  
  // Create a product catalog
  final catalog = Catalog(
    products: [
      Product(
        id: 101,
        name: 'Smartphone X',
        description: 'Latest smartphone with advanced features',
        price: 699.99,
        categories: ['Electronics', 'Mobile Phones'],
        attributes: {'color': 'Black', 'storage': '128GB', 'display': '6.1 inch'},
        inStock: true,
        createdAt: DateTime(2023, 1, 15),
      ),
      Product(
        id: 102,
        name: 'Laptop Pro',
        description: 'High-performance laptop for professionals',
        price: 1299.99,
        categories: ['Electronics', 'Computers'],
        attributes: {'processor': 'i7', 'ram': '16GB', 'storage': '512GB SSD'},
        inStock: true,
        createdAt: DateTime(2023, 2, 10),
      ),
      Product(
        id: 103,
        name: 'Wireless Earbuds',
        description: 'Premium sound quality with noise cancellation',
        price: 149.99,
        categories: ['Electronics', 'Audio'],
        attributes: {'color': 'White', 'battery': '24h', 'type': 'In-ear'},
        inStock: false,
        createdAt: DateTime(2023, 3, 5),
      ),
    ],
    totalProducts: 3,
    currency: 'USD',
  );
  
  // Serialize to JSON
  final catalogJson = catalog.toJson();
  final catalogJsonString = jsonEncode(catalogJson);
  
  print('Catalog object:');
  print(catalog);
  catalog.printProducts();
  
  // Save JSON to a file (simulated)
  print('\nSerialized to JSON (formatted for readability):');
  final formattedJson = JsonEncoder.withIndent('  ').convert(catalogJson);
  print(formattedJson);
  
  // Deserialize from JSON (simulating loading from a file)
  print('\nDeserializing from JSON string...');
  final decodedCatalogJson = jsonDecode(catalogJsonString);
  final deserializedCatalog = Catalog.fromJson(decodedCatalogJson);
  
  print('Deserialized back to Catalog:');
  print(deserializedCatalog);
  deserializedCatalog.printProducts();
  
  // Demonstrate serialization for API requests
  print('\nPreparing JSON for API request:');
  final newProduct = Product(
    id: 104,
    name: 'Smart Watch',
    description: 'Fitness and health tracking smartwatch',
    price: 249.99,
    categories: ['Electronics', 'Wearables'],
    attributes: {'color': 'Blue', 'water_resistant': 'Yes', 'battery': '7 days'},
    inStock: true,
    createdAt: DateTime.now(),
  );
  
  final apiRequestBody = jsonEncode(newProduct.toJson());
  print('API request body to add new product:');
  print(apiRequestBody);
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART SERIALIZATION EXAMPLES\n');
  
  basicSerializationExample();
  collectionsSerializationExample();
  nestedObjectsExample();
  dateTimeSerializationExample();
  enumSerializationExample();
  errorHandlingExample();
  practicalExampleCatalog();
  
  print('\nAll examples completed!');
}
