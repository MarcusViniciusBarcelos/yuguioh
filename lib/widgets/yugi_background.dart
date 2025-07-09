import 'package:flutter/cupertino.dart';

class YugiBackground extends StatelessWidget {
  final Widget child;
  const YugiBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/egypt_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: child,
    );
  }
}