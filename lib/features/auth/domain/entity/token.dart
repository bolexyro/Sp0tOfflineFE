class Token {
  const Token(this.accessToken, this.refreshToken);

  final String accessToken;
  final String refreshToken;

  Token.withDefault() : this("johndoeaccesstoken", "johndoerefreshtoken");
}
