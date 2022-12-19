// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// DartObjectGenerator
// **************************************************************************

@JsonSerializable()
class InferredExample01 {
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final int age;
  InferredExample01({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory InferredExample01.fromJson(Map<String, dynamic> json) =>
      _$InferredExample01FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample01ToJson(this);
}

@JsonSerializable()
class InferredLocation {
  final String city;
  final String state;
  InferredLocation({
    required this.city,
    required this.state,
  });

  factory InferredLocation.fromJson(Map<String, dynamic> json) =>
      _$InferredLocationFromJson(json);
  Map<String, dynamic> toJson() => _$InferredLocationToJson(this);
}

@JsonSerializable()
class InferredExample02 {
  final String name;
  final InferredLocation location;
  InferredExample02({
    required this.name,
    required this.location,
  });

  factory InferredExample02.fromJson(Map<String, dynamic> json) =>
      _$InferredExample02FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample02ToJson(this);
}

@JsonSerializable()
class InferredExample03 {
  final List<String> names;
  final List<int> ages;
  @JsonKey(name: "can_drive")
  final List<bool> canDrive;
  InferredExample03({
    required this.names,
    required this.ages,
    required this.canDrive,
  });

  factory InferredExample03.fromJson(Map<String, dynamic> json) =>
      _$InferredExample03FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample03ToJson(this);
}

@JsonSerializable()
class InferredPoints {
  final int x;
  final int y;
  InferredPoints({
    required this.x,
    required this.y,
  });

  factory InferredPoints.fromJson(Map<String, dynamic> json) =>
      _$InferredPointsFromJson(json);
  Map<String, dynamic> toJson() => _$InferredPointsToJson(this);
}

@JsonSerializable()
class InferredExample04 {
  final List<InferredPoints> points;
  InferredExample04({
    required this.points,
  });

  factory InferredExample04.fromJson(Map<String, dynamic> json) =>
      _$InferredExample04FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample04ToJson(this);
}

@JsonSerializable()
class InferredPointsXyz {
  final int x;
  final int y;
  final int? z;
  InferredPointsXyz({
    required this.x,
    required this.y,
    this.z,
  });

  factory InferredPointsXyz.fromJson(Map<String, dynamic> json) =>
      _$InferredPointsXyzFromJson(json);
  Map<String, dynamic> toJson() => _$InferredPointsXyzToJson(this);
}

@JsonSerializable()
class InferredExample05 {
  @JsonKey(name: "points_xyz")
  final List<InferredPointsXyz> pointsXyz;
  InferredExample05({
    required this.pointsXyz,
  });

  factory InferredExample05.fromJson(Map<String, dynamic> json) =>
      _$InferredExample05FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample05ToJson(this);
}

@JsonSerializable()
class InferredExample06 {
  final List<List<bool>> grid;
  InferredExample06({
    required this.grid,
  });

  factory InferredExample06.fromJson(Map<String, dynamic> json) =>
      _$InferredExample06FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample06ToJson(this);
}
