// Task 3 implementation - Item categories with mixins

/// Object equipable by a [Character].
abstract class Item {}

/// Mixin for items that provide damage
mixin DamageMixin on Item {
  int get damage;
}

/// Mixin for items that provide defense
mixin DefenseMixin on Item {
  int get defense;
}

/// Weapon class that provides damage
class Weapon extends Item with DamageMixin {
  final int _damage;
  
  Weapon(this._damage);
  
  @override
  int get damage => _damage;
}

/// Armor class that provides defense
class Armor extends Item with DefenseMixin {
  final int _defense;
  
  Armor(this._defense);
  
  @override
  int get defense => _defense;
}

/// Specific weapon types
class Sword extends Weapon {
  Sword(int damage) : super(damage);
}

class Bow extends Weapon {
  Bow(int damage) : super(damage);
}

/// Specific armor types
class Helmet extends Armor {
  Helmet(int defense) : super(defense);
}

class Chestplate extends Armor {
  Chestplate(int defense) : super(defense);
}

class Greaves extends Armor {
  Greaves(int defense) : super(defense);
}

class Boots extends Armor {
  Boots(int defense) : super(defense);
}

/// Entity equipping [Item]s.
class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;

  /// Returns all the [Item]s equipped by this [Character].
  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  /// Returns the total damage of this [Character].
  int get damage {
    int totalDamage = 0;
    
    for (final item in equipped) {
      if (item is DamageMixin) {
        totalDamage += item.damage;
      }
    }
    
    return totalDamage;
  }

  /// Returns the total defense of this [Character].
  int get defense {
    int totalDefense = 0;
    
    for (final item in equipped) {
      if (item is DefenseMixin) {
        totalDefense += item.defense;
      }
    }
    
    return totalDefense;
  }

  /// Equips the provided [item], meaning putting it to the corresponding slot.
  ///
  /// If there's already a slot occupied, then throws a [OverflowException].
  void equip(Item item) {
    if (item is Weapon) {
      if (leftHand == null) {
        leftHand = item;
      } else if (rightHand == null) {
        rightHand = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Helmet) {
      if (hat == null) {
        hat = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Chestplate) {
      if (torso == null) {
        torso = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Greaves) {
      if (legs == null) {
        legs = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Boots) {
      if (shoes == null) {
        shoes = item;
      } else {
        throw OverflowException();
      }
    } else {
      throw ArgumentError('Unknown item type');
    }
  }
}

/// [Exception] indicating there's no place left in the [Character]'s slot.
class OverflowException implements Exception {
  @override
  String toString() => 'No place left to equip item';
}

void main() {
  final character = Character();
  
  // Equip some items
  try {
    character.equip(Sword(10));
    character.equip(Bow(5));
    character.equip(Helmet(3));
    character.equip(Chestplate(7));
    character.equip(Greaves(4));
    character.equip(Boots(2));
    
    // Print character stats
    print('Character damage: ${character.damage}');
    print('Character defense: ${character.defense}');
    
    // Try to equip another weapon - should throw exception
    character.equip(Sword(8));
  } catch (e) {
    print('Exception caught: $e');
  }
}
