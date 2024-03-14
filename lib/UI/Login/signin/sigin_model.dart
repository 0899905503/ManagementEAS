import 'dart:async';

class UserModel {
  late String _username;
  late String _email;
  late String _password;

  String get username => _username;
  String get email => _email;

  void set username(String username) {
    _username = username;
    _updateView();
  }

  void set email(String email) {
    _email = email;
    _updateView();
  }

  void set password(String password) {
    _password = password;
  }

  Future<void> signIn() async {
    // Simulate sign-in process
    await Future.delayed(Duration(seconds: 2));

    // Perform sign-in logic (e.g., validate credentials)
    // For simplicity, we assume the sign-in is successful
    _updateView();
  }

  Future<void> signUp() async {
    // Simulate sign-up process
    await Future.delayed(Duration(seconds: 2));

    // Perform sign-up logic (e.g., validate credentials, create new user)
    // For simplicity, we assume the sign-up is successful
    _updateView();
  }

  late Function _updateViewCallback;

  void registerViewUpdateCallback(Function callback) {
    _updateViewCallback = callback;
  }

  void _updateView() {
    if (_updateViewCallback != null) {
      _updateViewCallback();
    }
  }
}
