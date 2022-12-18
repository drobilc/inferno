// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// DartObjectGenerator
// **************************************************************************

@JsonSerializable()
class InferredPersonalItems {
  final String name;
  final num? price;
  InferredPersonalItems({required this.name, this.price});

  factory InferredPersonalItems.fromJson(Map<String, dynamic> json) =>
      _$InferredPersonalItemsFromJson(json);
  Map<String, dynamic> toJson() => _$InferredPersonalItemsToJson(this);
}

@JsonSerializable()
class InferredPerson {
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "personal_items")
  final List<InferredPersonalItems> personalItems;
  InferredPerson(
      {required this.firstName,
      required this.lastName,
      required this.personalItems});

  factory InferredPerson.fromJson(Map<String, dynamic> json) =>
      _$InferredPersonFromJson(json);
  Map<String, dynamic> toJson() => _$InferredPersonToJson(this);
}

@JsonSerializable()
class InferredItem {
  final List<List<bool>> values;
  InferredItem({required this.values});

  factory InferredItem.fromJson(Map<String, dynamic> json) =>
      _$InferredItemFromJson(json);
  Map<String, dynamic> toJson() => _$InferredItemToJson(this);
}
