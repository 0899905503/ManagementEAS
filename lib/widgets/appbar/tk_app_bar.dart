import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meas/common/app_dimens.dart';

class TKCommonAppBar extends AppBar {
  TKCommonAppBar({
    Key? key,
    String? title,
    bool? hasLeadingIcon,
    bool? centerTitle,
    VoidCallback? onSearchPressed,
    VoidCallback? onLeadingPressed,
    List<Widget>? actions,
    Widget? leadingIcon,
  }) : super(
          backgroundColor: Color(0xff663300),
          key: key,
          title: Center(
            child: Text(
              title ?? "",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          elevation: 0,
          leading: leadingIcon ??
              ((hasLeadingIcon ?? true)
                  ? IconButton(
                      onPressed: () {
                        onLeadingPressed?.call();
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : null),
          toolbarHeight: AppDimens.appBarHeight,
          centerTitle: centerTitle ?? true,
          actions: actions ??
              [
                if (hasLeadingIcon ?? true) ...[
                  const Icon(
                    Icons.notifications_active_rounded,
                    size: 30,
                    color: Colors.transparent,
                  ),
                  const SizedBox(width: 15),
                ]
              ],
        );
}
