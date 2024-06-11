import 'dart:ui';

import 'package:intl/intl.dart';

import 'app_env_config.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "MEAS";

  static Environment env = Environment.prod;

  ///API Env
  static String get baseUrl => env.baseUrl;

  static String get envName => env.envName;
  static String get wsKey => env.wsKey;
  static String get wsCluster => env.wsCluster;

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'vi';
  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);

  ///DateFormat

  static const dateAPIFormat = 'dd-MM-yyyy';
  static const dateAPI = 'yyyy-MM-dd';
  static const dateDisplayFormat = 'dd.MM.yyyy';
  static const dayDisplayFormat = 'EEEE, dd.MM.yyyy';
  static const timeDisplayFormat = 'hh:mm a';
  static const timeDisplay = 'kk:mm';
  //format month take salary
  static const salaryMonth = 'MM-yyyy';
  static const day = 'dd';
  static const month = 'M';
  static const year = 'yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';
  static const dateTimeFormat = 'yyyy-MM-dd HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  //NUMBER FORMAT
  static final formatter = "#,###";

  ///Max file
  static const maxAttachFile = 5;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}

class MovieAPIConfig {
  static const String apiKey = '26763d7bf2e94098192e629eb975dab0';
}

class UpGraderAPIConfig {
  static const String apiKey = '';
}
