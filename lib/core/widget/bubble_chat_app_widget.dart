import 'package:flutter/material.dart';
import 'package:four_gemini/core/helper/global_helper.dart';

class BubbleChatAppWidget extends StatelessWidget {
  final bool isUser;
  final Widget child;

  BubbleChatAppWidget({super.key, required this.isUser, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (isUser) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: (isUser)
            ? EdgeInsets.fromLTRB(50, 5, 0, 15)
            : EdgeInsets.fromLTRB(0, 5, 50, 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: (isUser)
                ? GlobalHelper.getColorSchema(context).primaryContainer
                : GlobalHelper.getColorSchema(context).tertiaryContainer,
            borderRadius: BorderRadius.only(
                topLeft: (isUser) ? Radius.circular(20) : Radius.zero,
                topRight: (!isUser) ? Radius.circular(20) : Radius.zero,
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: child,
      ),
    );
  }
}
