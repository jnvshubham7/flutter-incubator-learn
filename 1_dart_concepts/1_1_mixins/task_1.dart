void main() {
  // Implement an extension on [DateTime], returning a [String] in format of
  // `YYYY.MM.DD hh:mm:ss` (e.g. `2023.01.01 00:00:00`).

  String? formattedDate = DateTime.now().format();
  print(formattedDate);
}

extension DateTimeFormatter on DateTime {
  String format()
  {
    String year = this.year.toString();
    String month = this.month.toString().padLeft(2, '0');
    String day = this.day.toString().padLeft(2, '0');
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String second = this.second.toString().padLeft(2, '0');

    return '$year.$month.$day $hour:$minute:$second';
  }
}