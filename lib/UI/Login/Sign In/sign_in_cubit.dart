import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';

import 'package:flutter_base/global/global_data.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';

import 'package:flutter_base/utils/error_utils.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  final AppCubit appCubit;

  SignInCubit({
    required this.authRepo,
    required this.appCubit,
  }) : super(const SignInState());

  void changeUsername({required String username}) {
    emit(state.copyWith(username: username));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signIn(String locale) async {
    final username = state.username ?? '';
    final password = state.password ?? '';
    if (username.isEmpty || password.isEmpty) {
      AppSnackbar.showError(message: "empty_field");
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signIn(username, password, locale);
      if (result.data != null) {
        if (state.isRememberAccount) {
          SharedPreferencesHelper.setRememberAccount();
          SharedPreferencesHelper.setLoginResponse(result.data!);
        }
        GlobalData.instance.loginResponse = result.data;
        SharedPreferencesHelper.setApiTokenKey(
            result.data?.user?.apiToken ?? "");
        emit(state.copyWith(signInStatus: LoadStatus.success));
        appCubit.updateLanguage(locale);
        if (result.data?.appPermissions?.inventory == true &&
            result.data?.appPermissions?.essentials == true) {
          Get.offNamed(RouteConfig.chooseAppScreen);
        } else if (result.data?.appPermissions?.inventory == true) {
          Get.offNamed(RouteConfig.home);
        } else if (result.data?.appPermissions?.essentials == true) {
          Get.offNamed(RouteConfig.tkHomePage);
        } else {
          Get.offNamed(RouteConfig.home);
        }
      } else {
        AppDialog.commonDialog(message: "somethings_went_wrong");
      }
    } catch (error) {
      logger.e(error);
      AppDialog.commonDialog(
        message: ErrorUtils.errorToString(error: error),
      );
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }

  void rememberAccount(bool value) {
    emit(state.copyWith(isRememberAccount: value));
  }

  void showOrHidePassword() {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }
}
