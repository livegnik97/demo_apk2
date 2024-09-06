import 'package:animate_do/animate_do.dart';
import 'package:demo_apk/presentation/widgets/shared/custom_card.dart';
import 'package:flutter/material.dart';

class SnackBarGI {
  static void showOriginal(BuildContext context, {
    required String text,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
  }){
    if(text.isEmpty) return;
    final snackbar = SnackBar(
      content: Text(text),
      action: action,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackbar);
  }

  static void showCustom(BuildContext context, {
    required String text,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
  }){
    if(text.isEmpty) return;
    final color = Theme.of(context).colorScheme;
    final snackbar = SnackBar(
      content: FadeInUp(
        child: CustomCard(
          color: color.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Flexible(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: color.onSecondary
            )),
          ),
        ),
      ),
      action: action,
      duration: duration,

      elevation: 0,
      backgroundColor: Colors.transparent,
      // backgroundColor: color.secondary,
    );
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackbar);
  }

  static void showWithIcon(BuildContext context, {
    required IconData icon,
    required String text,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
  }){
    if(text.isEmpty) return;
    final color = Theme.of(context).colorScheme;
    final snackbar = SnackBar(
      content: FadeInUp(
        child: CustomCard(
          color: color.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: color.onSecondary),
              const SizedBox(width: 10),
              Flexible(
                child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color.onSecondary
                )),
              ),
            ],
          ),
        ),
      ),
      action: action,
      duration: duration,

      padding: const EdgeInsets.all(0),
      elevation: 0,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
      // backgroundColor: color.secondary,
    );
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackbar);
  }
}