<div align="center">
    <img src="public/inferno.png" alt="Inferno logo">
</div>

<h3 align="center">
  <a href="#installation"><b>Installation</b></a>
  &nbsp;&#65372;&nbsp;
  <a href="#usage"><b>Usage</b></a>
  &nbsp;&#65372;&nbsp;
  <a href="#examples"><b>Examples</b></a>
</h3>

## Introduction

**Inferno** is a library that simplifies the process of working with JSON data. It allows users to automatically infer data types from a JSON file and generate a parser that can parse it.

## Installation

## Usage

## ⭐ Examples

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
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        @JsonKey(name: "first_name")
        final String firstName;

        @JsonKey(name: "last_name")
        final String lastName;

        final num age;

        Object1({
                required this.firstName,
                required this.lastName,
                required this.age
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

}
```

The `part ...`, `_$Object1FromJson` and `_$Object1ToJson` references are to a generated file that is created when we run the [json_serializable](https://pub.dev/packages/json_serializable) generator. This generated file contains the actual serialization and deserialization logic for the class, allowing us to easily convert objects of this class to and from JSON.

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
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        final String city;
        final String state;
        Object1({
                required this.city,
                required this.state
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

}

@JsonSerializable()
class Object2 {

        final String name;
        final Object1 location;
        Object2({
                required this.name,
                required this.location
        });

        factory Object2.fromJson(Map<String, dynamic> json) => _$Object2FromJson(json);
        Map<String, dynamic> toJson() => _$Object2ToJson(this);

}
```

To parse the original JSON file, we can now call `final person = Object1.fromJson(...)`.

### Infering data types for arrays - primitive data types

```json
{
    "names": ["George", "Jenna", "Michael", "Tina"],
    "ages": [25, 12, 84, 16],
    "can_drive": [true, false, true, false]
}
```

```dart
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        final List<String> names;
        final List<num> ages;
        @JsonKey(name: "can_drive")
        final List<bool> canDrive;
        Object1({
                required this.names,
                required this.ages,
                required this.canDrive
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

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
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        final num x;
        final num y;
        Object1({
                required this.x,
                required this.y
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

}

@JsonSerializable()
class Object2 {

        final List<Object1> points;
        Object2({
                required this.points
        });

        factory Object2.fromJson(Map<String, dynamic> json) => _$Object2FromJson(json);
        Map<String, dynamic> toJson() => _$Object2ToJson(this);

}
```

### Infering data types for arrays - objects with similar fields

```json
{
    "points": [
        { "x": 0, "y": 0 },
        { "x": 5, "y": 2, "z": 16 },
        { "x": 3, "y": 4 }
    ]
}
```

```dart
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        final num x;
        final num y;
        final num? z;
        Object1({
                required this.x,
                required this.y,
                this.z
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

}

@JsonSerializable()
class Object2 {

        final List<Object1> points;
        Object2({
                required this.points
        });

        factory Object2.fromJson(Map<String, dynamic> json) => _$Object2FromJson(json);
        Map<String, dynamic> toJson() => _$Object2ToJson(this);

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
import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {

        final List<List<bool>> grid;
        Object1({
                required this.grid
        });

        factory Object1.fromJson(Map<String, dynamic> json) => _$Object1FromJson(json);
        Map<String, dynamic> toJson() => _$Object1ToJson(this);

}
```