// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InferredPerson _$InferredPersonFromJson(Map<String, dynamic> json) =>
    InferredPerson(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      personalItems: json['personal_items'] as List<dynamic>,
    );

Map<String, dynamic> _$InferredPersonToJson(InferredPerson instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'personal_items': instance.personalItems,
    };

InferredItem _$InferredItemFromJson(Map<String, dynamic> json) => InferredItem(
      values: (json['values'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as bool).toList())
          .toList(),
    );

Map<String, dynamic> _$InferredItemToJson(InferredItem instance) =>
    <String, dynamic>{
      'values': instance.values,
    };