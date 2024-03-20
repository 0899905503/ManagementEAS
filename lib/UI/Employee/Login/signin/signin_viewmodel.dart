import 'dart:async';

import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class SigninViewModel {
  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final BehaviorSubject<bool> _loginSubject = BehaviorSubject<bool>();
  final AuthRepository _apiService = AuthRepository();

  final StreamController<String> _emailController = StreamController<String>();
  final StreamController<String> _passwordController =
      StreamController<String>();
  final StreamController<bool> _loginController = StreamController<bool>();

  Stream<String> get emailStream => _emailSubject.stream;
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream;
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get loginStream => _loginSubject.stream;
  Sink<bool> get loginSink => _loginSubject.sink;

  SigninViewModel() {
    // Khi email hoặc password thay đổi, kiểm tra và cập nhật loginStream
    Stream<bool> loginStream = Rx.combineLatest2(emailStream, passwordStream,
        (String email, String password) {
      return email?.isNotEmpty == true && password?.isNotEmpty == true;
    });
    loginStream.listen((enable) {
      loginSink.add(enable);
    });
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loginController.close();
  }
}
