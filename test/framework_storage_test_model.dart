import 'package:json_annotation/json_annotation.dart';

part 'framework_storage_test_model.g.dart';

@JsonSerializable()
class FrameworkStorageTestModel {
  final String id;
  final String name;

  FrameworkStorageTestModel({required this.id, required this.name});

  factory FrameworkStorageTestModel.fromJson(Map<String, dynamic> json) =>
      _$FrameworkStorageTestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FrameworkStorageTestModelToJson(this);
}
