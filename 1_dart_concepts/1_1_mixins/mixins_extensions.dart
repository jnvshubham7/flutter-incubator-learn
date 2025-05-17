// Dart Mixins and Extensions Examples
// This file demonstrates the concepts of mixins and extensions in Dart

// EXTENSIONS
// Extensions allow adding functionality to existing classes without modifying them

// Example 1: DateTime Formatter Extension
extension DateTimeFormatter on DateTime {
  String format() {
    String year = this.year.toString();
    String month = this.month.toString().padLeft(2, '0');
    String day = this.day.toString().padLeft(2, '0');
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String second = this.second.toString().padLeft(2, '0');

    return '$year.$month.$day $hour:$minute:$second';
  }
  
  String formatSimple() {
    return '$year-$month-$day';
  }
}

// Example 2: String Extensions
extension StringUtils on String {
  // Convert string to title case
  String toTitleCase() {
    if (this.isEmpty) return this;
    
    List<String> words = this.split(' ');
    List<String> capitalized = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    
    return capitalized.join(' ');
  }
  
  // Extract all URLs from text
  List<String> extractUrls() {
    RegExp urlRegExp = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})',
      caseSensitive: false,
    );
    
    return urlRegExp.allMatches(this).map((match) => match.group(0)!).toList();
  }
  
  // Parse links and return parts (plain text and links)
  List<TextPart> parseLinks() {
    final List<TextPart> parts = [];
    final RegExp linkRegex = RegExp(r'([a-zA-Z0-9]+\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*)');
    
    int lastIndex = 0;
    for (Match match in linkRegex.allMatches(this)) {
      if (match.start > lastIndex) {
        // Add text before the link
        parts.add(TextPart(this.substring(lastIndex, match.start), false));
      }
      
      // Add the link
      parts.add(TextPart(match.group(0)!, true));
      
      lastIndex = match.end;
    }
    
    // Add remaining text after the last link
    if (lastIndex < this.length) {
      parts.add(TextPart(this.substring(lastIndex), false));
    }
    
    return parts;
  }
}

// Class to represent text parts (either plain text or links)
class TextPart {
  final String text;
  final bool isLink;
  
  TextPart(this.text, this.isLink);
  
  @override
  String toString() {
    return isLink ? 'Link("$text")' : 'Text("$text")';
  }
}

// Example 3: Int Extensions
extension IntUtils on int {
  // Convert to Roman numeral
  String toRoman() {
    if (this <= 0) return '';
    
    final List<MapEntry<int, String>> romanNumerals = [
      MapEntry(1000, 'M'),
      MapEntry(900, 'CM'),
      MapEntry(500, 'D'),
      MapEntry(400, 'CD'),
      MapEntry(100, 'C'),
      MapEntry(90, 'XC'),
      MapEntry(50, 'L'),
      MapEntry(40, 'XL'),
      MapEntry(10, 'X'),
      MapEntry(9, 'IX'),
      MapEntry(5, 'V'),
      MapEntry(4, 'IV'),
      MapEntry(1, 'I'),
    ];
    
    int value = this;
    StringBuffer result = StringBuffer();
    
    for (final entry in romanNumerals) {
      while (value >= entry.key) {
        result.write(entry.value);
        value -= entry.key;
      }
    }
    
    return result.toString();
  }
}

// MIXINS
// Mixins allow sharing code between multiple classes

// Example 1: Basic Traits
mixin Logger {
  void log(String message) {
    print('LOG: $message');
  }
}

mixin Validator {
  bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
  
  bool isValidPassword(String password) {
    return password.length >= 8;
  }
}

// Class using multiple mixins
class UserService with Logger, Validator {
  void createUser(String email, String password) {
    if (!isValidEmail(email)) {
      log('Invalid email format');
      return;
    }
    
    if (!isValidPassword(password)) {
      log('Password must be at least 8 characters');
      return;
    }
    
    log('User created successfully');
  }
}

// Example 2: Game Characters with Mixins
abstract class Item {}

// Mixins for different item types
mixin Weapon on Item {
  int get damage;
}

mixin MeleeWeapon on Weapon {
  int get durability;
}

mixin RangedWeapon on Weapon {
  int get range;
}

mixin Armor on Item {
  int get defense;
}

mixin Equipment {
  bool isEquipped = false;
  
  void equip() {
    isEquipped = true;
    print('Item equipped!');
  }
  
  void unequip() {
    isEquipped = false;
    print('Item unequipped!');
  }
}

// Concrete item classes using mixins
class Sword extends Item with Weapon, MeleeWeapon, Equipment {
  @override
  int get damage => 10;
  
  @override
  int get durability => 100;
}

class Bow extends Item with Weapon, RangedWeapon, Equipment {
  @override
  int get damage => 8;
  
  @override
  int get range => 20;
}

class Shield extends Item with Armor, Equipment {
  @override
  int get defense => 5;
}

class Helmet extends Item with Armor, Equipment {
  @override
  int get defense => 3;
}

// Character class using items with mixins
class Character {
  String name;
  Item? leftHand;
  Item? rightHand;
  Helmet? helmet;
  Shield? shield;
  
  Character(this.name);
  
  int get totalDamage {
    int damage = 0;
    
    if (leftHand is Weapon) {
      damage += (leftHand as Weapon).damage;
    }
    
    if (rightHand is Weapon) {
      damage += (rightHand as Weapon).damage;
    }
    
    return damage;
  }
  
  int get totalDefense {
    int defense = 0;
    
    if (shield is Armor) {
      defense += (shield as Armor).defense;
    }
    
    if (helmet is Armor) {
      defense += (helmet as Armor).defense;
    }
    
    return defense;
  }
  
  void equip(Item item) {
    if (item is Equipment) {
      (item as Equipment).equip();
    }
    
    if (item is Sword && leftHand == null) {
      leftHand = item;
      print('$name equipped a sword in the left hand');
    } else if (item is Bow && rightHand == null) {
      rightHand = item;
      print('$name equipped a bow in the right hand');
    } else if (item is Shield && shield == null) {
      shield = item;
      print('$name equipped a shield');
    } else if (item is Helmet && helmet == null) {
      helmet = item;
      print('$name equipped a helmet');
    } else {
      print('Cannot equip this item - slot is occupied or incompatible');
    }
  }
  
  void showStats() {
    print('$name - Damage: $totalDamage, Defense: $totalDefense');
  }
}

// Example 3: Media Player mixins
mixin AudioPlayer {
  void playAudio(String file) {
    print('Playing audio: $file');
  }
  
  void stopAudio() {
    print('Audio stopped');
  }
}

mixin VideoPlayer {
  void playVideo(String file) {
    print('Playing video: $file');
  }
  
  void stopVideo() {
    print('Video stopped');
  }
}

class MediaPlayer with AudioPlayer, VideoPlayer {
  String currentMedia = '';
  
  void play(String file) {
    currentMedia = file;
    if (file.endsWith('.mp3') || file.endsWith('.wav')) {
      playAudio(file);
    } else if (file.endsWith('.mp4') || file.endsWith('.mov')) {
      playVideo(file);
    } else {
      print('Unsupported media format');
    }
  }
  
  void stop() {
    if (currentMedia.endsWith('.mp3') || currentMedia.endsWith('.wav')) {
      stopAudio();
    } else if (currentMedia.endsWith('.mp4') || currentMedia.endsWith('.mov')) {
      stopVideo();
    }
    currentMedia = '';
  }
}

// Main function to demonstrate extensions and mixins
void main() {
  print('===== EXTENSIONS DEMO =====');
  
  // DateTime Formatter Extension
  final now = DateTime.now();
  print('Current datetime: ${now.format()}');
  print('Simple date: ${now.formatSimple()}');
  
  // String Extensions
  final text = 'hello world this is a TEST';
  print('Original: $text');
  print('Title case: ${text.toTitleCase()}');
  
  final textWithLinks = 'Visit google.com or flutter.dev for more info about dart.dev programming';
  print('\nText with links: $textWithLinks');
  
  final parts = textWithLinks.parseLinks();
  print('Parsed parts:');
  for (final part in parts) {
    print('- $part');
  }
  
  // Int Extensions
  final number = 2023;
  print('\nNumber: $number');
  print('Roman numeral: ${number.toRoman()}');
  
  print('\n===== MIXINS DEMO =====');
  
  // UserService with Logger and Validator mixins
  final userService = UserService();
  print('Testing UserService:');
  userService.createUser('test@example.com', 'password123');
  userService.createUser('invalid-email', 'short');
  
  // Character and Items with mixins
  print('\nTesting Character and Items:');
  final warrior = Character('Warrior');
  final sword = Sword();
  final shield = Shield();
  final helmet = Helmet();
  
  warrior.equip(sword);
  warrior.equip(shield);
  warrior.equip(helmet);
  warrior.showStats();
  
  // Media Player with mixins
  print('\nTesting MediaPlayer:');
  final player = MediaPlayer();
  player.play('song.mp3');
  player.stop();
  player.play('video.mp4');
  player.stop();
}
