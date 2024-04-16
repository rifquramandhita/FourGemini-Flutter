import 'package:flutter/material.dart';

class DialogHelper {
  static showAppDialog(BuildContext context, Text title, Widget content,
      List<Widget> listAction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: content,
        actions: listAction,
      ),
    );
  }
}
