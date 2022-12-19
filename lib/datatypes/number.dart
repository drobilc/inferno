import 'datatype.dart';

class NumberType extends DataType {
  
  NumberType({bool nullable = false}) : super(nullable);

  @override
  DataType makeNullable(bool nullable) {
    return NumberType(nullable: nullable);
  }

}

class IntegerType extends NumberType {

  IntegerType({ super.nullable });
  
  @override
  DataType makeNullable(bool nullable) {
    return IntegerType(nullable: nullable);
  }
  
}
class FloatType extends NumberType {

  FloatType({ super.nullable });

  @override
  DataType makeNullable(bool nullable) {
    return FloatType(nullable: nullable);
  }

}