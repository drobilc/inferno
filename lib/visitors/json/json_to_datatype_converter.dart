import 'package:inferno/datatypes/datatypes.dart';
import 'json_visitor.dart';

class JsonToDataTypeConverter extends JsonVisitor<DataType, Object?> {
  static DataType convert(dynamic json) {
    return JsonToDataTypeConverter().visit(json, null);
  }

  @override
  DataType visitJsonBoolean(bool json, Object? argument) {
    return BooleanType();
  }

  @override
  DataType visitJsonInteger(int json, Object? argument) {
    return IntegerType();
  }

  @override
  DataType visitJsonNull(json, Object? argument) {
    return NullType();
  }

  @override
  DataType visitJsonNumber(num json, Object? argument) {
    return FloatType();
  }

  @override
  DataType visitJsonString(String json, Object? argument) {
    return StringType();
  }

  @override
  DataType visitJsonArray(List json, Object? argument) {
    final itemTypes =
        json.map((e) => visit(e, argument)).toList(growable: false);
    return ArrayType(itemTypes);
  }

  @override
  DataType visitJsonObject(Map<String, dynamic> json, Object? argument) {
    final fields = json.map(
      (key, value) => MapEntry(key, visit(value, argument)),
    );
    return ObjectType(fields);
  }
}
