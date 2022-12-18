import 'package:build/build.dart';
import 'package:inferno/utils.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'annotations.dart';

class DartObjectGenerator extends GeneratorForAnnotation<InferFromJsonFile> {
  static const defaultMergeStrategy = MergeStrategy.mergeNonMatchingObjects;

  MergeStrategy getMergeStrategy(ConstantReader annotation) {
    try {
      final annotationValue = annotation.read('mergeStrategy');
      if (annotationValue.isNull) return defaultMergeStrategy;
      final objectValue = annotationValue.objectValue;
      if (objectValue.isNull) return defaultMergeStrategy;
      final mergeStrategyId = objectValue.getField('index');
      if (mergeStrategyId == null || mergeStrategyId.isNull) {
        return defaultMergeStrategy;
      }

      final mergeStrategyIndex =
          mergeStrategyId.toIntValue() ?? defaultMergeStrategy.index;

      return MergeStrategy.values.firstWhere(
        (element) => element.index == mergeStrategyIndex,
        orElse: () => defaultMergeStrategy,
      );
    } on Exception {
      return defaultMergeStrategy;
    }
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // Check if [@InferFromJsonFile] annotation is used on type alias element.
    // If not, throw an exception.
    if (element is! TypeAliasElement) {
      throw InvalidGenerationSourceError(
        '`@InferFromJsonFile` can only be used on type aliases.',
        element: element,
      );
    }

    // The type aliasing is performed using `typedef <TypeName> = <dynamic>;`.
    // Get the [TypeName] and use it as a generated class name - e.g.
    // `Inferred<TypeName>`.
    final className = element.name;

    // Read the [file] and [mergeStrategy] fields from annotation.
    late String jsonFilePath;
    try {
      jsonFilePath = annotation.read('file').stringValue;
    } on FormatException {
      throw InvalidGenerationSourceError(
        '`@InferFromJsonFile` path should not be null.',
        element: element,
      );
    }
    final mergeStrategy = getMergeStrategy(annotation);

    // Use [file] path to get [AssetId] object so we can read it using the
    // [BuildStep] object. The [file] path should be relative to current
    // file package.
    final jsonFileUri = Uri(path: jsonFilePath);
    final jsonAsset = AssetId.resolve(jsonFileUri, from: buildStep.inputId);

    // Read JSON file.
    final contents = await buildStep.readAsString(jsonAsset);

    // Infer object types and return generated Dart code.
    final result = inferObjectType(
      contents,
      className: className,
      mergeStrategy: mergeStrategy,
    );

    return result;
  }
}

Builder infernoBuilder(BuilderOptions options) =>
    PartBuilder([DartObjectGenerator()], '.inferno.dart');
