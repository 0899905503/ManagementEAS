import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meas/UI/Homepage/home_page_view.dart';

import 'package:meas/utils/enums/main_tab.dart';

import 'main_model.dart';

class TkMainViewModel extends ChangeNotifier {
  final TkMainCubit _cubit;

  TkMainViewModel(this._cubit, cubit, {required int selectedIndex});

  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    //maintab dinh dang cho cac bottom navigator bar item
    MainTab.home,
    MainTab.checkIn,
    MainTab.workOffHistory,
    MainTab.profile,
  ];
  int get selectedIndex => _cubit.state.selectedIndex;

  void loadInitialData() {
    _cubit.loadInitialData();
  }

  void switchTab(int index) {
    _cubit.switchTap(index);
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void dispose() {
    _cubit.close();
    super.dispose();
  }
}

class navigatorBarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
}
