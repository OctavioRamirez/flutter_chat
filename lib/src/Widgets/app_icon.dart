import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/charla.png'),
        Text(
          'Flutter Chat',
          style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
