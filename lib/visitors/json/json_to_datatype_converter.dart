import 'package:auto_json_serializable/datatypes/datatypes.dart';
import 'datatype_merger.dart';
import 'json_visitor.dart';
import 'merge_strategy.dart';

class JsonToDataTypeConverter extends JsonVisitor<DataType, Object?> {
  final MergeStrategy mergeStrategy;
  JsonToDataTypeConverter(this.mergeStrategy);

  static DataType convert(dynamic json, MergeStrategy mergeStrategy) {
    return JsonToDataTypeConverter(mergeStrategy).visit(json, null);
  }

  @override
  DataType visitJsonBoolean(bool json, Object? argument) {
    return BooleanType();
  }

  @override
  DataType visitJsonInteger(int json, Object? argument) {
    return NumberType();
  }

  @override
  DataType visitJsonNull(json, Object? argument) {
    return NullType();
  }

  @override
  DataType visitJsonNumber(num json, Object? argument) {
    return NumberType();
  }

  @override
  DataType visitJsonString(String json, Object? argument) {
    return StringType();
  }

  @override
  DataType visitJsonArray(List json, Object? argument) {
    final itemTypes = json.map((e) => visit(e, argument));
    final arrayType = itemTypes.reduce(
      (value, element) => DataTypeMerger.merge(mergeStrategy, value, element),
    );
    return ArrayType(arrayType);
  }

  @override
  DataType visitJsonObject(Map<String, dynamic> json, Object? argument) {
    final fields = json.map(
      (key, value) => MapEntry(key, visit(value, argument)),
    );
    return ObjectType(fields);
  }
}
