/// Item in a chat.
abstract class ChatItem {
  /// Creates a quote of this chat item.
  ChatItemQuote createQuote() {
    final now = DateTime.now();
    return ChatItemQuoteFactory.createFromItem(this, now);
  }
}

/// [ChatItem] representing a text message.
class ChatMessage extends ChatItem {
  /// Creates a new [ChatMessage] with the given [text].
  ChatMessage({required this.text});
  
  /// The text content of this message.
  final String text;
}

/// [ChatItem] representing a call.
class ChatCall extends ChatItem {
  /// Creates a new [ChatCall] with the given [duration].
  ChatCall({required this.duration});
  
  /// The duration of this call in seconds.
  final int duration;
}

/// [ChatItem] representing an action happened in a chat.
class ChatInfo extends ChatItem {
  /// Creates a new [ChatInfo] with the given [action].
  ChatInfo({required this.action});
  
  /// The action that occurred in the chat.
  final String action;
}

/// [ChatItem] representing a forwarded message.
class ChatForward extends ChatItem {
  /// Creates a new [ChatForward] with the given [original] message.
  ChatForward({required this.original});
  
  /// The original message that was forwarded.
  final ChatMessage original;
}

/// Quote of a [ChatItem].
abstract class ChatItemQuote {
  /// Creates a new [ChatItemQuote] with the given [original] item and [at] timestamp.
  const ChatItemQuote({required this.original, required this.at});
  
  /// The original item that was quoted.
  final ChatItem original;
  
  /// The timestamp when this quote was created.
  final DateTime at;
}

/// [ChatItemQuote] of a [ChatMessage].
class ChatMessageQuote extends ChatItemQuote {
  /// Creates a new [ChatMessageQuote] with the given [original] message and [at] timestamp.
  const ChatMessageQuote({
    required ChatMessage super.original, 
    required super.at,
  });
  
  /// The original message that was quoted.
  @override
  ChatMessage get original => super.original as ChatMessage;
}

/// [ChatItemQuote] of a [ChatCall].
class ChatCallQuote extends ChatItemQuote {
  /// Creates a new [ChatCallQuote] with the given [original] call and [at] timestamp.
  const ChatCallQuote({
    required ChatCall super.original, 
    required super.at,
  });
  
  /// The original call that was quoted.
  @override
  ChatCall get original => super.original as ChatCall;
}

/// [ChatItemQuote] of a [ChatInfo].
class ChatInfoQuote extends ChatItemQuote {
  /// Creates a new [ChatInfoQuote] with the given [original] info and [at] timestamp.
  const ChatInfoQuote({
    required ChatInfo super.original, 
    required super.at,
  });
  
  /// The original info that was quoted.
  @override
  ChatInfo get original => super.original as ChatInfo;
}

/// [ChatItemQuote] of a [ChatForward].
class ChatForwardQuote extends ChatItemQuote {
  /// Creates a new [ChatForwardQuote] with the given [original] forward and [at] timestamp.
  const ChatForwardQuote({
    required ChatForward super.original, 
    required super.at,
  });
  
  /// The original forward that was quoted.
  @override
  ChatForward get original => super.original as ChatForward;
}

/// Factory for creating [ChatItemQuote] instances based on [ChatItem] type.
class ChatItemQuoteFactory {
  /// Creates a [ChatItemQuote] based on the type of [item].
  static ChatItemQuote createFromItem(ChatItem item, DateTime timestamp) {
    if (item is ChatMessage) {
      return ChatMessageQuote(original: item, at: timestamp);
    } else if (item is ChatCall) {
      return ChatCallQuote(original: item, at: timestamp);
    } else if (item is ChatInfo) {
      return ChatInfoQuote(original: item, at: timestamp);
    } else if (item is ChatForward) {
      return ChatForwardQuote(original: item, at: timestamp);
    } else {
      throw ArgumentError('Unknown ChatItem type: ${item.runtimeType}');
    }
  }
}

void main() {
  // Create different types of ChatItems
  final message = ChatMessage(text: 'Hello, how are you?');
  final call = ChatCall(duration: 120); // 2 minute call
  final info = ChatInfo(action: 'User joined the chat');
  final forward = ChatForward(original: ChatMessage(text: 'This is a forwarded message'));
  
  // Create quotes using the factory
  final messageQuote = message.createQuote();
  final callQuote = call.createQuote();
  final infoQuote = info.createQuote();
  final forwardQuote = forward.createQuote();
  
  // Print information about the quotes
  print('Message Quote: ${(messageQuote as ChatMessageQuote).original.text}, created at: ${messageQuote.at}');
  print('Call Quote: ${(callQuote as ChatCallQuote).original.duration} seconds, created at: ${callQuote.at}');
  print('Info Quote: ${(infoQuote as ChatInfoQuote).original.action}, created at: ${infoQuote.at}');
  print('Forward Quote: ${(forwardQuote as ChatForwardQuote).original.original.text}, created at: ${forwardQuote.at}');
}
