enum MergeStrategy {
  first,
  last,
  nonMatchingToDynamic,
  mergeNonMatchingObjects,
  
  // TODO: Add another merge strategy
  // generateSuperObject,
}

const defaultMergeStrategy = MergeStrategy.mergeNonMatchingObjects;

extension MergeStrategyExtension on MergeStrategy {

  String name() {
    switch (this) {
      case MergeStrategy.first: return 'first';
      case MergeStrategy.last: return 'last';
      case MergeStrategy.nonMatchingToDynamic: return 'non-matching-to-dynamic';
      case MergeStrategy.mergeNonMatchingObjects: return 'merge-non-matching-objects';
    }
  }

}

MergeStrategy mergeStrategyFromString(String name) {
  final nameMergeStrategyMap = Map.fromEntries(MergeStrategy.values.map((e) => MapEntry(e.name(), e)));
  if (!nameMergeStrategyMap.containsKey(name)) {
    throw FormatException('Unknown merge strategy name');
  }
  return nameMergeStrategyMap[name]!;
}