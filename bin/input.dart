import 'dart:convert';
import 'dart:io';

String readInputSync({Encoding encoding = utf8, bool retainNewlines = false}) {
  var input = "";
  String? currentLine;
  while ((currentLine = stdin.readLineSync(
          encoding: encoding, retainNewlines: retainNewlines)) !=
      null) {
    input += currentLine!;
  }
  return input;
}