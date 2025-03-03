import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';
part 'auth_data_model.g.dart';

@JsonSerializable()
class AuthDataModel {
  const AuthDataModel({required this.user, required this.token});

  final UserModel? user;
  @JsonKey(name: 'token_data')
  final TokenModel? token;

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
