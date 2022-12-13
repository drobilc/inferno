import 'package:auto_json_serializable/datatypes/datatypes.dart';
import 'package:auto_json_serializable/visitors/json/json.dart';
import 'package:auto_json_serializable/visitors/datatype/datatype_merger.dart';
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

  static String generateCode(
    DataType dataType, {
    MergeStrategy mergeStrategy = MergeStrategy.first,
  }) {
    final List<String> generatedObjects = [];
    DartCodeGenerator(mergeStrategy).visit(dataType, generatedObjects);
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
  String visitNumberType(NumberType dataType, List<String> argument) {
    return _nullableWrap("num", dataType);
  }

  @override
  String visitStringType(StringType dataType, List<String> argument) {
    return _nullableWrap("String", dataType);
  }

  @override
  String visitArrayType(ArrayType dataType, List<String> argument) {
    final arrayType = dataType.itemTypes.reduce(
      (value, element) => DataTypeMerger.merge(mergeStrategy, value, element),
    );
    return _nullableWrap("List<${visit(arrayType, argument)}>", dataType);
  }

  @override
  String visitObjectType(ObjectType dataType, List<String> argument) {
    final fieldTypes = dataType.fieldTypes.map(
      (key, value) => MapEntry(key, visit(value, argument)),
    );

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
    }).join(',\n\t\t');

    String objectName = _generateObjectName();
    String fileName = objectName.toLowerCase();

    String result = [
      "import 'package:json_annotation/json_annotation.dart';\n",
      "part '$fileName.g.dart';\n",
      "@JsonSerializable()",
      "class $objectName {\n",
      fieldTypesObjectSignature,
      "\t$objectName({\n\t\t$fieldTypesConstructorSignature\n\t});\n",
      "\tfactory $objectName.fromJson(Map<String, dynamic> json) => _\$${objectName}FromJson(json);",
      "\tMap<String, dynamic> toJson() => _\$${objectName}ToJson(this);\n"
          "\n}"
    ].join("\n");
    argument.add(result);

    return objectName;
  }
}
