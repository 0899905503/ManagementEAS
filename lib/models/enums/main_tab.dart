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
          icon: Image.asset(AppImages.icHomeBar),
          activeIcon: Image.asset(AppImages.icHomeBar),
          label: "Home",
        );
      case MainTab.checkIn:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icClockBar),
          activeIcon: Image.asset(AppImages.icClockBar),
          label: "Movies",
        );
      case MainTab.workOffHistory:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icCalendarBar),
          activeIcon: Image.asset(AppImages.icCalendarBar),
          label: "Widgets",
        );
      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: Image.asset(AppImages.icProfileBar),
          activeIcon: Image.asset(AppImages.icProfileBar),
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
