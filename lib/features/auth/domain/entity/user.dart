class User {
  User({
    required this.id,
    required this.name,
    required this.images,
    required this.email,
  });

  final String name;
  final List<String> images;
  final String email;
  final String id;

  User.withDefault()
      : this(
          name: "John Doe",
          images: [],
          email: "johndoe@spotoffline.com",
          id: "randomletters",
        );

  String getInitials() {
    List<String> words = name.trim().split(' ');
    String initials = words.map((word) => word[0].toUpperCase()).join();
    return initials;
  }
}
