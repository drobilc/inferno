import 'package:inferno/annotations.dart';
import 'package:inferno/datatypes/datatypes.dart';
import 'package:inferno/visitors/datatype/datatype_merger.dart';
import 'datatype_visitor.dart';
import 'field_renamer.dart';

class DartCodeGenerator extends DataTypeVisitor<String, List<String>> {
  final MergeStrategy mergeStrategy;
  int _numberOfGeneratedObjects = 0;

  DartCodeGenerator(this.mergeStrategy);

  String _generateObjectName() {
    _numberOfGeneratedObjects++;
    return 'Object$_numberOfGeneratedObjects';
  }

  static String generateCodeForObject(
    ObjectType dataType, {
    MergeStrategy mergeStrategy = MergeStrategy.first,
    String? className,
  }) {
    final List<String> generatedObjects = [];
    DartCodeGenerator(mergeStrategy).visitObjectType(
      dataType,
      generatedObjects,
      definedClassName: className,
    );
    return generatedObjects.join('\n\n');
  }

  String _nullableWrap(String str, DataType dataType) {
    return dataType.nullable ? '$str?' : str;
  }

  @override
  String visitBooleanType(BooleanType dataType, List<String> argument) {
    return _nullableWrap("bool", dataType);
  }

  @override
  String visitDynamicType(DynamicType dataType, List<String> argument) {
    return _nullableWrap("dynamic", dataType);
  }

  @override
  String visitNullType(NullType dataType, List<String> argument) {
    return _nullableWrap("dynamic", dataType);
  }

  @override
  String visitIntegerType(IntegerType dataType, List<String> argument) {
    return _nullableWrap("int", dataType);
  }

  @override
  String visitFloatType(FloatType dataType, List<String> argument) {
    return _nullableWrap("double", dataType);
  }

  @override
  String visitNumberType(NumberType dataType, List<String> argument) {
    return _nullableWrap("num", dataType);
  }

  @override
  String visitStringType(StringType dataType, List<String> argument) {
    return _nullableWrap("String", dataType);
  }

  @override
  String visitArrayType(
    ArrayType dataType,
    List<String> argument, {
    String? definedClassName,
  }) {
    final arrayType = dataType.itemTypes.reduce(
      (value, element) => DataTypeMerger.merge(mergeStrategy, value, element),
    );

    final arrayItemType = arrayType is ObjectType
        ? visitObjectType(arrayType, argument,
            definedClassName: definedClassName)
        : visit(arrayType, argument);
    return _nullableWrap("List<$arrayItemType>", dataType);
  }

  @override
  String visitObjectType(
    ObjectType dataType,
    List<String> argument, {
    String? definedClassName,
  }) {
    final fieldTypes = dataType.fieldTypes.map((key, value) {
      if (value is ObjectType) {
        // Special handling for `"key": { ... }` types. Use key as new object
        // name, so that it is easier to read generated classes.
        final generatedClassName = visitObjectType(value, argument,
            definedClassName: FieldRenamer.toPascalCase(key));
        return MapEntry(key, generatedClassName);
      } else if (value is ArrayType) {
        // Special handling for `"key": [ ... ]` types. Use key as new object
        // name, so that it is easier to read generated classes.
        final generatedClassName = visitArrayType(value, argument,
            definedClassName: FieldRenamer.toPascalCase(key));
        return MapEntry(key, generatedClassName);
      }
      return MapEntry(key, visit(value, argument));
    });

    // Convert all field names to camel case. Create a mapping between original
    // field name and the tranformed camel case string.
    final Map<String, String> fieldNames = Map.fromEntries(fieldTypes.keys.map(
      (name) => MapEntry(
        name,
        FieldRenamer.toCamelCase(name),
      ),
    ));

    // Generate object fields. Use camel case field names. If the camel case
    // name is different than the original field name, add `@JsonKey(name: ...)`
    // annotation.
    final fieldTypesObjectSignature = fieldTypes.entries.map((entry) {
      final camelCaseName = fieldNames[entry.key] ?? entry.key;

      // The camel case name is the same as the field name. This means that
      // there is no need to add a @JsonKey annotation.
      if (camelCaseName == entry.key) {
        return '\tfinal ${entry.value} ${entry.key};';
      } else {
        return [
          '\t@JsonKey(name: "${entry.key}")',
          '\tfinal ${entry.value} $camelCaseName;'
        ].join('\n');
      }
    }).join('\n');

    final fieldTypesConstructorSignature = fieldTypes.entries.map((entry) {
      final isNullable = dataType.fieldTypes[entry.key]!.nullable;
      final nullablePrefix = isNullable ? '' : 'required ';
      final camelCaseName = fieldNames[entry.key] ?? entry.key;
      return '${nullablePrefix}this.$camelCaseName';
    }).map((e) => '$e,\n\t\t',).join();

    final className = definedClassName ?? _generateObjectName();
    final inferredClassName = 'Inferred$className';

    String result = [
      "@JsonSerializable()",
      "class $inferredClassName {\n",
      fieldTypesObjectSignature,
      "\t$inferredClassName({\n\t\t$fieldTypesConstructorSignature\n\t});\n",
      "\tfactory $inferredClassName.fromJson(Map<String, dynamic> json) => _\$${inferredClassName}FromJson(json);",
      "\tMap<String, dynamic> toJson() => _\$${inferredClassName}ToJson(this);\n"
          "\n}"
    ].join("\n");
    argument.add(result);

    return inferredClassName;
  }
}
