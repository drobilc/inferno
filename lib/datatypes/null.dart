import 'datatype.dart';

class NullType extends DataType {
  NullType() : super(true);

  @override
  DataType makeNullable(bool nullable) {
    return NullType();
  }
}
