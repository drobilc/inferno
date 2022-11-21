import 'datatype.dart';

class ArrayType extends DataType {
  final DataType itemType;

  ArrayType(this.itemType, {bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return ArrayType(itemType, nullable: nullable);
  }
}
