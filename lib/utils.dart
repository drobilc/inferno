import 'package:inferno/annotations.dart';
import 'package:inferno/datatypes/object.dart';
import 'package:inferno/visitors/datatype/dart_code_generator.dart';
import 'package:inferno/visitors/json/json.dart';

import 'dart:convert';

import 'package:source_gen/source_gen.dart';

String inferObjectType(
  String contents, {
  String? className,
  MergeStrategy mergeStrategy = MergeStrategy.mergeNonMatchingObjects,
}) {
  final decoded = json.decode(contents);
  final dataType = JsonToDataTypeConverter.convert(decoded);
  if (dataType is! ObjectType) {
    throw InvalidGenerationSourceError('JSON file does not contain an object.');
  }

  final result = DartCodeGenerator.generateCodeForObject(
    dataType,
    mergeStrategy: mergeStrategy,
    className: className,
  );
  return result;
}
