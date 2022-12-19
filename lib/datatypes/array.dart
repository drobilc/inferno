import 'datatype.dart';

class ArrayType extends DataType {
  final List<DataType> itemTypes;

  ArrayType(this.itemTypes, {bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return ArrayType(itemTypes, nullable: nullable);
  }
}
