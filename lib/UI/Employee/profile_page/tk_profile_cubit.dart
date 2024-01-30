import 'package:equatable/equatable.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/global/global_data.dart';
import 'package:flutter_base/models/entities/user/profile_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/network/ws_connector.dart';
import 'package:flutter_base/repositories/tk_user_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/utils/error_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

part 'tk_profile_state.dart';

class TkProfileCubit extends Cubit<TkProfileState> {
  TkProfileCubit(this.userRepository, this.tkUserRepository)
      : super(const TkProfileState());

  final UserRepository userRepository;
  final TKUserRepository tkUserRepository;

  Future<void> getProfile() async {
    emit(state.copyWith(getProfileStatus: LoadStatus.loading));
    try {
      final res = await tkUserRepository.getProfile();
      if (res != null && res.data != null) {
        emit(state.copyWith(
          getProfileStatus: LoadStatus.success,
          profile: res.data,
        ));
      } else {
        // Xử lý trường hợp giá trị trả về là null hoặc không có dữ liệu
        AppDialog.commonDialog(
          message: "Profile data is null or empty.",
        );
        emit(state.copyWith(getProfileStatus: LoadStatus.failure));
      }
    } catch (e) {
      AppDialog.commonDialog(
        message: ErrorUtils.errorToString(error: e),
      );
      emit(state.copyWith(getProfileStatus: LoadStatus.failure));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(logoutStatus: LoadStatus.loading));
    try {
      await userRepository.logout();
      await SharedPreferencesHelper.removeApiTokenKey();
      await SharedPreferencesHelper.removeRememberAccount();
      await SharedPreferencesHelper.removeLoginResponse();
      emit(state.copyWith(logoutStatus: LoadStatus.success));
      WsConnector.instance.unSubChannel(GlobalData.instance.channelName);
      Get.offNamed(RouteConfig.signIn);
    } catch (e) {
      AppDialog.commonDialog(message: ErrorUtils.errorToString(error: e));
      emit(state.copyWith(logoutStatus: LoadStatus.failure));
    }
  }
}
