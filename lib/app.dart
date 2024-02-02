import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/common/app_themes.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/network/api_util.dart';
import 'package:flutter_base/network/ws_connector.dart';
import 'package:flutter_base/repositories/auth_repository.dart';

import 'package:flutter_base/repositories/tk_user_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/utils/handle_push_notification.dart';
import 'package:flutter_base/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'network/api_client.dart';

import 'router/route_config.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    // HandlePushNotification.instance.init();
    WsConnector.instance.initWS();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider<AuthRepository>(create: (context) {
        //   return AuthRepositoryImpl(apiClient: _apiClient);
        // }),
        // RepositoryProvider<CategoryRepository>(create: (context) {
        //   return CategoryRepositoryImpl(apiClient: _apiClient);
        // }),
        // RepositoryProvider<ProductRepository>(create: (context) {
        //   return ProductRepositoryImpl(apiClient: _apiClient);
        // }),
        // RepositoryProvider<WarehouseRepository>(create: (context) {
        //   return WarehouseRepositoryImpl(apiClient: _apiClient);
        // }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<TKUserRepository>(create: (context) {
          return TKUserRepositoryImpl(apiClient: _apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            // final productRepo =
            //     RepositoryProvider.of<ProductRepository>(context);
            // final warehouseRepo =
            //     RepositoryProvider.of<WarehouseRepository>(context);
            return AppCubit(
              authRepo: authRepo,
              // productRepository: null,
              warehouseRepository: null,
              //productRepository: productRepo,
              // warehouseRepository: warehouseRepo,
            );
          }),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          builder: (context, state) {
            if (state.locale == null) {
              Locale myLocale = WidgetsBinding.instance.window.locale;
              if (myLocale.languageCode != "vi" &&
                  myLocale.languageCode != "de" &&
                  myLocale.languageCode != "en") {
                myLocale = const Locale("de");
              }
              BlocProvider.of<AppSettingCubit>(context)
                  .changeLocal(locale: myLocale);
            }
            return GestureDetector(
              onTap: () {
                Utils.hideKeyboard(context);
              },
              child: GetMaterialApp(
                title: AppConfigs.appName,
                theme: AppThemes(
                  isDarkMode: false,
                  primaryColor: state.primaryColor,
                ).theme,
                darkTheme: AppThemes(
                  isDarkMode: true,
                  primaryColor: state.primaryColor,
                ).theme,
                navigatorKey: navigatorKey,
                themeMode: state.themeMode,
                initialRoute: RouteConfig.splash,
                getPages: RouteConfig.getPages,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate,
                ],
                locale: state.locale,
                supportedLocales: S.delegate.supportedLocales,
              ),
            );
          },
        ),
      ),
    );
  }
}
