import 'package:json_annotation/json_annotation.dart';
import 'package:inferno/annotations.dart';

part 'example.inferno.dart';
part 'example.g.dart';

@InferFromJSONFile(file: "person.json")
typedef Person = InferredPerson;

@InferFromJSONFile(file: "item.json")
typedef Item = InferredItem;