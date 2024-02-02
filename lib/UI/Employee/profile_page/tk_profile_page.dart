import 'package:flutter/material.dart';
import 'package:flutter_base/UI/Employee/profile_page/tk_profile_cubit.dart';
import 'package:flutter_base/UI/widgets/textfields/app_circular_progress_indicator.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/entities/user/profile_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/tk_user_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/router/route_config.dart';

import 'package:flutter_base/ui/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class TkProfilePage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const TkProfilePage({
    Key? key, required arguments,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // cua logout
        final repo = RepositoryProvider.of<UserRepository>(context);
        //cua profile
        final repoq = RepositoryProvider.of<TKUserRepository>(context);

        //return TkProfileCubit(repo, repoq);
        return TkProfileCubit(repo, repoq);
      },
      child: const TkProfileChildPage(),
    );
  }
}

class TkProfileChildPage extends StatefulWidget {
  const TkProfileChildPage({Key? key}) : super(key: key);

  @override
  State<TkProfileChildPage> createState() => _TkProfileChildPageState();
}

class _TkProfileChildPageState extends State<TkProfileChildPage> {
  late final TkProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: false,
        title: 'S.current.profile',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: BlocBuilder<TkProfileCubit, TkProfileState>(
        buildWhen: (pre, cur) => pre.getProfileStatus != cur.getProfileStatus,
        builder: (context, state) {
          if (state.getProfileStatus == LoadStatus.loading) {
            return const SizedBox(
              child: Center(
                child: AppCircularProgressIndicator(
                  color: AppColors.tkPrimary,
                ),
              ),
            );
          }
          if (state.getProfileStatus == LoadStatus.failure ||
              state.profile == null) {
            return Center(
              child: Text(
                'S.current.somethings_went_wrong',
                style: AppTextStyle.blackS14Bold,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Stack(
                children: [
                  //_userInfo(state.profile?.user),
                  _avatarWidget(state.profile?.user?.profileImage)
                ],
              ),
              const SizedBox(height: 30),

              //Dayoff + remaining + working hours + overtime
              //  _workingTime(state.profile?.essentials),

              const SizedBox(height: 30),

              //change password
              _itemMenu('S.current.change_password', AppImages.icTkLock,
                  iconBgColor: const Color(0xffF3B7B7), onTap: () {
                //Get.toNamed(
                // RouteConfig.tkChangePassword,
                // );
              }),
              const SizedBox(height: 15),

              //LOGOUT
              _itemMenu(
                ' S.current.sign_out',
                AppImages.icTkLogout,
                onTap: () {
                  _cubit.signOut();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _itemMenu(String title, String iconName,
      {Color? iconBgColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFD3F7FF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.veryLightGrey,
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBgColor ?? const Color(0xffADD5EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(iconName),
            ),
            const SizedBox(width: 20),
            Text(title, style: AppTextStyle.blackS20Medium)
          ],
        ),
      ),
    );
  }

  Widget _userInfo(UserEntity? userInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20).copyWith(top: 50),
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonBGWhite,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xffA8D5E4),
            Colors.white,
          ],
          stops: [0.0, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            userInfo?.fullName ?? S.current.updating,
            style: AppTextStyle.blackS22W800,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userInfo?.essentialsDepartmentName ?? S.current.updating,
                style: AppTextStyle.greyS16,
              ),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const ShapeDecoration(
                  color: Color(0xFF9BAED4),
                  shape: OvalBorder(),
                ),
              ),
              Text(
                userInfo?.essentialsDesignationName ?? S.current.updating,
                style: AppTextStyle.greyS16,
              ),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const ShapeDecoration(
                  color: Color(0xFF9BAED4),
                  shape: OvalBorder(),
                ),
              ),
              Text(
                userInfo?.joined ?? S.current.updating,
                style: AppTextStyle.greyS16,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset(AppImages.icTkPhone),
                  const SizedBox(width: 5),
                  Text(
                    userInfo?.contactNumber ?? S.current.updating,
                    style: AppTextStyle.greyS14,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Image.asset(AppImages.icTkMail),
                  const SizedBox(width: 5),
                  Text(
                    userInfo?.email ?? S.current.updating,
                    style: AppTextStyle.greyS14,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _avatarWidget(String? url) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(color: Colors.white, width: 5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey929292,
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: AppCacheImage(
          url: url ?? "",
          borderRadius: 60,
        ),
      ),
    );
  }

  Widget _workingTime(Essentials? essentials) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F0FE),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: AppColors.veryLightGrey,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // number of day off
          _workInfo(
            'S.current.number_of_day_off',
            (essentials?.totalLeave ?? 0).toString(),
          ),

          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          //remaining ...
          _workInfo(
            ' S.current.remaining_days_off',
            (essentials?.totalLeaveRemaining ?? 0).toString(),
          ),

          //total working hours
          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          _workInfo(
            ' S.current.working_hours',
            (essentials?.totalWorkingHours ?? 0).toString(),
          ),

          //overtime
          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          _workInfo(
            'S.current.overtime',
            (essentials?.totalWorkingHoursExcessDeficiency ?? 0).toString(),
            contentColor: AppColors.green04B035,
          ),

          //overtime
        ],
      ),
    );
  }

  Widget _workInfo(String title, String content, {Color? contentColor}) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.greyS12.copyWith(color: AppColors.color697082),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: AppTextStyle.blackS20Bold.copyWith(
            color: contentColor,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
