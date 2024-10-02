/// Item in a chat.
abstract class ChatItem {}

/// [ChatItem] representing a text message.
class ChatMessage extends ChatItem {}

/// [ChatItem] representing a call.
class ChatCall extends ChatItem {}

/// [ChatItem] representing an action happened in a chat.
class ChatInfo extends ChatItem {}

/// [ChatItem] representing a forwarded message.
class ChatForward extends ChatItem {}

/// Quote of a [ChatItem].
abstract class ChatItemQuote {
  const ChatItemQuote({
    required this.original,
    required this.at,
  });

  /// Constructs a [ChatItemQuote] from the provided [item].
  factory ChatItemQuote.from(ChatItem item) {
    throw UnimplementedError('Implement me');
  }

  /// Quoted [ChatItem] itself.
  final ChatItem original;

  /// [DateTime] when this [ChatItemQuote] was created.
  final DateTime at;
}

/// [ChatItemQuote] of a [ChatMessage].
class ChatMessageQuote extends ChatItemQuote {
  const ChatMessageQuote({required super.original, required super.at});
}

/// [ChatItemQuote] of a [ChatCall].
class ChatCallQuote extends ChatItemQuote {
  const ChatCallQuote({required super.original, required super.at});
}

/// [ChatItemQuote] of a [ChatInfo].
class ChatInfoQuote extends ChatItemQuote {
  const ChatInfoQuote({required super.original, required super.at});
}

/// [ChatItemQuote] of a [ChatForward].
class ChatForwardQuote extends ChatItemQuote {
  const ChatForwardQuote({required super.original, required super.at});
}


Here is the full code:

```dart
// Item in a chat.
abstract class ChatItem {}

// [ChatItem] representing a text message.
class ChatMessage extends ChatItem {
  final String text;
  final DateTime? at;

  ChatMessage({required this.text, this.at});
}

// [ChatItem] representing a call.
class ChatCall extends ChatItem {
  final String callId;
  final DateTime? at;

  ChatCall({required this.callId, this.at});
}

// [ChatItem] representing an action happened in a chat.
class ChatInfo extends ChatItem {
  final String info;
  final DateTime? at;

  ChatInfo({required this.info, this.at});
}

// [ChatItem] representing a forwarded message.
class ChatForward extends ChatItem {
  final ChatMessage original;
  final DateTime? at;

  ChatForward({required this.original, this.at});
}

// Quote of a [ChatItem].
abstract class ChatItemQuote {
  const ChatItemQuote({
    required this.original,
    required this.at,
  });

  factory ChatItemQuote.from(ChatItem item) {
    throw UnimplementedError('Implement me');
  }

  // Quoted [ChatItem] itself.
  final ChatItem original;

  // [DateTime] when this [ChatItemQuote] was created.
  final DateTime at;
}

// [ChatItemQuote] of a [ChatMessage].
class ChatMessageQuote extends ChatItemQuote {
  const ChatMessageQuote({required super.original, required super.at});
}

// [ChatItemQuote] of a [ChatCall].
class ChatCallQuote extends ChatItemQuote {
  const ChatCallQuote({required super.original, required super.at});
}

// [ChatItemQuote] of a [ChatInfo].
class ChatInfoQuote extends ChatItemQuote {
  const ChatInfoQuote({required super.original, required super.at});
}

// [ChatItemQuote] of a [ChatForward].
class ChatForwardQuote extends ChatItemQuote {
  const ChatForwardQuote({required super.original, required super.at});
}
```

Please note that `ChatMessageQuote`, `ChatCallQuote`, `ChatInfoQuote`, and `ChatForwardQuote` classes now have corresponding classes for `ChatMessage`, `ChatCall`, `ChatInfo`, and `ChatForward` respectively.