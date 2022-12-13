import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:auto_json_serializable/visitors/datatype/dart_code_generator.dart';
import 'package:auto_json_serializable/visitors/json/json.dart';

import 'input.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addOption(
    'merge-strategy',
    abbr: 'm',
    allowed: MergeStrategy.values.map((e) => e.name()),
    defaultsTo: defaultMergeStrategy.name(),
  );

  final argumentResults = parser.parse(arguments);
  final mergeStrategy =
      mergeStrategyFromString(argumentResults['merge-strategy']);

  final input = readInputSync();
  final decoded = json.decode(input);

  final dataType = JsonToDataTypeConverter.convert(decoded);
  final result = DartCodeGenerator.generateCode(
    dataType,
    mergeStrategy: mergeStrategy,
  );
  stdout.write(result);
}
