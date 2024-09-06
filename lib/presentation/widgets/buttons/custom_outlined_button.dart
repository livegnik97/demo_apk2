import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key,
      this.icon,
      required this.label,
      this.onPressed,
      this.imageAsset,
      this.radius = 30,
      this.height,
      this.width,
      this.color,
      this.backgroundColor,
      this.centerContent = true})
      : super(key: key);

  final IconData? icon;
  final String? imageAsset;
  final String label;
  final VoidCallback? onPressed;
  final double radius;
  final double? height;
  final double? width;
  final Color? color;
  final Color? backgroundColor;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: backgroundColor,
        alignment: centerContent ? null : const Alignment(-1, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))));
    final button = (icon != null || imageAsset != null)
        ? OutlinedButton.icon(
            style: buttonStyle,
            label: AutoSizeText(label, maxLines: 1, minFontSize: 1),
            icon: imageAsset != null
                ? Image.asset(imageAsset!, width: 25, height: 25)
                : Icon(icon),
            onPressed: onPressed,
          )
        : OutlinedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: AutoSizeText(label, maxLines: 1, minFontSize: 1),
          );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
