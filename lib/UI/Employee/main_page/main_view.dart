import 'package:flutter/material.dart';
import 'package:meas/UI/Employee/main_page/main_viewmodel.dart';

class TkMainChildPage extends StatefulWidget {
  final TkMainViewModel viewModel;

  const TkMainChildPage({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<TkMainChildPage> createState() => _TkMainChildPageState();
}

class _TkMainChildPageState extends State<TkMainChildPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Selected Index: ${widget.viewModel.selectedIndex}'); // In log để kiểm tra

    return MaterialApp(
      home: Scaffold(
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.viewModel.pageController,
      onPageChanged: (index) {
        widget.viewModel.switchTab(index);
      },
      children: widget.viewModel.pageList,
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Color(0xff663300),
          width: double.infinity,
          height: 1.5,
        ),
        BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color(0xff663300),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.viewModel.selectedIndex,
          unselectedItemColor: Color(0xff663300),
          selectedItemColor: theme.indicatorColor,
          items: widget.viewModel.tabs.map((e) => e.tab).toList(),
          onTap: (index) {
            widget.viewModel.switchTab(index);
          },
        ),
      ],
    );
  }
}
