import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(),
          ),
          Pulse(
            infinite: true,
            child: const Icon(
              Icons.watch_later_outlined,
              size: 35,
            ),
          ),
          // Image.asset(ImagesPath.logo.path,
          //       height: 50, width: 50, fit: BoxFit.fill),
        ],
      ),
    );
  }
}
