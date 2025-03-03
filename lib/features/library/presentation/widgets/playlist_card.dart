import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundImageUrl,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final String? backgroundImageUrl;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.green.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: backgroundImageUrl != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(backgroundImageUrl!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 94, 23, 209),
                                Color.fromARGB(255, 192, 165, 236),
                              ],
                            ),
                          ),
                    child: icon == null
                        ? null
                        : Icon(
                            icon,
                            size: 60,
                            color: Colors.white,
                          ),
                  ),
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
