import 'dart:async';
import 'dart:io';

/// A simple HTTP server that reads and writes to a dummy.txt file
class DummyFileHttpServer {
  final int port;
  final String filepath;
  HttpServer? _server;
  
  DummyFileHttpServer({
    this.port = 8080,
    this.filepath = 'dummy.txt'
  });
  
  /// Start the HTTP server
  Future<void> start() async {
    _server = await HttpServer.bind('localhost', port);
    print('Server started at http://localhost:$port');
    
    // Create the dummy file if it doesn't exist
    final file = File(filepath);
    if (!await file.exists()) {
      await file.create();
      await file.writeAsString('Initial content');
    }
    
    await for (final request in _server!) {
      _handleRequest(request);
    }
  }
  
  /// Stop the HTTP server
  Future<void> stop() async {
    await _server?.close();
    print('Server stopped');
  }
  
  /// Handle incoming HTTP requests
  Future<void> _handleRequest(HttpRequest request) async {
    print('${request.method} ${request.uri.path}');
    
    switch (request.uri.path) {
      case '/':
        await _handleRoot(request);
        break;
      case '/read':
        await _handleRead(request);
        break;
      case '/write':
        await _handleWrite(request);
        break;
      case '/append':
        await _handleAppend(request);
        break;
      default:
        request.response.statusCode = HttpStatus.notFound;
        request.response.write('Not Found');
        await request.response.close();
    }
  }
  
  /// Handle the root path request
  Future<void> _handleRoot(HttpRequest request) async {
    final response = request.response;
    response.headers.contentType = ContentType.html;
    
    response.write('''
    <!DOCTYPE html>
    <html>
    <head>
      <title>Dummy File Server</title>
    </head>
    <body>
      <h1>Dummy File Server</h1>
      <p>This server reads and writes to ${filepath}</p>
      <ul>
        <li><a href="/read">Read file</a></li>
        <li>
          <form action="/write" method="post">
            <input type="text" name="content" placeholder="Content to write">
            <button type="submit">Write to file</button>
          </form>
        </li>
        <li>
          <form action="/append" method="post">
            <input type="text" name="content" placeholder="Content to append">
            <button type="submit">Append to file</button>
          </form>
        </li>
      </ul>
    </body>
    </html>
    ''');
    
    await response.close();
  }
  
  /// Handle the read path request
  Future<void> _handleRead(HttpRequest request) async {
    final file = File(filepath);
    final response = request.response;
    
    if (await file.exists()) {
      final content = await file.readAsString();
      response.headers.contentType = ContentType.text;
      response.write(content);
    } else {
      response.statusCode = HttpStatus.notFound;
      response.write('File not found');
    }
    
    await response.close();
  }
  
  /// Handle the write path request
  Future<void> _handleWrite(HttpRequest request) async {
    if (request.method == 'POST') {
      final content = await _readRequestBody(request);
      final file = File(filepath);
      
      await file.writeAsString(content);
      
      request.response.write('File updated successfully');
    } else {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write('Method not allowed');
    }
    
    await request.response.close();
  }
  
  /// Handle the append path request
  Future<void> _handleAppend(HttpRequest request) async {
    if (request.method == 'POST') {
      final content = await _readRequestBody(request);
      final file = File(filepath);
      
      await file.writeAsString(content, mode: FileMode.append);
      
      request.response.write('Content appended successfully');
    } else {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write('Method not allowed');
    }
    
    await request.response.close();
  }
  
  /// Helper method to read the request body
  Future<String> _readRequestBody(HttpRequest request) async {
    final completer = Completer<String>();
    final content = StringBuffer();
    
    request.transform(utf8.decoder).listen(
      (data) => content.write(data),
      onDone: () => completer.complete(content.toString()),
      onError: (e) => completer.completeError(e),
      cancelOnError: true,
    );
    
    return completer.future;
  }
}

void main() async {
  final server = DummyFileHttpServer();
  await server.start();
  
  print('Press Ctrl+C to stop the server');
}
