class InferFromJSONFile {
  final String file;
  final MergeStrategy mergeStrategy;
  const InferFromJSONFile({
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