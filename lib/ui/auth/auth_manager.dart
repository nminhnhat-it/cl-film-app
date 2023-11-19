import 'package:ct484_project/services/account_service.dart';
import 'package:flutter/cupertino.dart';

class AuthManager with ChangeNotifier {
  final AccountService _accountService = AccountService();
  bool _isRegister = false;

  dynamic _user;
  dynamic _token;

  set token(newValue) {
    _accountService.saveToken(newValue);
    _token = newValue;
    retrieveUserData();
  }

  get token {
    return _token;
  }

  get user {
    return _user;
  }

  set initIsRegister(newValue) {
    _isRegister = false;
  }

  set user(newValue) {
    _user = newValue;
    notifyListeners();
  }

  set isRegister(bool newValue) {
    _isRegister = newValue;
    notifyListeners();
  }

  bool get isRegister {
    return _isRegister;
  }

  Future<bool> verifyCredential(data) async {
    final dynamic token = await _accountService.verifyCredential(data);
    this.token = token;
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createUser(data) async {
    final dynamic token = await _accountService.createUser(data);
    this.token = token;
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> retrieveUserData() async {
    final dynamic user = await _accountService.retrieveUserData(token);
    this.user = user;
  }

  Future<void> loadToken() async {
    final dynamic data = await _accountService.loadToken();
    if (data != null) {
      token = data;
    }
  }

  void removeToken() async {
    token = null;
  }

  Future<void> updateUserData(newUser, file) async {
    await _accountService.updateUserData(newUser, file, token, user);
    retrieveUserData();
    notifyListeners();
  }
}
