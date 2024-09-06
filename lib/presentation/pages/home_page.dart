import 'package:demo_apk/main.dart';
import 'package:demo_apk/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Apk"),
        actions: const [
          LanguagePicker(),
          SizedBox(width: 12),
          ThemeChangeWidget(),
          SizedBox(width: 12),
        ],
      ),
      body: Center(child: Text(AppLocalizations.of(context)!.helloWorld)),
    );
  }
}
