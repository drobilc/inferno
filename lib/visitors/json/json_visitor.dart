abstract class JsonVisitor<T, A> {
  T visitJsonObject(Map<String, dynamic> json, A argument);
  T visitJsonArray(List json, A argument);
  T visitJsonInteger(int json, A argument);
  T visitJsonString(String json, A argument);
  T visitJsonNumber(num json, A argument);
  T visitJsonBoolean(bool json, A argument);
  T visitJsonNull(dynamic json, A argument);

  T visit(dynamic json, A argument) {
    if (json is Map<String, dynamic>) {
      return visitJsonObject(json, argument);
    } else if (json is List) {
      return visitJsonArray(json, argument);
    } else if (json is int) {
      return visitJsonInteger(json, argument);
    } else if (json is String) {
      return visitJsonString(json, argument);
    } else if (json is num) {
      return visitJsonNumber(json, argument);
    } else if (json is bool) {
      return visitJsonBoolean(json, argument);
    } else if (json == null) {
      return visitJsonNull(json, argument);
    }
    throw FormatException("Invalid JSON data structure");
  }
}
