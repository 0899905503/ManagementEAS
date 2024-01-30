part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final ThemeMode themeMode;
  final Color primaryColor;
  final Locale? locale;

  const AppSettingState({
    this.themeMode = ThemeMode.system,
    this.primaryColor = AppColors.primary,
    this.locale = AppConfigs.defaultLocal,
  });

  @override
  List<Object?> get props => [
        themeMode,
        primaryColor,
        locale,
      ];

  AppSettingState copyWith({
    ThemeMode? themeMode,
    Color? primaryColor,
    Locale? locale,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      locale: locale ?? this.locale,
    );
  }

  bool get isEn => locale?.languageCode == "en";
  bool get isDe => locale?.languageCode == "de";
  bool get isVi => locale?.languageCode == "vi";

  LocaleType get localeType {
    if (isEn) return LocaleType.en;
    if (isVi) return LocaleType.vi;
    return LocaleType.de;
  }
}
