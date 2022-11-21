import 'datatype.dart';

class BooleanType extends DataType {
  BooleanType({bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return BooleanType(nullable: nullable);
  }
}
