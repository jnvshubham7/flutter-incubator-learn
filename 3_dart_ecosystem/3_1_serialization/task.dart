import 'dart:convert';
import 'dart:io';

/// Represents a gift in the system.
class Gift {
  /// Creates a new [Gift] with the given parameters.
  Gift({
    required this.id,
    required this.price,
    required this.description,
  });

  /// The unique identifier of the gift.
  final int id;

  /// The price of the gift.
  final int price;

  /// A description of the gift.
  final String description;

  /// Creates a new [Gift] from a JSON map.
  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'] as int,
      price: json['price'] as int,
      description: json['description'] as String,
    );
  }

  /// Converts this [Gift] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'description': description,
    };
  }
}

/// Represents a tariff in the system.
class Tariff {
  /// Creates a new [Tariff] with the given parameters.
  Tariff({
    this.id,
    this.price,
    this.clientPrice,
    required this.duration,
    required this.description,
  });

  /// The unique identifier of the tariff, if available.
  final int? id;

  /// The public price of the tariff, if available.
  final int? price;

  /// The client price of the tariff, if available.
  final int? clientPrice;

  /// The duration of the tariff.
  final String duration;

  /// A description of the tariff.
  final String description;

  /// Creates a new [Tariff] from a JSON map.
  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      id: json['id'] as int?,
      price: json['price'] as int?,
      clientPrice: json['client_price'] as int?,
      duration: json['duration'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts this [Tariff] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'duration': duration,
      'description': description,
    };

    if (id != null) data['id'] = id;
    if (price != null) data['price'] = price;
    if (clientPrice != null) data['client_price'] = clientPrice;

    return data;
  }
}

/// Represents a stream in the system.
class Stream {
  /// Creates a new [Stream] with the given parameters.
  Stream({
    required this.userId,
    required this.isPrivate,
    required this.settings,
    required this.shardUrl,
    required this.publicTariff,
    required this.privateTariff,
  });

  /// The unique identifier of the user associated with this stream.
  final String userId;

  /// Whether this stream is private.
  final bool isPrivate;

  /// Stream settings value.
  final int settings;

  /// The URL of the shard for this stream.
  final String shardUrl;

  /// The public tariff for this stream.
  final Tariff publicTariff;

  /// The private tariff for this stream.
  final Tariff privateTariff;

  /// Creates a new [Stream] from a JSON map.
  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
      userId: json['user_id'] as String,
      isPrivate: json['is_private'] as bool,
      settings: json['settings'] as int,
      shardUrl: json['shard_url'] as String,
      publicTariff: Tariff.fromJson(json['public_tariff'] as Map<String, dynamic>),
      privateTariff: Tariff.fromJson(json['private_tariff'] as Map<String, dynamic>),
    );
  }

  /// Converts this [Stream] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'is_private': isPrivate,
      'settings': settings,
      'shard_url': shardUrl,
      'public_tariff': publicTariff.toJson(),
      'private_tariff': privateTariff.toJson(),
    };
  }
}

/// Represents debug information in the system.
class DebugInfo {
  /// Creates a new [DebugInfo] with the given parameters.
  DebugInfo({
    required this.duration,
    required this.at,
  });

  /// The duration of the operation.
  final String duration;

  /// The timestamp when the operation occurred.
  final String at;

  /// Creates a new [DebugInfo] from a JSON map.
  factory DebugInfo.fromJson(Map<String, dynamic> json) {
    return DebugInfo(
      duration: json['duration'] as String,
      at: json['at'] as String,
    );
  }

  /// Converts this [DebugInfo] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'at': at,
    };
  }
}

/// Represents a request in the system.
class Request {
  /// Creates a new [Request] with the given parameters.
  Request({
    required this.type,
    required this.stream,
    required this.gifts,
    required this.debug,
  });

  /// The type of the request.
  final String type;

  /// The stream associated with this request.
  final Stream stream;

  /// The list of gifts available in this request.
  final List<Gift> gifts;

  /// Debug information for this request.
  final DebugInfo debug;

  /// Creates a new [Request] from a JSON map.
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      type: json['type'] as String,
      stream: Stream.fromJson(json['stream'] as Map<String, dynamic>),
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(e as Map<String, dynamic>))
          .toList(),
      debug: DebugInfo.fromJson(json['debug'] as Map<String, dynamic>),
    );
  }

  /// Converts this [Request] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'stream': stream.toJson(),
      'gifts': gifts.map((e) => e.toJson()).toList(),
      'debug': debug.toJson(),
    };
  }

  /// Converts this [Request] to YAML format.
  String toYaml() {
    final Map<String, dynamic> json = toJson();
    return _convertToYaml(json);
  }

  /// Converts this [Request] to TOML format.
  String toToml() {
    final Map<String, dynamic> json = toJson();
    return _convertToToml(json);
  }

  /// Helper method to convert a JSON object to YAML format.
  String _convertToYaml(dynamic obj, {int indent = 0}) {
    final indentStr = ' ' * indent;
    
    if (obj is Map) {
      final result = StringBuffer();
      obj.forEach((key, value) {
        if (value is Map) {
          result.writeln('$indentStr$key:');
          result.write(_convertToYaml(value, indent: indent + 2));
        } else if (value is List) {
          result.writeln('$indentStr$key:');
          for (var item in value) {
            result.writeln('$indentStr- ${_convertToYaml(item, indent: indent + 2)}');
          }
        } else {
          result.writeln('$indentStr$key: $value');
        }
      });
      return result.toString();
    } else {
      return obj.toString();
    }
  }

  /// Helper method to convert a JSON object to TOML format.
  String _convertToToml(dynamic obj, {String prefix = ''}) {
    final result = StringBuffer();
    
    if (obj is Map) {
      obj.forEach((key, value) {
        final newPrefix = prefix.isEmpty ? key : '$prefix.$key';
        
        if (value is Map) {
          result.writeln('[$newPrefix]');
          result.write(_convertToToml(value, prefix: newPrefix));
        } else if (value is List) {
          result.writeln('$newPrefix = [');
          for (var item in value) {
            result.writeln('  ${_tomlValueToString(item)},');
          }
          result.writeln(']');
        } else {
          result.writeln('$key = ${_tomlValueToString(value)}');
        }
      });
      return result.toString();
    } else {
      return _tomlValueToString(obj);
    }
  }

  /// Helper method to convert a value to a TOML string representation.
  String _tomlValueToString(dynamic value) {
    if (value is String) {
      return '"$value"';
    } else if (value is bool || value is num) {
      return value.toString();
    } else if (value is Map) {
      final inner = StringBuffer();
      inner.write('{');
      
      bool first = true;
      value.forEach((k, v) {
        if (!first) inner.write(', ');
        inner.write('$k = ${_tomlValueToString(v)}');
        first = false;
      });
      
      inner.write('}');
      return inner.toString();
    } else {
      return value.toString();
    }
  }
}

void main() async {
  // Read the JSON file
  final file = File('d:/GitHub/flutter-incubator/3_dart_ecosystem/3_1_serialization/request.json');
  final jsonString = await file.readAsString();
  
  // Remove the filepath comment at the beginning
  final cleanJsonString = jsonString.replaceFirst(RegExp(r'^//.*\n'), '');
  
  // Parse the JSON into a Request object
  final jsonMap = json.decode(cleanJsonString) as Map<String, dynamic>;
  final request = Request.fromJson(jsonMap);
  
  // Print the request as JSON
  print('JSON:');
  print(json.encode(request.toJson()));
  print('\n');
  
  // Print the request as YAML
  print('YAML:');
  print(request.toYaml());
  print('\n');
  
  // Print the request as TOML
  print('TOML:');
  print(request.toToml());
}
