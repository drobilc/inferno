import 'package:inferno/datatypes/datatypes.dart';

abstract class DataTypeVisitor<T, A> {

  T visitStringType(StringType dataType, A argument);
  T visitObjectType(ObjectType dataType, A argument);
  T visitNumberType(NumberType dataType, A argument);
  T visitNullType(NullType dataType, A argument);
  T visitDynamicType(DynamicType dataType, A argument);
  T visitBooleanType(BooleanType dataType, A argument);
  T visitArrayType(ArrayType dataType, A argument);

  T visit(DataType dataType, A argument) {
    if (dataType is StringType) {
      return visitStringType(dataType, argument);
    } else if (dataType is ObjectType) {
      return visitObjectType(dataType, argument);
    } else if (dataType is NumberType) {
      return visitNumberType(dataType, argument);
    } else if (dataType is NullType) {
      return visitNullType(dataType, argument);
    } else if (dataType is DynamicType) {
      return visitDynamicType(dataType, argument);
    } else if (dataType is BooleanType) {
      return visitBooleanType(dataType, argument);
    } else if (dataType is ArrayType) {
      return visitArrayType(dataType, argument);
    }
    throw FormatException("Uknown data type");
  }
}