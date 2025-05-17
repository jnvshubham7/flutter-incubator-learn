import 'dart:async';
import 'dart:math';

class Server {
  /// [StreamController] simulating an ongoing websocket endpoint.
  StreamController<int>? _controller;

  /// [Timer] periodically adding data to the [_controller].
  Timer? _timer;

  /// Initializes this [Server].
  Future<void> init() async {
    final Random random = Random();

    while (true) {
      _controller = StreamController<int>();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _controller?.add(timer.tick);
      });

      // Oops, a crash happened...
      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );

      // Kill the [StreamController], simulating a network loss.
      await _controller?.close();
      _controller?.addError(DisconnectedException());
      _controller = null;
      _timer?.cancel();
      _timer = null;
    }
  }

  /// Returns a [Stream] of data, if this [Server] is up and reachable, or
  /// throws [DisconnectedException] otherwise.
  Future<Stream<int>> connect() async {
    if (_controller != null) {
      return _controller!.stream;
    } else {
      throw DisconnectedException();
    }
  }
}

class DisconnectedException implements Exception {
  @override
  String toString() => 'Disconnected from server';
}

class Client {
  /// Exponential backoff parameters
  final int _initialBackoffMs = 100;
  final int _maxBackoffMs = 30000; // 30 seconds max
  final double _backoffMultiplier = 1.5;
  
  int _currentBackoffMs = 100;
  bool _connected = false;

  Future<void> connect(Server server) async {
    _currentBackoffMs = _initialBackoffMs;
    await _attemptConnect(server);
  }
  
  Future<void> _attemptConnect(Server server) async {
    while (true) {
      try {
        print('Attempting connection...');
        Stream<int> dataStream = await server.connect();
        _connected = true;
        _currentBackoffMs = _initialBackoffMs; // Reset backoff on successful connection
        
        print('Connection established! Listening for data...');
        await _listenToStream(dataStream);
      } catch (e) {
        _connected = false;
        print('Connection error: $e');
        print('Reconnecting in ${_currentBackoffMs}ms...');
        
        await Future.delayed(Duration(milliseconds: _currentBackoffMs));
        
        // Exponential backoff with jitter
        _currentBackoffMs = min(
          (_currentBackoffMs * _backoffMultiplier).toInt(), 
          _maxBackoffMs
        );
        
        // Add some jitter to prevent thundering herd problem
        final jitter = Random().nextInt(_currentBackoffMs ~/ 4);
        _currentBackoffMs = _currentBackoffMs + jitter;
      }
    }
  }
  
  Future<void> _listenToStream(Stream<int> stream) async {
    await for (final data in stream) {
      print('Received data: $data');
    }
  }
}

Future<void> main() async {
  final server = Server();
  
  // Start the server in a separate zone to not affect our main flow
  unawaited(server.init());
  
  // Connect the client
  final client = Client();
  await client.connect(server);
}
