import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meas/widgets/images/app_cache_image.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
    VoidCallback? onBackPressed,
    String title = "",
    List<Widget> rightActions = const [],
    bool showBackButton = true,
  }) : super(
          key: key,
          title: Text(title),
          toolbarHeight: 50,
          leading: showBackButton
              ? IconButton(
                  onPressed: onBackPressed,
                  icon: const Icon(Icons.arrow_back_ios_rounded))
              : null,
          actions: rightActions,
        );
}

class CommonAppBar extends AppBar {
  CommonAppBar({
    Key? key,
    String? title,
    bool? hasLeadingIcon,
    bool? centerTitle,
    VoidCallback? onSearchPressed,
    VoidCallback? onLeadingPressed,
    List<Widget>? actions,
    Widget? leadingIcon,
    Widget? titleWidget,
  }) : super(
          backgroundColor: Color(0xff663300),
          key: key,
          title: titleWidget ??
              Text(
                title ?? "",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.left,
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
                        Icons.arrow_back_ios_new_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : null),
          toolbarHeight: 40,
          centerTitle: centerTitle ?? false,
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

class CommonAppBarWithImage extends AppBar {
  CommonAppBarWithImage({
    Key? key,
    String? title,
    bool? hasLeadingIcon,
    bool? centerTitle,
    VoidCallback? onSearchPressed,
    VoidCallback? onLeadingPressed,
    List<Widget>? actions,
    required String imageUrl,
  }) : super(
          backgroundColor: Color(0xff663300),
          key: key,
          title: Stack(
            children: [
              AppCacheImage(
                url: imageUrl,
                width: 35,
                height: 35,
                borderRadius: 20,
              ),
              const SizedBox(width: 10),
              Text(
                title ?? "",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          elevation: 0,
          leading: hasLeadingIcon ?? true
              ? IconButton(
                  onPressed: () {
                    onLeadingPressed?.call();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              : null,
          toolbarHeight: 40,
        );
}
