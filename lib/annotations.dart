
class InferFromJsonFile {
  /// Relative path to file from which the `json_serializable` compatible class
  /// should be inferred.
  final String file;

  /// Which strategy should the inference engine use when JSON array contains
  /// multiple objects of different types.
  ///
  /// Defaults to [MergeStrategy.mergeNonMatchingObjects].
  ///
  /// See [MergeStrategy] for more information about how the inference engine
  /// combines different types into one type.
  final MergeStrategy mergeStrategy;

  // Creates a new [InferFromJSONFile] instance.
  const InferFromJsonFile({
    required this.file,
    this.mergeStrategy = MergeStrategy.mergeNonMatchingObjects,
  });
}

enum MergeStrategy {
  first,
  last,
  nonMatchingToDynamic,
  mergeNonMatchingObjects,
}
