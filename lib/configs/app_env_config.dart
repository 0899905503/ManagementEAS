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
    switch (this) {
      case Environment.dev:
        return "https://api-inventory.nq72.de/api/";
      case Environment.stg:
        return "https://api-inventory.nq72.de/api/";
      case Environment.prod:
        return "https://api-inventory.nq72.de/api/";
    }
  }

  String get wsKey => "98dc33b1317783036aba";
  String get wsCluster => "ap1";

  // app_id = "1684959"
  // key = "98dc33b1317783036aba"
  // secret = "13702c90141537ef2e8f"
  // cluster = "ap1"
  // channel: npos-business_id
}
