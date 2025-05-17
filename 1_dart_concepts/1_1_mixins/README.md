
### Step 1.1: Mixins and Extensions

**Estimated time**: 1 day

### **Extensions**

In Dart, **extensions** allow you to add functionality to existing classes, even if you don't have access to modify the original source code. This feature is useful when working with external libraries or types that you want to enhance with custom methods.

#### Example:

Here’s how you can extend the `String` class to add methods for parsing numbers:

```dart
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}
```

By using the extension:

```dart
print('42'.parseInt());  // Output: 42
```

**Design & Use-cases of Extensions:**

- **Design**: Extensions enable you to add methods or getters to an existing type (e.g., `String`, `DateTime`) without subclassing it.
- **Use-cases**:
  - Adding custom utility methods for common operations.
  - Extending third-party classes (e.g., adding helper functions to Flutter widgets).

#### Resources:

- [Dart Docs: Extension methods][11]
- [Dart Extension Methods Fundamentals][12]
- [Dart Static Extension Methods Design][13]

---

### **Mixins**

In Dart, **mixins** allow you to share code between multiple classes that don’t need to inherit from the same parent class. A mixin is a class that provides methods or fields but isn’t meant to be instantiated on its own.

#### Example:

```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

class Maestro with Musical {
  Maestro() {
    canConduct = true;
  }
}
```

Here, the `Musical` mixin is shared by the `Maestro` class, providing functionality like `entertainMe()`.

**Design & Use-cases of Mixins:**

- **Design**: Mixins let you reuse functionality across classes without a strict inheritance hierarchy.
- **Use-cases**:
  - Code sharing: Methods or fields that need to be used in multiple, unrelated classes.
  - Avoiding multiple inheritance: Dart doesn’t support multiple inheritance, but mixins offer a similar capability.

#### Resources:

- [Dart Docs: Mixins][21]
- [What are Mixins?][22]

---

### **Tasks**

- [`task_1.dart`](task_1.dart): Implement an extension on `DateTime` that returns a `String` in the format of `YYYY.MM.DD hh:mm`.
- [`task_2.dart`](task_2.dart): Implement an extension on `String` to parse links from a text.
- [`task_3.dart`](task_3.dart): Create mixins to describe equipable `Item`s by a `Character` type and implement the methods to equip them.

---

### **Questions and Answers**

#### **Extension Questions**

1. **Why do you need to extend classes?**

   - You need to extend classes to add functionality to existing types that you cannot modify directly (e.g., types from libraries). It allows you to enhance existing classes without subclassing.
   - **Example**: Extending the `String` class to parse numbers or links.
2. **Can an extension be private, unnamed, or generic?**

   - **Private**: Yes, by using an underscore for methods or fields within the extension.
   - **Unnamed**: No, extensions must have a name.
   - **Generic**: Yes, extensions can be generic. For example:
     ```dart
     extension<T> on List<T> {
       void logItems() {
         for (var item in this) {
           print(item);
         }
       }
     }
     ```
3. **How to resolve naming conflicts when multiple extensions define the same methods?**

   - Use the **most specific extension** for the type in question. If there’s ambiguity, you can explicitly invoke the desired extension:
     ```dart
     SomeExtension(myObject).methodName();
     ```

#### **Mixin Questions**

1. **What is the reasoning behind mixins?**

   - Mixins allow you to share functionality between classes without using inheritance. This is helpful when classes don’t share a common ancestor but require similar behavior.
   - **Example**: Implementing a `Flyable` mixin for classes like `Bird` and `Airplane` that have different hierarchies but share the ability to fly.
2. **Can you add static methods or fields to mixins?**

   - **Static methods**: Yes, mixins can have static methods.
     ```dart
     mixin Logger {
       static void log(String message) {
         print('Log: $message');
       }
     }
     ```
   - **Static fields**: No, mixins cannot have static fields, as they’re intended to be mixed into multiple classes, which could cause conflicts.
3. **`class`, `mixin`, or `mixin class`? What are the differences?**

   - **`class`**: Used to define a class that can be instantiated and extended.
   - **`mixin`**: Defines reusable code that can be applied to different classes using the `with` keyword, but cannot be instantiated.
   - **`mixin class`** (introduced in Dart 3): Can be used both as a mixin and as a class, but it cannot be inherited by other classes.
     - **Use case**: Use `class` for object creation and inheritance, `mixin` for sharing code across multiple classes, and `mixin class` when you want something in-between.

---

### Conclusion

By understanding and using **extensions** and **mixins** in Dart, you can enhance the flexibility of your code and improve code reuse. Extensions help you add methods to existing types, while mixins allow you to share behavior between classes without forcing inheritance.

---

### References

[Dart]: https://dart.dev
[11]: https://dart.dev/language/extension-methods
[12]: https://medium.com/dartlang/extension-methods-2d466cd8b308
[13]: https://github.com/dart-lang/language/blob/main/accepted/2.7/static-extension-methods/feature-specification.md
[21]: https://dart.dev/language/mixins
[22]: https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
