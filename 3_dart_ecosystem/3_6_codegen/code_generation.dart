// Dart Code Generation Examples
// This file demonstrates code generation concepts in Dart
// Note: Some examples here are conceptual as code generation requires specific packages and build system configuration

// ======= WHY USE CODE GENERATION =======

// Code generation in Dart is used for:
// 1. Reducing boilerplate code (e.g., JSON serialization, data classes)
// 2. Generating code from annotations (e.g., dependency injection, routing)
// 3. Creating type-safe code based on external data sources (e.g., API clients from OpenAPI specs)
// 4. Implementing compile-time optimizations

/*
Common code generation packages in the Dart ecosystem:

1. json_serializable - Generates JSON serialization code
2. freezed - Creates immutable data classes with unions/pattern matching
3. built_value - Implements immutable value types
4. auto_route - Generates type-safe routing code
5. injectable - Type-safe dependency injection
6. mockito - Creates mock implementations for testing
7. hive_generator - For local database entities
8. drift - SQL database code generation
*/

// ======= JSON SERIALIZATION EXAMPLE =======

// This example demonstrates how code generation for JSON serialization would work
// In a real project, you would use packages like json_serializable

// Manual serialization (without code generation) - repetitive and error-prone
class UserManual {
  final String name;
  final String email;
  final int age;
  final List<String> roles;
  
  UserManual({
    required this.name,
    required this.email,
    required this.age,
    required this.roles,
  });
  
  // Manual serialization code - repetitive and error-prone
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'roles': roles,
    };
  }
  
  // Manual deserialization code - repetitive and error-prone
  factory UserManual.fromJson(Map<String, dynamic> json) {
    return UserManual(
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}

// With code generation using annotations (conceptual example)
// In a real project, this would be in a separate file with appropriate imports

/*
import 'package:json_annotation/json_annotation.dart';

// This tells the code generator which file will contain the generated code
part 'user.g.dart';

// This annotation tells the generator to create JSON serialization code for this class
@JsonSerializable()
class User {
  final String name;
  final String email;
  
  @JsonKey(defaultValue: 18)
  final int age;
  
  final List<String> roles;
  
  User({
    required this.name,
    required this.email,
    required this.age,
    required this.roles,
  });
  
  // These methods will be implemented by the generated code
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
*/

// The generated code would look something like this (conceptual example):

/*
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int? ?? 18,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
      'roles': instance.roles,
    };
*/

void jsonSerializationExample() {
  print('===== JSON SERIALIZATION WITH CODE GENERATION =====');
  print('Benefits of code generation for JSON serialization:');
  print('1. Reduces boilerplate code');
  print('2. Type-safe serialization and deserialization');
  print('3. Handles edge cases (like null values, default values)');
  print('4. Less prone to errors when refactoring');
  print('5. Supports complex nested objects automatically');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
final user = User(
  name: 'John Doe',
  email: 'john@example.com',
  age: 30,
  roles: ['admin', 'editor'],
);

// Serialize - code generator implements this method
final json = user.toJson();

// Deserialize - code generator implements this constructor
final deserializedUser = User.fromJson(json);
''');
}

// ======= IMMUTABLE DATA CLASSES EXAMPLE =======

// Without code generation - lots of boilerplate
class PersonManual {
  final String name;
  final int age;
  final String address;
  
  const PersonManual({
    required this.name,
    required this.age,
    required this.address,
  });
  
  // Need to implement copyWith manually
  PersonManual copyWith({
    String? name,
    int? age,
    String? address,
  }) {
    return PersonManual(
      name: name ?? this.name,
      age: age ?? this.age,
      address: address ?? this.address,
    );
  }
  
  // Need to implement equality manually
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PersonManual &&
        other.name == name &&
        other.age == age &&
        other.address == address;
  }
  
  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ address.hashCode;
  
  // Need to implement toString manually
  @override
  String toString() => 'Person(name: $name, age: $age, address: $address)';
}

// With code generation using annotations (conceptual example)
// In a real project, this would use a package like freezed

/*
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    required String name,
    required int age,
    required String address,
  }) = _Person;
  
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
*/

// The generated code would handle copyWith, equality, toString, and more

void immutableDataClassesExample() {
  print('\n===== IMMUTABLE DATA CLASSES WITH CODE GENERATION =====');
  print('Benefits of code generation for immutable data classes:');
  print('1. Automatically generates equality (==) and hashCode');
  print('2. Implements toString() for debugging');
  print('3. Creates copyWith methods for immutable updates');
  print('4. Can combine with JSON serialization');
  print('5. Supports pattern matching and union types');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
// Create an immutable object
final person = Person(name: 'Alice', age: 30, address: '123 Main St');

// Create a copy with some values changed (immutable update)
final updatedPerson = person.copyWith(age: 31, address: '456 Oak Ave');

// Compare equality (generated code handles this)
if (person != updatedPerson) {
  print('Person was updated');
}

// Pattern matching (with freezed)
final status = user.status.when(
  authenticated: (user) => 'Logged in as \${user.name}',
  unauthenticated: () => 'Not logged in',
  loading: () => 'Loading...',
);
''');
}

// ======= ROUTING GENERATION EXAMPLE =======

// Code generation for routing in Flutter apps (conceptual example)
// In a real project, this would use a package like auto_route

/*
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: ProfilePage),
    AutoRoute(page: SettingsPage),
    AutoRoute(
      page: ProductPage,
      path: '/products/:id',
    ),
  ],
)
class AppRouter extends _$AppRouter {}
*/

// The generated code would create a type-safe router with navigation methods

void routingGenerationExample() {
  print('\n===== ROUTING GENERATION EXAMPLE =====');
  print('Benefits of code generation for routing:');
  print('1. Type-safe navigation');
  print('2. Route arguments are enforced at compile time');
  print('3. Path parameters are handled automatically');
  print('4. Deep linking support');
  print('5. Automatic route definitions');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
// Navigation with type-safety
router.push(HomeRoute());
router.push(ProfileRoute(userId: 123));

// Push with generated extension methods
context.router.push(ProductRoute(productId: '456'));

// Type-safe nested navigation
router.pushAll([
  DashboardRoute(), 
  ProductsRoute(), 
  ProductDetailsRoute(id: 42)
]);
''');
}

// ======= DATABASE GENERATION EXAMPLE =======

// Code generation for database access (conceptual example)
// In a real project, this would use a package like drift

/*
import 'package:drift/drift.dart';

part 'database.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<List<TodoItem>> getAllTodoItems() => select(todoItems).get();
  
  Future<int> createTodoItem(TodoItemsCompanion entry) => 
      into(todoItems).insert(entry);
}
*/

// The generated code would provide type-safe database access methods

void databaseGenerationExample() {
  print('\n===== DATABASE GENERATION EXAMPLE =====');
  print('Benefits of code generation for databases:');
  print('1. Type-safe database queries');
  print('2. Compile-time query validation');
  print('3. Auto-generated data classes matching table schema');
  print('4. SQL injection protection');
  print('5. Schema migration support');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
// Querying with type-safety
final todos = await db.getAllTodoItems();

// Creating with type-safety
final id = await db.createTodoItem(
  TodoItemsCompanion.insert(
    title: 'Buy groceries',
    content: 'Milk, eggs, bread',
    createdAt: DateTime.now(),
  ),
);

// Complex queries with compile-time validation
final completedTodos = await db.select(db.todoItems)
  .where((t) => t.completed.equals(true))
  .orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
  .get();
''');
}

// ======= DEPENDENCY INJECTION EXAMPLE =======

// Code generation for dependency injection (conceptual example)
// In a real project, this would use a package like injectable

/*
import 'package:injectable/injectable.dart';

// Register a singleton that will be lazily instantiated
@singleton
class ApiClient {
  final HttpClient client;
  
  ApiClient(this.client);
  
  Future<User> getUser(String id) async {
    // Implementation
  }
}

// Register a factory that creates a new instance each time
@injectable
class UserRepository {
  final ApiClient apiClient;
  
  UserRepository(this.apiClient);
  
  Future<User> getUserById(String id) => apiClient.getUser(id);
}

// Configure the injector
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => init();
*/

// The generated code would handle dependency registration and resolution

void dependencyInjectionExample() {
  print('\n===== DEPENDENCY INJECTION EXAMPLE =====');
  print('Benefits of code generation for dependency injection:');
  print('1. Type-safe dependency resolution');
  print('2. Automatic dependency registration');
  print('3. Support for different scopes (singleton, factory, etc.)');
  print('4. Environment-specific dependencies');
  print('5. Simplified testing through dependency substitution');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
// Initialize dependency injection
configureDependencies();

// Resolve dependencies
final userRepository = getIt<UserRepository>();

// Use the resolved dependency
final user = await userRepository.getUserById('123');

// In tests, you can replace dependencies
getIt.registerSingleton<ApiClient>(MockApiClient());
''');
}

// ======= MOCKING FOR TESTS EXAMPLE =======

// Code generation for mocks in tests (conceptual example)
// In a real project, this would use a package like mockito

/*
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_service.dart';
import 'user_service_test.mocks.dart';

// Generate mock
@GenerateMocks([UserService])
void main() {
  late MockUserService mockUserService;
  
  setUp(() {
    mockUserService = MockUserService();
  });
  
  test('test user service', () async {
    // Set up mock behavior
    when(mockUserService.getUser('123')).thenAnswer(
      (_) async => User(id: '123', name: 'Test User')
    );
    
    // Call the code that uses the mock
    final user = await mockUserService.getUser('123');
    
    // Verify the results
    expect(user.name, equals('Test User'));
    verify(mockUserService.getUser('123')).called(1);
  });
}
*/

void mockingGenerationExample() {
  print('\n===== MOCKING FOR TESTS EXAMPLE =====');
  print('Benefits of code generation for mocks:');
  print('1. Type-safe mocking of classes and interfaces');
  print('2. Verification of interaction with mocks');
  print('3. Stubbing of method behaviors');
  print('4. Capture of arguments for further assertions');
  print('5. Support for complex return types and async methods');
  
  // Usage example (conceptual)
  print('\nUsage example (how it would look in real code):');
  print('''
// When a method is called on the mock, return a specific value
when(mockRepository.getItems()).thenReturn([Item('test')]);

// Execute the code that should use the mock
final result = await sut.processItems();

// Verify the mock was called as expected
verify(mockRepository.getItems()).called(1);
verify(mockLogger.log('Processing started')).called(1);

// Verify a method was not called
verifyNever(mockRepository.deleteItem(any));

// Capture arguments for verification
final captor = verify(mockRepository.saveItem(captureAny)).captured;
expect(captor.single.name, equals('processed_test'));
''');
}

// ======= CODE GENERATION SETUP =======

void codeGenerationSetup() {
  print('\n===== CODE GENERATION SETUP =====');
  print('How to set up code generation in a Dart project:');
  
  print('\n1. Add dependencies in pubspec.yaml:');
  print('''
dependencies:
  # Packages that use code generation
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1
  
dev_dependencies:
  # The build system
  build_runner: ^2.4.6
  
  # Code generators
  json_serializable: ^6.7.1
  freezed: ^2.4.5
''');
  
  print('\n2. Create annotated classes in your code');
  print('\n3. Run the code generator:');
  print('   dart run build_runner build --delete-conflicting-outputs');
  
  print('\n4. For continuous generation during development:');
  print('   dart run build_runner watch --delete-conflicting-outputs');
  
  print('\nCombining multiple generators:');
  print('Code generation packages in Dart use the build system, which allows multiple generators to work together');
}

// ======= BEST PRACTICES =======

void codeGenerationBestPractices() {
  print('\n===== CODE GENERATION BEST PRACTICES =====');
  
  print('1. Keep generated code out of version control:');
  print('   Add *.g.dart, *.freezed.dart, etc. to .gitignore');
  
  print('\n2. Document required build steps:');
  print('   Include code generation commands in README.md');
  
  print('\n3. Use part files properly:');
  print('   Keep generated code in separate files with part directive');
  
  print('\n4. Optimize build configuration:');
  print('   Create build.yaml for customizing build options');
  
  print('\n5. Handle errors in generated code:');
  print('   Fix annotation issues promptly to avoid blocking the team');
  
  print('\n6. Use CI to verify generation:');
  print('   Add a step to generate code and check for changes');
  
  print('\n7. Keep generators updated:');
  print('   Regularly update code generation packages');
  
  print('\n8. Don\'t modify generated code:');
  print('   Instead, modify the source annotations or create feature requests');
}

// ======= PROS AND CONS =======

void codeGenerationProsAndCons() {
  print('\n===== PROS AND CONS OF CODE GENERATION =====');
  
  print('Pros:');
  print('1. Reduces boilerplate code');
  print('2. Enforces consistent patterns');
  print('3. Reduces possibility of human error');
  print('4. Enables compile-time checking');
  print('5. Can optimize for performance');
  print('6. Improves maintainability');
  
  print('\nCons:');
  print('1. Adds complexity to the build process');
  print('2. Can increase build times');
  print('3. Learning curve for new developers');
  print('4. Debugging generated code can be challenging');
  print('5. May lead to dependency on specific packages');
  print('6. Generated code can be verbose (though it\'s not written manually)');
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART CODE GENERATION EXAMPLES\n');
  
  jsonSerializationExample();
  immutableDataClassesExample();
  routingGenerationExample();
  databaseGenerationExample();
  dependencyInjectionExample();
  mockingGenerationExample();
  
  codeGenerationSetup();
  codeGenerationBestPractices();
  codeGenerationProsAndCons();
  
  print('\nAll examples completed!');
}
