import 'dart:async';

import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class SigninViewModel {
  final AuthRepository _apiService = AuthRepository();
  String? firstname = " ";
}
