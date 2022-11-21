import 'datatype.dart';

class NumberType extends DataType {
  NumberType({bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return NumberType(nullable: nullable);
  }

}