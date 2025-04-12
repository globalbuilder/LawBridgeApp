import 'dart:ui';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String username;
  final String email;
  final String profileImageUrl;
  final VoidCallback onLogout;

  const CustomDrawer({
    super.key,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayUsername = username.trim().isEmpty ? 'Guest' : username.trim();
    final displayEmail = email.trim();

    // Helper to build each tile
    Widget navTile({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
      Color? iconColor,
      Color? textColor,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Material(
          color: theme.colorScheme.surface.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            leading: Icon(icon, color: iconColor ?? theme.iconTheme.color),
            title: Text(label,
                style: theme.textTheme.bodyLarge?.copyWith(color: textColor)),
            trailing: const Icon(Icons.chevron_right),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: () {
              Navigator.pop(context);
              onTap();
            },
          ),
        ),
      );
    }

    return Drawer(
      width: 290,
      child: SafeArea(
        child: Column(
          children: [
            // -----------------------------------------------------------------
            // Fancy Header
            // -----------------------------------------------------------------
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              child: Stack(
                children: [
                  // gradient background
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // blur glass overlay (if supported)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  // content
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'profile-avatar',
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.white,
                            backgroundImage: (profileImageUrl.isNotEmpty &&
                                    profileImageUrl.startsWith('http'))
                                ? NetworkImage(profileImageUrl)
                                : const AssetImage(
                                        'assets/images/avatar_placeholder.png')
                                    as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          displayUsername,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (displayEmail.isNotEmpty)
                          Text(
                            displayEmail,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // -----------------------------------------------------------------
            // Navigation Tiles
            // -----------------------------------------------------------------
            navTile(
              icon: Icons.person,
              label: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            navTile(
              icon: Icons.favorite,
              label: 'Favorites',
              onTap: () => Navigator.pushNamed(context, '/favorites'),
            ),
            navTile(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),

            // const Spacer(),

            // -----------------------------------------------------------------
            // Logout
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Material(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text(
                    'Logout',
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    Navigator.pop(context);
                    onLogout();
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
