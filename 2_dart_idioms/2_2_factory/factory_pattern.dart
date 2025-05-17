// Dart Factory Pattern Examples
// This file demonstrates the factory pattern in Dart

// ======= FACTORY CONSTRUCTORS =======

// Basic factory constructor
class Logger {
  static final Map<String, Logger> _cache = {};
  final String name;
  
  // Private constructor
  Logger._internal(this.name);
  
  // Factory constructor - controls instance creation
  factory Logger(String name) {
    // Return existing instance if available (singleton per name)
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    }
    
    // Create new instance and cache it
    final logger = Logger._internal(name);
    _cache[name] = logger;
    return logger;
  }
  
  void log(String message) {
    print('[$name] $message');
  }
}

void factoryConstructorExample() {
  print('===== FACTORY CONSTRUCTOR EXAMPLE =====');
  
  // Get loggers
  Logger appLogger = Logger('App');
  Logger networkLogger = Logger('Network');
  Logger appLoggerAgain = Logger('App');
  
  // Demonstrate singleton behavior (appLogger and appLoggerAgain are the same instance)
  print('appLogger == appLoggerAgain? ${identical(appLogger, appLoggerAgain)}');
  print('appLogger == networkLogger? ${identical(appLogger, networkLogger)}');
  
  // Use loggers
  appLogger.log('Application started');
  networkLogger.log('Request sent');
  appLoggerAgain.log('Application processing');
}

// ======= FACTORY WITH SUBTYPE SELECTION =======

// Abstract base class
abstract class Shape {
  // Factory constructor to create different shapes
  factory Shape(String type) {
    switch (type.toLowerCase()) {
      case 'circle':
        return Circle();
      case 'rectangle':
        return Rectangle();
      case 'square':
        return Square();
      default:
        throw ArgumentError('Invalid shape type: $type');
    }
  }
  
  // Common interface
  double get area;
  double get perimeter;
  String get shapeName;
  
  // Common method
  void draw() {
    print('Drawing a $shapeName:');
    print('- Area: $area');
    print('- Perimeter: $perimeter');
  }
}

// Concrete implementations
class Circle implements Shape {
  final double radius = 5.0;
  
  @override
  double get area => 3.14159 * radius * radius;
  
  @override
  double get perimeter => 2 * 3.14159 * radius;
  
  @override
  String get shapeName => 'Circle';
}

class Rectangle implements Shape {
  final double width = 10.0;
  final double height = 5.0;
  
  @override
  double get area => width * height;
  
  @override
  double get perimeter => 2 * (width + height);
  
  @override
  String get shapeName => 'Rectangle';
}

class Square implements Shape {
  final double side = 7.0;
  
  @override
  double get area => side * side;
  
  @override
  double get perimeter => 4 * side;
  
  @override
  String get shapeName => 'Square';
}

void shapeFactoryExample() {
  print('\n===== FACTORY WITH SUBTYPE SELECTION =====');
  
  try {
    // Create shapes using factory
    Shape circle = Shape('circle');
    Shape rectangle = Shape('rectangle');
    Shape square = Shape('square');
    
    // Use shapes
    circle.draw();
    rectangle.draw();
    square.draw();
    
    // Try invalid shape
    Shape unknown = Shape('triangle');
    unknown.draw(); // This won't be reached due to exception
  } catch (e) {
    print('Error: $e');
  }
}

// ======= FACTORY WITH PARAMETERS =======

class Point {
  final double x;
  final double y;
  
  // Regular constructor
  Point(this.x, this.y);
  
  // Factory constructor for creating a point from various formats
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      json['x'] is int ? (json['x'] as int).toDouble() : json['x'] as double,
      json['y'] is int ? (json['y'] as int).toDouble() : json['y'] as double,
    );
  }
  
  // Factory constructor for polar coordinates
  factory Point.fromPolar(double radius, double angle) {
    return Point(
      radius * cos(angle),
      radius * sin(angle),
    );
  }
  
  // Factory constructor for origin point
  factory Point.origin() {
    return Point(0, 0);
  }
  
  @override
  String toString() => 'Point($x, $y)';
}

// Simple math functions for demonstration
double sin(double angle) => angle; // Simplified for demonstration
double cos(double angle) => angle; // Simplified for demonstration

void factoryWithParametersExample() {
  print('\n===== FACTORY WITH PARAMETERS =====');
  
  // Create points using different factory constructors
  Point p1 = Point(3, 4);
  Point p2 = Point.fromJson({'x': 5, 'y': 6});
  Point p3 = Point.fromPolar(10, 0.5);
  Point p4 = Point.origin();
  
  print('Standard constructor: $p1');
  print('From JSON: $p2');
  print('From polar: $p3');
  print('Origin: $p4');
}

// ======= FACTORY METHOD PATTERN =======

// Creator class with factory method
abstract class Document {
  // Factory method
  factory Document(String type, String content) {
    switch (type.toLowerCase()) {
      case 'text':
        return TextDocument(content);
      case 'spreadsheet':
        return SpreadsheetDocument(content);
      case 'presentation':
        return PresentationDocument(content);
      default:
        throw ArgumentError('Unknown document type: $type');
    }
  }
  
  // Common methods
  String get fileExtension;
  void open();
  void save();
  
  // Constructor for subclasses
  Document.create();
}

// Concrete products
class TextDocument extends Document {
  final String content;
  
  TextDocument(this.content) : super.create();
  
  @override
  String get fileExtension => '.txt';
  
  @override
  void open() {
    print('Opening text document: "${content.substring(0, min(20, content.length))}..."');
  }
  
  @override
  void save() {
    print('Saving text document with extension $fileExtension');
  }
}

class SpreadsheetDocument extends Document {
  final String content;
  
  SpreadsheetDocument(this.content) : super.create();
  
  @override
  String get fileExtension => '.xlsx';
  
  @override
  void open() {
    print('Opening spreadsheet: "${content.substring(0, min(20, content.length))}..."');
  }
  
  @override
  void save() {
    print('Saving spreadsheet with extension $fileExtension');
  }
}

class PresentationDocument extends Document {
  final String content;
  
  PresentationDocument(this.content) : super.create();
  
  @override
  String get fileExtension => '.pptx';
  
  @override
  void open() {
    print('Opening presentation: "${content.substring(0, min(20, content.length))}..."');
  }
  
  @override
  void save() {
    print('Saving presentation with extension $fileExtension');
  }
}

// Helper function
int min(int a, int b) => a < b ? a : b;

void factoryMethodPatternExample() {
  print('\n===== FACTORY METHOD PATTERN =====');
  
  // Create documents using factory method
  Document textDoc = Document('text', 'This is a sample text document with some content.');
  Document spreadsheet = Document('spreadsheet', 'ID,Name,Value\n1,Item1,100\n2,Item2,200');
  Document presentation = Document('presentation', 'Title Slide: Factory Pattern in Dart');
  
  // Use documents
  textDoc.open();
  textDoc.save();
  
  spreadsheet.open();
  spreadsheet.save();
  
  presentation.open();
  presentation.save();
}

// ======= ABSTRACT FACTORY PATTERN =======

// Abstract product interfaces
abstract class Button {
  void render();
  void onClick(Function action);
}

abstract class Checkbox {
  void render();
  void onChange(Function action);
}

// Abstract factory interface
abstract class GUIFactory {
  Button createButton();
  Checkbox createCheckbox();
}

// Concrete products for material design
class MaterialButton implements Button {
  @override
  void render() {
    print('Rendering MaterialButton');
  }
  
  @override
  void onClick(Function action) {
    print('MaterialButton clicked');
    action();
  }
}

class MaterialCheckbox implements Checkbox {
  bool _checked = false;
  
  @override
  void render() {
    print('Rendering MaterialCheckbox (${_checked ? 'checked' : 'unchecked'})');
  }
  
  @override
  void onChange(Function action) {
    _checked = !_checked;
    print('MaterialCheckbox changed to $_checked');
    action();
  }
}

// Concrete products for cupertino design
class CupertinoButton implements Button {
  @override
  void render() {
    print('Rendering CupertinoButton');
  }
  
  @override
  void onClick(Function action) {
    print('CupertinoButton tapped');
    action();
  }
}

class CupertinoCheckbox implements Checkbox {
  bool _checked = false;
  
  @override
  void render() {
    print('Rendering CupertinoCheckbox (${_checked ? 'selected' : 'unselected'})');
  }
  
  @override
  void onChange(Function action) {
    _checked = !_checked;
    print('CupertinoCheckbox changed to $_checked');
    action();
  }
}

// Concrete factories
class MaterialFactory implements GUIFactory {
  @override
  Button createButton() {
    return MaterialButton();
  }
  
  @override
  Checkbox createCheckbox() {
    return MaterialCheckbox();
  }
}

class CupertinoFactory implements GUIFactory {
  @override
  Button createButton() {
    return CupertinoButton();
  }
  
  @override
  Checkbox createCheckbox() {
    return CupertinoCheckbox();
  }
}

// Client code
class Application {
  final Button button;
  final Checkbox checkbox;
  
  Application(GUIFactory factory)
      : button = factory.createButton(),
        checkbox = factory.createCheckbox();
  
  void render() {
    button.render();
    checkbox.render();
  }
  
  void simulateUserInteraction() {
    button.onClick(() {
      print('Button action performed');
    });
    
    checkbox.onChange(() {
      print('Checkbox state changed');
    });
  }
}

void abstractFactoryExample() {
  print('\n===== ABSTRACT FACTORY PATTERN =====');
  
  print('Creating Material UI:');
  final materialApp = Application(MaterialFactory());
  materialApp.render();
  materialApp.simulateUserInteraction();
  
  print('\nCreating Cupertino UI:');
  final cupertinoApp = Application(CupertinoFactory());
  cupertinoApp.render();
  cupertinoApp.simulateUserInteraction();
}

// ======= STATIC FACTORY METHODS =======

class MathUtils {
  // Private constructor prevents instantiation
  MathUtils._();
  
  // Static factory methods
  static int add(int a, int b) => a + b;
  static int subtract(int a, int b) => a - b;
  static int multiply(int a, int b) => a * b;
  static double divide(int a, int b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero');
    }
    return a / b;
  }
}

class ConfigurationManager {
  // Singleton instance
  static final ConfigurationManager _instance = ConfigurationManager._internal();
  
  // Private constructor
  ConfigurationManager._internal();
  
  // Static factory method - returns the singleton
  static ConfigurationManager getInstance() {
    return _instance;
  }
  
  // Sample configuration
  Map<String, dynamic> _config = {
    'apiUrl': 'https://api.example.com',
    'timeout': 30000,
    'debug': true,
  };
  
  // Configuration methods
  dynamic getValue(String key) => _config[key];
  void setValue(String key, dynamic value) => _config[key] = value;
  
  @override
  String toString() => 'ConfigurationManager($_config)';
}

void staticFactoryMethodsExample() {
  print('\n===== STATIC FACTORY METHODS =====');
  
  // Using MathUtils static factory methods
  print('MathUtils:');
  print('add(5, 3) = ${MathUtils.add(5, 3)}');
  print('subtract(10, 4) = ${MathUtils.subtract(10, 4)}');
  print('multiply(6, 7) = ${MathUtils.multiply(6, 7)}');
  print('divide(20, 4) = ${MathUtils.divide(20, 4)}');
  
  try {
    print('divide(5, 0) = ${MathUtils.divide(5, 0)}');
  } catch (e) {
    print('Error: $e');
  }
  
  // Using ConfigurationManager singleton through static factory
  print('\nConfigurationManager:');
  final config1 = ConfigurationManager.getInstance();
  final config2 = ConfigurationManager.getInstance();
  
  print('config1 == config2? ${identical(config1, config2)}');
  print('Initial config: ${config1.getValue('apiUrl')}');
  
  // Modify configuration
  config1.setValue('apiUrl', 'https://api.newdomain.com');
  
  // Both instances reflect the change because they are the same object
  print('Updated config through config1: ${config1.getValue('apiUrl')}');
  print('Value in config2 also changed: ${config2.getValue('apiUrl')}');
}

// ======= BUILDER PATTERN WITH FACTORY =======

// Product
class Email {
  final String to;
  final String from;
  final String subject;
  final String body;
  final List<String> cc;
  final List<String> bcc;
  final Map<String, String> headers;
  final List<String> attachments;
  
  // Private constructor
  Email._({
    required this.to,
    required this.from,
    required this.subject,
    required this.body,
    required this.cc,
    required this.bcc,
    required this.headers,
    required this.attachments,
  });
  
  // Factory method that uses the builder
  static EmailBuilder builder() {
    return EmailBuilder();
  }
  
  @override
  String toString() {
    return 'Email(to: $to, from: $from, subject: $subject, body: ${body.length > 20 ? body.substring(0, 20) + '...' : body}, cc: $cc, bcc: $bcc, headers: $headers, attachments: $attachments)';
  }
}

// Builder
class EmailBuilder {
  String? _to;
  String _from = 'noreply@example.com'; // Default value
  String _subject = '';
  String _body = '';
  final List<String> _cc = [];
  final List<String> _bcc = [];
  final Map<String, String> _headers = {};
  final List<String> _attachments = [];
  
  // Builder methods
  EmailBuilder to(String to) {
    _to = to;
    return this;
  }
  
  EmailBuilder from(String from) {
    _from = from;
    return this;
  }
  
  EmailBuilder subject(String subject) {
    _subject = subject;
    return this;
  }
  
  EmailBuilder body(String body) {
    _body = body;
    return this;
  }
  
  EmailBuilder addCC(String cc) {
    _cc.add(cc);
    return this;
  }
  
  EmailBuilder addBCC(String bcc) {
    _bcc.add(bcc);
    return this;
  }
  
  EmailBuilder addHeader(String name, String value) {
    _headers[name] = value;
    return this;
  }
  
  EmailBuilder addAttachment(String path) {
    _attachments.add(path);
    return this;
  }
  
  // Build method
  Email build() {
    if (_to == null) {
      throw ArgumentError('Email must have a recipient (to)');
    }
    
    return Email._(
      to: _to!,
      from: _from,
      subject: _subject,
      body: _body,
      cc: List.unmodifiable(_cc),
      bcc: List.unmodifiable(_bcc),
      headers: Map.unmodifiable(_headers),
      attachments: List.unmodifiable(_attachments),
    );
  }
}

void builderPatternWithFactoryExample() {
  print('\n===== BUILDER PATTERN WITH FACTORY =====');
  
  try {
    // Create a simple email
    final Email simpleEmail = Email.builder()
        .to('recipient@example.com')
        .subject('Hello')
        .body('This is a test email')
        .build();
    
    print('Simple email: $simpleEmail');
    
    // Create a more complex email
    final Email complexEmail = Email.builder()
        .to('client@example.com')
        .from('support@company.com')
        .subject('Your recent order #12345')
        .body('Thank you for your order. Here are the details...')
        .addCC('manager@company.com')
        .addCC('sales@company.com')
        .addBCC('analytics@company.com')
        .addHeader('X-Priority', 'High')
        .addAttachment('/path/to/invoice.pdf')
        .addAttachment('/path/to/product_image.jpg')
        .build();
    
    print('Complex email: $complexEmail');
    
    // Missing required field
    final Email invalidEmail = Email.builder()
        .subject('Invalid Email')
        .body('This will fail')
        .build();
    
    print('This should not print: $invalidEmail');
  } catch (e) {
    print('Error: $e');
  }
}

// ======= MAIN FUNCTION =======
void main() {
  print('DART FACTORY PATTERN EXAMPLES\n');
  
  factoryConstructorExample();
  shapeFactoryExample();
  factoryWithParametersExample();
  factoryMethodPatternExample();
  abstractFactoryExample();
  staticFactoryMethodsExample();
  builderPatternWithFactoryExample();
  
  print('\nAll examples completed!');
}
