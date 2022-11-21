import 'datatype.dart';

class StringType extends DataType {
  StringType({bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return StringType(nullable: nullable);
  }
}
