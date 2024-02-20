// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/UI/Employee/profile_page/tk_profile_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/app_env_config.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
// }
Future<void> _firebaseMessagingBackgroundHandler() async {
  // await Firebase.initializeApp();
}
void main() async {
  runApp(ChooseAppScreen());
}
