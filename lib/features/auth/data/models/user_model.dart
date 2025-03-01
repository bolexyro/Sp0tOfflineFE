import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.name,
    required this.images,
    required this.email,
    required this.id,
  });

  final String id;
  @JsonKey(name: 'display_name')
  final String name;
  final List<String> images;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
