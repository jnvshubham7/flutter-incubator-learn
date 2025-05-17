/// A representation of a universally unique identifier (UUID).
///
/// A UUID is a 128-bit value that is unique across space and time.
/// This implementation follows the UUIDv4 format.
///
/// See https://en.wikipedia.org/wiki/Universally_unique_identifier
class UserId {
  /// Creates a new [UserId] with the given [value].
  ///
  /// Throws an [ArgumentError] if [value] is not a valid UUIDv4.
  UserId(String value) : _value = value {
    if (!_isValidUuid(value)) {
      throw ArgumentError.value(
        value, 
        'value', 
        'Must be a valid UUIDv4 format (36 characters)',
      );
    }
  }
  
  final String _value;
  
  /// Returns the string representation of this UUID.
  String get value => _value;
  
  @override
  String toString() => _value;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserId && other._value == _value;
  }
  
  @override
  int get hashCode => _value.hashCode;
  
  /// Validates that the string is in UUIDv4 format.
  static bool _isValidUuid(String? uuid) {
    if (uuid == null) return false;
    if (uuid.length != 36) return false;
    
    // UUIDv4 format: 8-4-4-4-12 (with hyphens at positions 8, 13, 18, 23)
    // Example: 123e4567-e89b-12d3-a456-426614174000
    final regex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    
    return regex.hasMatch(uuid);
  }
}

/// A user name that must be between 4 and 32 characters and contain only
/// alphabetical letters.
class UserName {
  /// Creates a new [UserName] with the given [value].
  ///
  /// Throws an [ArgumentError] if [value] is invalid.
  UserName(String value) : _value = value {
    if (value.length < 4 || value.length > 32) {
      throw ArgumentError.value(
        value,
        'value',
        'Name must be between 4 and 32 characters',
      );
    }
    
    if (!_containsOnlyLetters(value)) {
      throw ArgumentError.value(
        value,
        'value',
        'Name must contain only alphabetical letters',
      );
    }
  }
  
  final String _value;
  
  /// Returns the string representation of this name.
  String get value => _value;
  
  @override
  String toString() => _value;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserName && other._value == _value;
  }
  
  @override
  int get hashCode => _value.hashCode;
  
  /// Checks if the string contains only alphabetical letters.
  static bool _containsOnlyLetters(String value) {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(value);
  }
}

/// A user biography that must not exceed 255 characters.
class UserBio {
  /// Creates a new [UserBio] with the given [value].
  ///
  /// Throws an [ArgumentError] if [value] exceeds 255 characters.
  UserBio(String value) : _value = value {
    if (value.length > 255) {
      throw ArgumentError.value(
        value,
        'value',
        'Biography must not exceed 255 characters',
      );
    }
  }
  
  final String _value;
  
  /// Returns the string representation of this biography.
  String get value => _value;
  
  @override
  String toString() => _value;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserBio && other._value == _value;
  }
  
  @override
  int get hashCode => _value.hashCode;
}

/// Represents a user in the system.
class User {
  /// Creates a new [User] with the given parameters.
  ///
  /// The [id] must be a valid UUIDv4.
  /// If [name] is provided, it must be between 4 and 32 characters and contain
  /// only alphabetical letters.
  /// If [bio] is provided, it must not exceed 255 characters.
  const User({
    required this.id,
    this.name,
    this.bio,
  });
  
  /// The unique identifier of the user.
  final UserId id;
  
  /// The user's name, if available.
  final UserName? name;
  
  /// The user's biography, if available.
  final UserBio? bio;
  
  /// Creates a new [User] instance from raw string values.
  ///
  /// This factory constructor handles the conversion from raw strings
  /// to the appropriate types.
  factory User.fromStrings({
    required String id,
    String? name,
    String? bio,
  }) {
    return User(
      id: UserId(id),
      name: name != null ? UserName(name) : null,
      bio: bio != null ? UserBio(bio) : null,
    );
  }
}

/// Service for communicating with the backend.
class Backend {
  /// Retrieves a user from the backend by ID.
  Future<User> getUser(UserId id) async {
    // In a real implementation, this would make a network request.
    // For this example, we'll just return a mock user.
    return User(id: id);
  }
  
  /// Updates a user's information in the backend.
  Future<void> putUser(UserId id, {UserName? name, UserBio? bio}) async {
    // In a real implementation, this would make a network request.
    // For this example, we'll just print the values.
    print('Updating user: $id, name: $name, bio: $bio');
  }
}

/// Service for managing user operations.
class UserService {
  /// Creates a new [UserService] with the given [backend].
  UserService(this._backend);

  final Backend _backend;

  /// Retrieves a user by their ID.
  Future<User> get(UserId id) async {
    return _backend.getUser(id);
  }
  
  /// Updates a user's information.
  Future<void> update(User user) async {
    await _backend.putUser(user.id, name: user.name, bio: user.bio);
  }
}

void main() {
  // Example usage of the refactored classes
  try {
    // Create a user with a valid UUID, name, and bio
    final user = User.fromStrings(
      id: '123e4567-e89b-42d3-a456-426614174000',
      name: 'JohnDoe',
      bio: 'A software developer with a passion for clean code.',
    );
    
    final backend = Backend();
    final userService = UserService(backend);
    
    // Use the service to update the user
    userService.update(user);
    
    // Now trying with invalid values
    final invalidId = '123'; // Not a valid UUID
    try {
      UserId(invalidId);
    } catch (e) {
      print('Invalid UUID error: $e');
    }
    
    final invalidName = 'A1'; // Too short and contains a number
    try {
      UserName(invalidName);
    } catch (e) {
      print('Invalid name error: $e');
    }
    
    final invalidBio = 'A' * 256; // Too long
    try {
      UserBio(invalidBio);
    } catch (e) {
      print('Invalid bio error: $e');
    }
    
  } catch (e) {
    print('Error: $e');
  }
}
