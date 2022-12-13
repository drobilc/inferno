class FieldRenamer {
  static String _capitalize(String? input) {
    if (input == null || input.isEmpty) return '';
    return input.substring(0, 1).toUpperCase() +
        input.substring(1).toLowerCase();
  }

  static bool isCamelCase(String input) =>
      input.contains(RegExp(r'^[a-z][a-zA-Z0-9]+$'));

  static bool isPascalCase(String input) =>
      input.contains(RegExp(r'^[A-Z][a-zA-Z0-9]+$'));

  static bool isValidFieldName(String input) =>
      input.contains(RegExp(r'^[a-zA-Z0-9_]+$'));

  static String toPascalCase(String input) {
    // If the string is already in Pascal case, do nothing.
    if (isPascalCase(input)) return input;
    // Remove all characters that are not a letter or a number.
    final parts = input.split(RegExp(r'[^a-z0-9]+', caseSensitive: false));
    return parts.map((part) => _capitalize(part)).join();
  }

  static String toCamelCase(String input) {
    // If the string is already in camel case, do nothing.
    if (isCamelCase(input)) return input;
    // Otherwise, convert the string to pascal case and make the first letter
    // lowercase.
    final pascalCase = toPascalCase(input);
    if (pascalCase.isEmpty) return pascalCase;
    return pascalCase.substring(0, 1).toLowerCase() + pascalCase.substring(1);
  }
}
