import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/models/user.dart';


class UserDataNotifier extends StateNotifier<User>{
  UserDataNotifier() : super(User.withDefault());

  void updateUserData(User userData){
    state = userData;
  }
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, User>(
  (ref) =>UserDataNotifier(),
);