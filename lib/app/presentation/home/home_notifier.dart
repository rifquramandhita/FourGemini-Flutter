import 'package:flutter/cupertino.dart';
import 'package:four_gemini/core/constant/constant.dart';
import 'package:four_gemini/core/provider/base_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeNotifier extends BaseProvider {
  TextEditingController _textController = TextEditingController();
  String _userChat = '';
  String _botChat = '';

  TextEditingController get textController => _textController;

  String get userChat => _userChat;

  String get botChat => _botChat;

  send() async {
    _userChat = textController.text;
    textController.clear();
    showLoading();
    final model = GenerativeModel(model: 'gemini-pro', apiKey: GEMINI_API_KEY);
    final content = [Content.text(_userChat)];
    final response = await model.generateContent(content);
    _botChat = response.text ?? '';
    hideLoading();
  }
}
