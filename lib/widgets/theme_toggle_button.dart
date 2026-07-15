import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const ThemeToggleButton({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: onToggle,
      icon: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: isDarkMode ? Colors.amberAccent : Colors.orange,
      ),
    );
  }
}
