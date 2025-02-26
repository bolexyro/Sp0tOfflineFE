import 'package:spotoffline/models/tokens.dart';

class User {
  final String name;
  final List<String> images;
  final String email;
  final String id;
  final Tokens tokens;

  User(
      {required this.name,
      required this.images,
      required this.email,
      required this.id,
      required this.tokens});

  User.withDefault()
      : this(
          name: "John Doe",
          images: [],
          email: "johndoe@spotoffline.com",
          id: "randomletters",
          tokens: const Tokens("johndoeaccesstoken", "johndoerefreshtoken"),
        );

  String getInitials() {
    List<String> words = name.trim().split(' ');
    String initials = words.map((word) => word[0].toUpperCase()).join();
    return initials;
  }
}
