// ignore_for_file: must_be_immutable

import 'package:demo_apk/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  CustomGradientButton(
      {super.key, required this.label, this.onPressed, this.color});

  final String label;
  final VoidCallback? onPressed;
  Color? color;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    color ??= Theme.of(context).colorScheme.primary;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color!.withOpacity(0.5), color!])),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            // width: width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(label.toUpperCase(),
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
