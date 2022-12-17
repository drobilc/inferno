import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:inferno/datatypes/object.dart';
import 'package:inferno/visitors/datatype/dart_code_generator.dart';
import 'package:inferno/visitors/json/json.dart';

import 'dart:convert';
import 'annotations.dart';

class DartObjectGenerator extends GeneratorForAnnotation<InferFromJSONFile> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final objectName = element.name;

    final jsonFilePath = annotation.read('file').stringValue;
    final jsonFileUri = Uri(path: jsonFilePath);

    final jsonAsset = AssetId.resolve(jsonFileUri, from: buildStep.inputId);
    final contents = await buildStep.readAsString(jsonAsset);

    final mergeStrategy = MergeStrategy.nonMatchingToDynamic;
    final decoded = json.decode(contents);

    final dataType = JsonToDataTypeConverter.convert(decoded);

    if (dataType is! ObjectType) {
      // TODO: Handle this exception more gracefully
      throw Exception('JSON file does not contain an object.');
    }

    final result = DartCodeGenerator.generateCodeForObject(
      dataType,
      mergeStrategy: mergeStrategy,
      className: objectName,
    );

    return result;
  }
}

Builder infernoBuilder(BuilderOptions options) =>
    PartBuilder([DartObjectGenerator()], '.inferno.dart');
