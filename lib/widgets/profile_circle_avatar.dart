import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/providers/user_provider.dart';
import 'package:spotoffline/screens/login_screen.dart';

class ProfileCircleAvatar extends ConsumerWidget {
  const ProfileCircleAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MenuController menuController = MenuController();

    return GestureDetector(
      onTap: () {
        menuController.open();
      },
      child: MenuAnchor(
        controller: menuController,
        menuChildren: [
          MenuItemButton(
            child: const Text('Log out'),
            onPressed: () async {
              final SharedPreferencesAsync asyncPrefs =
                  SharedPreferencesAsync();
              await asyncPrefs.clear();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          )
        ],
        child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(ref.read(userDataProvider).getInitials())),
      ),
    );
  }
}
