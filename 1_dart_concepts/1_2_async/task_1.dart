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

  /// The timestamp of the last onRead call.
  DateTime? _lastReadTime;
  
  /// The message that will be sent after the cooldown.
  int? _pendingMessage;
  
  /// Timer for throttling onRead calls.
  Timer? _timer;

  /// Marks this [Chat] as read until the specified [message].
  void read(int message) {
    // Store the latest message to be sent
    _pendingMessage = message;
    
    // If a timer is already running, we'll wait for it to complete
    if (_timer?.isActive ?? false) {
      return;
    }
    
    final now = DateTime.now();
    
    // If we called onRead less than 1 second ago, schedule a timer
    if (_lastReadTime != null && 
        now.difference(_lastReadTime!).inMilliseconds < 1000) {
      // Calculate remaining time until we can call onRead again
      final delay = 1000 - now.difference(_lastReadTime!).inMilliseconds;
      
      _timer = Timer(Duration(milliseconds: delay), () {
        if (_pendingMessage != null) {
          onRead(_pendingMessage!);
          _lastReadTime = DateTime.now();
          _pendingMessage = null;
        }
      });
    } else {
      // We can call onRead immediately
      onRead(message);
      _lastReadTime = now;
      _pendingMessage = null;
    }
  }
}

import 'dart:async';

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
