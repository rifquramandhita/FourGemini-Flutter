import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:four_gemini/app/presentation/home/home_notifier.dart';
import 'package:four_gemini/core/helper/global_helper.dart';
import 'package:four_gemini/core/widget/card_filled_app_widget.dart';
import 'package:four_gemini/core/widget/loading_app_widget.dart';
import 'package:four_gemini/di.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late HomeNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeNotifier>(
      create: (context) => sl(),
      builder: (context, child) => _build(context),
    );
  }

  _build(BuildContext context) {
    notifier = Provider.of<HomeNotifier>(context);
    return _bodyBuild(context);
  }

  _bodyBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Four Gemini"),
        backgroundColor: GlobalHelper.getColorSchema(context).primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: (notifier.userChat.isEmpty && notifier.userChat.isEmpty)
                    ? Center(
                        child: Text('Enter a prompt'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                        children: [
                          BubbleSpecialOne(
                            text: notifier.userChat,
                            isSender: true,
                            color: GlobalHelper.getColorSchema(context)
                                .primaryContainer,
                            tail: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (notifier.isLoading)
                              ? LoadingAppWidget()
                              : BubbleSpecialOne(
                                  text: notifier.botChat,
                                  isSender: false,
                                  color: GlobalHelper.getColorSchema(context)
                                      .tertiaryContainer,
                                  tail: true,
                                )
                        ],
                      ))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CardFilledAppWidget(
                    content: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Prompt"),
                        controller: notifier.textController,
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                    onPressed: _onPressSendButton, icon: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onPressSendButton() {
    notifier.send();
  }
}
