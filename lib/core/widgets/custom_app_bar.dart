import 'package:flutter/material.dart';

/// A reusable AppBar that provides consistent styling across your app.
/// Supports an optional bottom widget. If a TabBar is provided as the bottom,
/// it applies custom styling so that the text and indicator contrast with the background.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.leading,
    required this.title,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the app theme's color scheme.
    final appBarColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onPrimary;

    // If a TabBar is provided as the bottom, recreate it with custom styles.
    PreferredSizeWidget? processedBottom;
    if (bottom is TabBar) {
      final TabBar tb = bottom as TabBar;
      processedBottom = TabBar(
        // Reuse the passed TabBar's controller and tabs.
        controller: tb.controller,
        tabs: tb.tabs,
        // Apply custom styling for a clear contrast.
        indicatorColor: textColor,
        indicatorWeight: 3.0,
        labelColor: textColor,
        unselectedLabelColor: textColor.withOpacity(0.7),
      );
    } else {
      processedBottom = bottom;
    }

    return AppBar(
      leading: leading,
      backgroundColor: appBarColor,
      foregroundColor: textColor,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: actions,
      bottom: processedBottom,
    );
  }

  @override
  Size get preferredSize => bottom != null
      ? Size.fromHeight(kToolbarHeight + bottom!.preferredSize.height)
      : const Size.fromHeight(kToolbarHeight);
}
