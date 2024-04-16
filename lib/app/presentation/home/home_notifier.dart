import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:four_gemini/app/module/entity/message_entity.dart';
import 'package:four_gemini/core/constant/constant.dart';
import 'package:four_gemini/core/provider/base_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeNotifier extends BaseProvider {
  TextEditingController _textController = TextEditingController();
  MessageEntity? _userMessage = null;
  MessageEntity? _botMessage = null;

  TextEditingController get textController => _textController;

  MessageEntity? get userMessage => _userMessage;

  MessageEntity? get botMessage => _botMessage;

  sendText() async {
    _userMessage = MessageEntity(text: textController.text);
    textController.clear();
    showLoading();
    final model = GenerativeModel(model: 'gemini-pro', apiKey: GEMINI_API_KEY);
    final content = [Content.text(_userMessage!.text)];
    final response = await model.generateContent(content);
    _botMessage = MessageEntity(text: response.text ?? '');
    hideLoading();
  }

  sendMediaText(File file) async {
    _userMessage = MessageEntity(text: textController.text, image: file);
    textController.clear();
    showLoading();
    final model =
        GenerativeModel(model: 'gemini-pro-vision', apiKey: GEMINI_API_KEY);
    final prompt = TextPart(_userMessage!.text);
    final imageParts = [
      DataPart('image/jpeg', await file.readAsBytes()),
    ];
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    _botMessage = MessageEntity(text: response.text ?? '-');
    hideLoading();
  }
}
