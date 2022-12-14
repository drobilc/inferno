import 'package:inferno/annotations.dart';
import 'package:inferno/datatypes/datatypes.dart';
import 'package:inferno/visitors/datatype/datatype_matcher.dart';

class DataTypeMerger {
  static DataType mergeFirst(DataType first, DataType second) {
    return first;
  }

  static bool sameNumericType(DataType first, DataType second) {
    if (first is IntegerType && second is IntegerType) return true;
    if (first is FloatType && second is FloatType) return true;
    return false;
  }

  static DataType mergeNonMatchingToDynamic(DataType first, DataType second) {
    // If both data types are numeric, but don't match exactly (eg. one is a
    // float and the other is a int), then the field should have a `num` data
    // type.
    if (first is NumberType &&
        second is NumberType &&
        !sameNumericType(first, second)) {
      return NumberType(nullable: first.nullable || second.nullable);
    }

    // If the types don't match, perform no inference any simply return the
    // dynamic type.
    if (DataTypeMatcher.match(first, second) != Match.fullMatch) {
      return DynamicType();
    }
    return first;
  }

  static DataType mergeNonMatchingObjects(DataType first, DataType second) {
    // If both the first and the second data type are objects, create a new
    // object with all fields from both objects. The fields that appear in one,
    // but not in the other object, should be nullable in our generated object.
    if (first is ObjectType && second is NullType) {
      return first;
    } else if (first is NullType && second is ObjectType) {
      return second;
    } else if (first is NumberType &&
        second is NumberType &&
        !sameNumericType(first, second)) {
      // If both data types are numeric, but don't match exactly (eg. one is a
      // float and the other is a int), then the field should have a `num` data
      // type.
      return NumberType(nullable: first.nullable || second.nullable);
    } else if (first is ObjectType && second is ObjectType) {
      final firstFieldNames = first.fieldTypes.keys.toSet();
      final secondFieldNames = second.fieldTypes.keys.toSet();

      final sameFieldNames = firstFieldNames.intersection(secondFieldNames);
      final sameFields =
          sameFieldNames.map((name) => MapEntry(name, first.fieldTypes[name]!));

      final onlyInFirstNames = firstFieldNames.difference(sameFieldNames);
      final onlyInFirst = onlyInFirstNames
          .map((name) => MapEntry(name, first.fieldTypes[name]!));

      final onlyInSecondNames = secondFieldNames.difference(sameFieldNames);
      final onlyInSecond = onlyInSecondNames
          .map((name) => MapEntry(name, second.fieldTypes[name]!));

      final allFields = [
        ...sameFields,
        ...onlyInFirst.map((e) => MapEntry(e.key, e.value.makeNullable(true))),
        ...onlyInSecond.map((e) => MapEntry(e.key, e.value.makeNullable(true))),
      ];

      return ObjectType(Map.fromEntries(allFields));
    } else if (DataTypeMatcher.match(first, second) == Match.fullMatch) {
      return first;
    }

    return DynamicType();
  }

  static DataType mergeGenerateSuperObject(DataType first, DataType second) {
    // If both the first and the second data type are objects, create a new
    // super object Super, that both objects extend (first extends Super) and
    // (second extends Super).
    return first;
  }

  static DataType merge(
    MergeStrategy strategy,
    DataType first,
    DataType second,
  ) {
    switch (strategy) {
      case MergeStrategy.first:
        return DataTypeMerger.mergeFirst(first, second);
      case MergeStrategy.last:
        return DataTypeMerger.mergeFirst(second, first);
      case MergeStrategy.nonMatchingToDynamic:
        return DataTypeMerger.mergeNonMatchingToDynamic(first, second);
      case MergeStrategy.mergeNonMatchingObjects:
        return DataTypeMerger.mergeNonMatchingObjects(first, second);
      //case MergeStrategy.generateSuperObject:
      //  return DataTypeMerger.mergeGenerateSuperObject(first, second);
    }
  }
}
