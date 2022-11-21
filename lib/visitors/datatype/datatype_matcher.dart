import 'package:auto_json_serializable/datatypes/datatypes.dart';
import 'package:collection/collection.dart';
import 'datatype_visitor.dart';

enum Match {
  fullMatch,
  partialMatch,
  noMatch,
}

class DataTypeMatcher extends DataTypeVisitor<Match, DataType> {

  static Match match(DataType first, DataType second) {
    if (second is DynamicType || second is NullType) {
      return DataTypeMatcher().visit(second, first);
    }
    return DataTypeMatcher().visit(first, second);
  }

  @override
  Match visitBooleanType(BooleanType dataType, DataType argument) {
    if (argument is BooleanType) return Match.fullMatch;
    return Match.noMatch;
  }

  @override
  Match visitDynamicType(DynamicType dataType, DataType argument) {
    return Match.fullMatch;
  }

  @override
  Match visitNullType(NullType dataType, DataType argument) {
    return Match.fullMatch;
  }

  @override
  Match visitNumberType(NumberType dataType, DataType argument) {
    if (argument is NumberType) return Match.fullMatch;
    return Match.noMatch;
  }

  @override
  Match visitStringType(StringType dataType, DataType argument) {
    if (argument is StringType) return Match.fullMatch;
    return Match.noMatch;
  }

  @override
  Match visitArrayType(ArrayType dataType, DataType argument) {
    if (argument is! ArrayType) return Match.noMatch;
    return visit(dataType.itemType, argument.itemType);
  }

  @override
  Match visitObjectType(ObjectType dataType, DataType argument) {
    if (argument is! ObjectType) return Match.noMatch;

    final fieldNames = dataType.fieldTypes.keys.toSet();
    final otherFieldNames = argument.fieldTypes.keys.toSet();
    
    final sameFieldNames = fieldNames.intersection(otherFieldNames);
    final differentFieldNames = fieldNames.union(otherFieldNames).difference(sameFieldNames);

    // If one of the object has a key, that the other does not, this is at most
    // partial match.
    if (differentFieldNames.isNotEmpty) return Match.partialMatch;

    final fieldTypes = sameFieldNames.map((e) => dataType.fieldTypes[e]!);
    final otherFieldTypes = sameFieldNames.map((e) => argument.fieldTypes[e]!);
    final matches = IterableZip([fieldTypes, otherFieldTypes]).map((e) => visit(e[0], e[1]));

    // Two objects match fully if and only if all fields fully match.
    if (matches.every((element) => element == Match.fullMatch)) return Match.fullMatch;

    // Otherwise, we have found two objects, which gives us a partial match.
    return Match.partialMatch;
  }
}
