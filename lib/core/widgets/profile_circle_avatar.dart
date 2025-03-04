import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:spotoffline/features/auth/presentation/providers/auth_provider.dart';
import 'package:spotoffline/features/auth/presentation/screens/login_screen.dart';
import 'package:sqflite/sqflite.dart';

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
              // Get the database path
              final dbPath = await getDatabasesPath();
              final path = join(dbPath, 'app.db');

              // Delete the database
              await deleteDatabase(path);
              print('Database deleted: $path');
              // await ref.read(authProvider.notifier).logout();

              // if (context.mounted) {
              //   Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const LoginScreen()),
              //     (Route<dynamic> route) => false,
              //   );
              // }
            },
          )
        ],
        child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(ref.read(authProvider)!.user!.getInitials())),
      ),
    );
  }
}
