import 'package:auto_json_serializable/datatypes/datatypes.dart';
import 'datatype_visitor.dart';

class DartCodeGenerator extends DataTypeVisitor<String, List<String>> {

  int _numberOfGeneratedObjects = 0;

  String _generateObjectName() {
    _numberOfGeneratedObjects++;
    return 'Object$_numberOfGeneratedObjects';
  }

  static String generateCode(DataType dataType) {
    final List<String> generatedObjects = [];
    DartCodeGenerator().visit(dataType, generatedObjects);
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
    return _nullableWrap("List<${visit(dataType.itemType, argument)}>", dataType);
  }

  @override
  String visitObjectType(ObjectType dataType, List<String> argument) {
    
    final fieldTypes = dataType.fieldTypes.map((key, value) => MapEntry(key, visit(value, argument)),);
    final fieldTypesObjectSignature = fieldTypes.entries.map((entry) => '\tfinal ${entry.value} ${entry.key};').join('\n');

    final fieldTypesConstructorSignature = fieldTypes.entries.map((entry) {
      final isNullable = dataType.fieldTypes[entry.key]!.nullable;
      final nullablePrefix = isNullable ? '' : 'required ';
      return '${nullablePrefix}this.${entry.key}';
    }).join(',\n\t\t');

    String objectName = _generateObjectName();

    String result = "class $objectName {\n\n";
    result += '$fieldTypesObjectSignature\n';
    result += "\t$objectName({\n\t\t$fieldTypesConstructorSignature\n\t});";
    result += "\n\n}";
    argument.add(result);

    return objectName;
  }

}
