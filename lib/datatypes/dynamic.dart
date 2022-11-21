import 'datatype.dart';

class DynamicType extends DataType {
  DynamicType() : super(false);

  @override
  DataType makeNullable(bool nullable) {
    return DynamicType();
  }
}
