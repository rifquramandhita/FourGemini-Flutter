import 'dart:io';

import 'package:flutter/material.dart';
import 'package:four_gemini/app/module/entity/message_entity.dart';
import 'package:four_gemini/app/presentation/home/home_notifier.dart';
import 'package:four_gemini/core/helper/dialog_helper.dart';
import 'package:four_gemini/core/helper/global_helper.dart';
import 'package:four_gemini/core/widget/bubble_chat_app_widget.dart';
import 'package:four_gemini/core/widget/card_filled_app_widget.dart';
import 'package:four_gemini/core/widget/loading_app_widget.dart';
import 'package:four_gemini/di.dart';
import 'package:image_picker/image_picker.dart';
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
                child: (notifier.userMessage == null &&
                        notifier.userMessage == null)
                    ? Center(
                        child: Text('Enter a prompt'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                        children: [
                          _messageBuild(true, notifier.userMessage!),
                          (notifier.isLoading)
                              ? BubbleChatAppWidget(
                                  isUser: false, child: LoadingAppWidget())
                              : _messageBuild(false, notifier.botMessage!)
                        ],
                      ))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CardFilledAppWidget(
                    content: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Prompt",
                            suffixIcon: IconButton(
                                onPressed: () => _onPressMediaButton(context),
                                icon: Icon(Icons.image))),
                        controller: notifier.textController,
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                    onPressed: _onPressSendTextButton, icon: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _messageBuild(bool isUser, MessageEntity message) {
    return BubbleChatAppWidget(
      isUser: isUser,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        (message.image != null) ? Image.file(message.image!) : SizedBox(),
        (message.text.isNotEmpty && message.image != null)
            ? SizedBox(
                height: 10,
              )
            : SizedBox(),
        (message.text.isNotEmpty) ? Text(message.text) : SizedBox()
      ]),
    );
  }

  _onPressSendTextButton() {
    notifier.sendText();
  }

  _onPressSendMediaButton(BuildContext context, File file) {
    Navigator.pop(context);
    notifier.sendMediaText(file);
  }

  _onPressMediaButton(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      File file = File(xfile.path);
      DialogHelper.showAppDialog(
          context, Text('Send Image'), Image.file(file), [
        Row(
          children: [
            Expanded(
                child: CardFilledAppWidget(
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    controller: notifier.textController,
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Prompt",
                    )),
              ),
            )),
            IconButton.filled(
              onPressed: () => _onPressSendMediaButton(context, file),
              icon: Icon(Icons.send),
            )
          ],
        )
      ]);
    }
  }
}
