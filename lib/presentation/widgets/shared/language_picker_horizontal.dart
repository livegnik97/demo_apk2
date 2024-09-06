import 'package:demo_apk/core/helpers/custom_context.dart';
import 'package:demo_apk/l10n/l10n.dart';
import 'package:demo_apk/presentation/providers/language/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagePickerHorizontal extends ConsumerWidget {
  const LanguagePickerHorizontal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeFinal = ref.watch(localeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < L10n.all.length; i++)
          GestureDetector(
            onTap: () {
              ref.read(localeProvider.notifier).setLocale(L10n.all[i]);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(L10n.getFlag(L10n.all[i].languageCode),
                        style: const TextStyle(fontSize: 32)),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      width: localeFinal.locale == L10n.all[i] ? 30 : 0,
                      decoration: BoxDecoration(
                          color: context.primary,
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ),
                const SizedBox(width: 8),
                if (i < L10n.all.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      width: 1,
                      height: 30,
                      decoration: BoxDecoration(
                        color: context.primary,
                      ),
                    ),
                  )
              ],
            ),
          )
      ],
    );
  }
}
