import 'datatype.dart';
import 'datatypes.dart';

class ObjectType extends DataType {
  final Map<String, DataType> fieldTypes;
  const ObjectType(this.fieldTypes, {bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return ObjectType(Map.from(fieldTypes), nullable: nullable);
  }
}
