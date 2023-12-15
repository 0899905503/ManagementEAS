import 'package:flutter/material.dart';
import 'package:flutter_base/UI/Employee/home_page/home_page.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/enums/main_tab.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_cubit.dart';

class TkMainArguments {
  String param;

  TkMainArguments({
    required this.param,
  });
}

class TkMainPage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const TkMainPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TkMainCubit();
      },
      child: const TkMainChildPage(),
    );
  }
}

class TkMainChildPage extends StatefulWidget {
  const TkMainChildPage({Key? key}) : super(key: key);

  @override
  State<TkMainChildPage> createState() => _TkMainChildPageState();
}

class _TkMainChildPageState extends State<TkMainChildPage> {
  late final TkMainCubit _cubit;
  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    MainTab.home,
    MainTab.checkIn,
    MainTab.workOffHistory,
    MainTab.profile,
  ];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    pageList = [
      const Homepage(),
      // const TkHomePage(),
      // const TkTimekeepingPage(),
      // const TkWorkOffHistoryPage(),
      // const TkProfilePage(),
    ];
    //Page controller
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        _cubit.switchTap(index);
      },
      children: pageList,
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return BlocConsumer<TkMainCubit, TkMainState>(
      bloc: _cubit,
      listenWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      listener: (context, state) {
        pageController.jumpToPage(state.selectedIndex);
      },
      buildWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.dividerB5E6ED,
              width: double.infinity,
              height: 1.5,
            ),
            BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: theme.appBarTheme.backgroundColor,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: state.selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: theme.indicatorColor,
              items: tabs.map((e) => e.tab).toList(),
              onTap: (index) {
                _cubit.switchTap(index);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
