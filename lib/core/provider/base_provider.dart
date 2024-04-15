import 'package:flutter/cupertino.dart';

class BaseProvider with ChangeNotifier {
  bool _isDispose = false;
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isDispose => _isDispose;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  set errorMessage(String param) => _errorMessage = param;

  void showLoading() {
    _isLoading = true;
    if (!_isDispose) notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    if (!_isDispose) notifyListeners();
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
