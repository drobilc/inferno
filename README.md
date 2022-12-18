<div align="center">
    <img src="https://raw.githubusercontent.com/drobilc/inferno/main/public/inferno.png" alt="Inferno logo">
</div>

<h3 align="center">
  <a href="#introduction"><b>Introduction</b></a>
  &nbsp;&#65372;&nbsp;
  <a href="#usage"><b>Usage</b></a>
  &nbsp;&#65372;&nbsp;
  <a href="#examples"><b>Examples</b></a>
</h3>

## Introduction

**Inferno** is a library that simplifies the process of working with JSON data. It allows users to automatically infer data types from a JSON file and generate a parser that can parse it.

## Usage

The following code in file named `person.dart`.

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:inferno/annotations.dart';

part 'person.inferno.dart';
part 'person.g.dart';

@InferFromJSONFile(file: "person.json")
typedef Person = InferredPerson;
```

### Imports

Since we will be using the `@InferFromJSONFile` annotation, we must first import it using `import 'package:inferno/annotations.dart';`. The generated file will use `@JsonSerializable` annotation, which can be found in `import 'package:json_annotation/json_annotation.dart';` library.

The **Inferno** library will generate a file `person.inferno.dart`, containing an object inferred from JSON file `person.json`. The object will be annotated using the `@JsonSerializable` annotation, which will generate another file `person.g.dart`, which will contain a `json_serializable` parser. We must define both files as parts of our type definition file.

### Type inference

```dart
@InferFromJSONFile(file: "person.json")
typedef Person = InferredPerson;
```

The `@InferFromJSONFile` annotation must always precede type definition of format `typedef <ClassName> = Inferred<ClassName>`. **Inferno will generate a new class named `Inferred<ClassName>`, which we then rename to `<ClassName>` using type alias.

Note: We can include many type declarations with `InferFromJSONFile` annotation in a single file, which will generate only two files: `<file_name>.inferno.dart` and `<file_name>.g.dart`.

### Generating JSON parsers

To build with a Dart package, run Dart build runner using `dart run build_runner build` in the package directory`.

To build with a Flutter package, run `flutter pub run build_runner build` in your package directory.

## Examples

First, we will feed Inferno a JSON object with several fields and see how it generates the corresponding Dart object. Then, we will see how Inferno can handle nested JSON objects and arrays, and how it can infer other data types from the JSON data.

### Infering data types for simple objects

Let's start by examining a simple example. We feed Inferno a JSON object with three fields named in snake case.

```json
{
    "first_name": "Raymond",
    "last_name": "Holt",
    "age": 65
}
```

Inferno generates the following Dart object that is annotated with `JsonSerializable` annotation from the [json_annotation](https://pub.dev/packages/json_annotation) library. This annotation allows us to generate the necessary code for serializing and deserializing the object to and from JSON.

As you can see, Inferno correctly infers the data types from the input JSON file. In accordance with Dart convention, the field names have been transformed into snake case and a `JsonKey` annotation has been added. Since the original JSON object had values for all three keys, all of the data types are non-nullable.

```dart
@JsonSerializable()
class InferredExample01 {
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final num age;
  InferredExample01({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory InferredExample01.fromJson(Map<String, dynamic> json) =>
      _$InferredExample01FromJson(json);
  Map<String, dynamic> toJson() => _$InferredExample01ToJson(this);
}
```

The `_$InferredExample01FromJson` and `_$InferredExample01ToJson` references are to a generated file that is created when we run the [json_serializable](https://pub.dev/packages/json_serializable) generator. This generated file contains the actual serialization and deserialization logic for the class, allowing us to easily convert objects of this class to and from JSON.

### Infering data types for nested objects

Let's look at an example of a JSON file containing a nested object. In this example, the location is represented as a nested object with two fields.

```json
{
    "name": "Raymond Jacob Holt",
    "location": {
        "city": "Brooklyn",
        "state": "NY"
    }
}
```

Inferno generates the following code. The first object represents our location with `city` and `state` fields and the second object represents a person with `name` and `location` fields.

```dart
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
```

To parse the original JSON file, we can now call `final person = InferredExample02.fromJson(...)`.

### Infering data types for arrays - primitive data types

```json
{
    "names": [ "George", "Jenna", "Michael", "Tina" ],
    "ages": [ 25, 12, 84, 16 ],
    "can_drive": [ true, false, true, false ]
}
```

```dart
@JsonSerializable()
class InferredExample03 {
  final List<String> names;
  final List<num> ages;
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
```

### Infering data types for arrays - objects with identical fields

```json
{
    "points": [
        { "x": 0, "y": 0 },
        { "x": 5, "y": 2 },
        { "x": 3, "y": 4 }
    ]
}
```

```dart
@JsonSerializable()
class InferredPoints {
  final num x;
  final num y;
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
```

### Infering data types for arrays - objects with similar fields

```json
{
    "points_xyz": [
        { "x": 0, "y": 0 },
        { "x": 5, "y": 2, "z": 16 },
        { "x": 3, "y": 4 }
    ]
}
```

```dart
@JsonSerializable()
class InferredPointsXyz {
  final num x;
  final num y;
  final num? z;
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
```

### Infering data types for nested arrays

```json
{
    "grid": [
        [ false, false, true ],
        [ false, true, false ],
        [ true, false, false ]
    ]
}
```

```dart
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
```