import 'package:demo_apk/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeChangeWidget extends ConsumerWidget {
  const ThemeChangeWidget({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return IconButton(
      icon: Icon(
          isDarkTheme ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: () =>
          ref.read(isDarkThemeProvider.notifier).update((state) => !state),
      color: color,
    );
  }
}
