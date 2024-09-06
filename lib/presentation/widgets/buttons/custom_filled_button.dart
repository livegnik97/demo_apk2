import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {Key? key,
      this.icon,
      this.imageAsset,
      required this.label,
      this.borderRadius = 30,
      this.height,
      this.width,
      this.color,
      this.centerContent = true,
      this.onPressed})
      : super(key: key);

  final IconData? icon;
  final String? imageAsset;
  final String label;
  final double borderRadius;
  final double? height;
  final double? width;
  final Color? color;
  final bool centerContent;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: color,
        alignment: centerContent ? null : const Alignment(-1, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)));

    final button = (icon != null || imageAsset != null)
        ? FilledButton.icon(
            style: buttonStyle,
            label: AutoSizeText(label, maxLines: 1, minFontSize: 1),
            icon: imageAsset != null
                ? Image.asset(imageAsset!, width: 25, height: 25)
                : Icon(icon),
            onPressed: onPressed,
          )
        : FilledButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: AutoSizeText(label, maxLines: 1, minFontSize: 1),
          );

    if (height != null || width != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return button;
  }
}
