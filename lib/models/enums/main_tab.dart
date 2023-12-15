import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';

enum MainTab {
  home,
  checkIn,
  workOffHistory,
  profile;

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icTKHomeMenuInActive),
          activeIcon: Image.asset(AppImages.icTKHomeMenuActive),
          label: "Home",
        );
      case MainTab.checkIn:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icTKTimekeepingMenuInActive),
          activeIcon: Image.asset(AppImages.icTKTimekeepingMenuActive),
          label: "Movies",
        );
      case MainTab.workOffHistory:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icTKCalendarMenuInActive),
          activeIcon: Image.asset(AppImages.icTKCalendarMenuActive),
          label: "Widgets",
        );
      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icTKPersonMenuInActive),
          activeIcon: Image.asset(AppImages.icTKPersonMenuActive),
          label: "Profile",
        );
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.checkIn:
        return 'Movies';
      case MainTab.workOffHistory:
        return 'Widgets';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
