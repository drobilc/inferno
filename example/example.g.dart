// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InferredExample01 _$InferredExample01FromJson(Map<String, dynamic> json) =>
    InferredExample01(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      age: json['age'] as num,
    );

Map<String, dynamic> _$InferredExample01ToJson(InferredExample01 instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'age': instance.age,
    };

InferredLocation _$InferredLocationFromJson(Map<String, dynamic> json) =>
    InferredLocation(
      city: json['city'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$InferredLocationToJson(InferredLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
    };

InferredExample02 _$InferredExample02FromJson(Map<String, dynamic> json) =>
    InferredExample02(
      name: json['name'] as String,
      location:
          InferredLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InferredExample02ToJson(InferredExample02 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
    };

InferredExample03 _$InferredExample03FromJson(Map<String, dynamic> json) =>
    InferredExample03(
      names: (json['names'] as List<dynamic>).map((e) => e as String).toList(),
      ages: (json['ages'] as List<dynamic>).map((e) => e as num).toList(),
      canDrive:
          (json['can_drive'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$InferredExample03ToJson(InferredExample03 instance) =>
    <String, dynamic>{
      'names': instance.names,
      'ages': instance.ages,
      'can_drive': instance.canDrive,
    };

InferredPoints _$InferredPointsFromJson(Map<String, dynamic> json) =>
    InferredPoints(
      x: json['x'] as num,
      y: json['y'] as num,
    );

Map<String, dynamic> _$InferredPointsToJson(InferredPoints instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

InferredExample04 _$InferredExample04FromJson(Map<String, dynamic> json) =>
    InferredExample04(
      points: (json['points'] as List<dynamic>)
          .map((e) => InferredPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InferredExample04ToJson(InferredExample04 instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

InferredPointsXyz _$InferredPointsXyzFromJson(Map<String, dynamic> json) =>
    InferredPointsXyz(
      x: json['x'] as num,
      y: json['y'] as num,
      z: json['z'] as num?,
    );

Map<String, dynamic> _$InferredPointsXyzToJson(InferredPointsXyz instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
    };

InferredExample05 _$InferredExample05FromJson(Map<String, dynamic> json) =>
    InferredExample05(
      pointsXyz: (json['points_xyz'] as List<dynamic>)
          .map((e) => InferredPointsXyz.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InferredExample05ToJson(InferredExample05 instance) =>
    <String, dynamic>{
      'points_xyz': instance.pointsXyz,
    };

InferredExample06 _$InferredExample06FromJson(Map<String, dynamic> json) =>
    InferredExample06(
      grid: (json['grid'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as bool).toList())
          .toList(),
    );

Map<String, dynamic> _$InferredExample06ToJson(InferredExample06 instance) =>
    <String, dynamic>{
      'grid': instance.grid,
    };
