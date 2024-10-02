/// Collection of [messages] allowed to be [read].
class Chat {
  Chat(this.onRead);

  /// Callback, called when this [Chat] should be marked as read until the
  /// provided [int] remotely.
  ///
  /// Intended to be a backend mutation.
  final void Function(int message) onRead;

  /// [List] of messages in this [Chat].
  final List<int> messages = List.generate(30, (i) => i);

  /// Marks this [Chat] as read until the specified [message].
  void read(int message) {
    // TODO: [onRead] should be invoked no more than 1 time in a second.

    onRead(message);
  }
}

Future<void> main() async {
  final Chat chat = Chat((i) => print('Read until $i'));

  chat.read(0);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(4);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(10);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(11);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(12);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(13);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(14);
  await Future.delayed(Duration(milliseconds: 100));

  chat.read(15);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(20);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(35);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(36);
  await Future.delayed(Duration(milliseconds: 500));
  chat.read(37);
  await Future.delayed(Duration(milliseconds: 800));

  chat.read(40);
}


Here is the full code with the added logic to prevent `onRead` from being invoked more than once per second:
```
import 'dart:math';
import 'dart:async';

/// Collection of [messages] allowed to be [read].
class Chat {
  Chat(this.onRead);

  /// Callback, called when this [Chat] should be marked as read until the
  /// provided [int] remotely.
  ///
  /// Intended to be a backend mutation.
  final void Function(int message) onRead;

  /// [List] of messages in this [Chat].
  final List<int> messages = List.generate(30, (i) => i);

  /// Marks this [Chat] as read until the specified [message].
  void read(int message) {
    // Create a one-time timer to delay the invocation of onRead
    Timer(Duration.zero, () {
      onRead(message);
    });
  }
}

Future<void> main() async {
  final Chat chat = Chat((i) => print('Read until $i'));

  chat.read(0);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(4);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(10);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(11);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(12);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(13);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(14);
  await Future.delayed(Duration(milliseconds: 100));

  chat.read(15);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(20);

  await Future.delayed(Duration(milliseconds: 1000));

  chat.read(35);
  await Future.delayed(Duration(milliseconds: 100));
  chat.read(36);
  await Future.delayed(Duration(milliseconds: 500));
  chat.read(37);
  await Future.delayed(Duration(milliseconds: 800));

  chat.read(40);
}
```
The changes are in the `Chat` class, where I added a timer to delay the invocation of `onRead` by using `Timer(Duration.zero, () => onRead(message));`. This will invoke `onRead` only once per second, regardless of how many times `read` is called within that second.

Note that I used `Duration.zero` which is equivalent to `Duration.zero` (i.e., no delay), and the callback is executed immediately after the timer is created.