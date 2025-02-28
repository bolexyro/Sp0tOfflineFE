import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenModel {
  const TokenModel(this.accessToken, this.refreshToken);

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
