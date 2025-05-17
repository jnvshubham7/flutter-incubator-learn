// Implement an extension on [String], parsing links from a text.
void main() {
  // Test the extension
  String text = 'Hello, google.com, yay';
  List<dynamic> result = text.parseLinks();
  
  // Print the result
  for (var item in result) {
    print(item);
  }
}

extension LinkParser on String {
  List<dynamic> parseLinks() {
    List<dynamic> result = [];
    
    // Regular expression to match URLs
    RegExp urlRegex = RegExp(
      r'(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    
    int lastIndex = 0;
    
    // Find all matches in the string
    for (Match match in urlRegex.allMatches(this)) {
      // If there's text before the link, add it as Text
      if (match.start > lastIndex) {
        result.add(Text(this.substring(lastIndex, match.start)));
      }
      
      // Add the link
      result.add(Link(match.group(0)!));
      
      // Update the last index
      lastIndex = match.end;
    }
    
    // Add any remaining text after the last link
    if (lastIndex < this.length) {
      result.add(Text(this.substring(lastIndex)));
    }
    
    return result;
  }
}

// Simple classes to represent Text and Link
class Text {
  final String text;
  
  Text(this.text);
  
  @override
  String toString() => 'Text(\'$text\')';
}

class Link {
  final String url;
  
  Link(this.url);
  
  @override
  String toString() => 'Link(\'$url\')';
}
