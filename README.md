<div align="center">
    <img src="public/inferno.png" alt="Inferno logo">
</div>

## Usage

Inferno is a library that simplifies the process of working with JSON data. It allows users to automatically infer data types from a JSON file and generate a parser that can parse it.

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