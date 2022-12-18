import 'package:json_annotation/json_annotation.dart';
import 'package:inferno/annotations.dart';

part 'example.inferno.dart';
part 'example.g.dart';

@InferFromJsonFile(file: "json/example01.json")
typedef Example01 = InferredExample01;

@InferFromJsonFile(file: "json/example02.json")
typedef Example02 = InferredExample02;

@InferFromJsonFile(file: "json/example03.json")
typedef Example03 = InferredExample03;

@InferFromJsonFile(file: "json/example04.json")
typedef Example04 = InferredExample04;

@InferFromJsonFile(file: "json/example05.json")
typedef Example05 = InferredExample05;

@InferFromJsonFile(file: "json/example06.json")
typedef Example06 = InferredExample06;