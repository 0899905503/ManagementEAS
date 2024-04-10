enum Environment {
  dev,
  stg,
  prod,
}

extension EnvironmentExt on Environment {
  String get envName {
    switch (this) {
      case Environment.dev:
        return 'LOCAL';
      case Environment.stg:
        return 'STAGING';
      case Environment.prod:
        return 'PROD';
    }
  }

  String get baseUrl {
    return "http://192.168.18.46:8000/";
  }

  String get wsKey => "98dc33b1317783036aba";
  String get wsCluster => "ap1";

  // app_id = "1684959"
  // key = "98dc33b1317783036aba"
  // secret = "13702c90141537ef2e8f"
  // cluster = "ap1"
  // channel: npos-business_id
}
