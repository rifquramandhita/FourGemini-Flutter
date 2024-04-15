import 'package:flutter/material.dart';

class CardFilledAppWidget extends StatelessWidget {
  final Widget content;
  CardFilledAppWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: content,
    );
  }
}
