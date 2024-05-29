import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_view.dart';

import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:provider/provider.dart';

class SalaryRankArguments {
  String param;

  SalaryRankArguments({
    required this.param,
  });
}

class SalaryRankPage extends StatelessWidget {
  // final SalaryRankArguments arguments;

  const SalaryRankPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: SalaryRankChildPage()),
      ),
    );
  }
}

class SalaryRankChildPage extends StatefulWidget {
  const SalaryRankChildPage({Key? key}) : super(key: key);

  @override
  State<SalaryRankChildPage> createState() => _SalaryRankChildPageState();
}

class _SalaryRankChildPageState extends State<SalaryRankChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;

  late SalaryDetailViewModel salaryDetailViewModel =
      SalaryDetailViewModelProvider.of(context);
  List<Map<String, dynamic>> ranks = [];
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();

    // Không truy cập SalaryDetailViewModel ở đây
    _selectedDate =
        DateTime.parse(Get.arguments['date'] ?? DateTime.now().toString());
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Truy cập SalaryDetailViewModelProvider ở đây sau khi dependencies hoàn thành
    var salaryRankDetailViewModel = Provider.of<SalaryDetailViewModel>(context);

    // Fetch dữ liệu khi dependencies thay đổi
    fetchSalaryRankDetail(salaryRankDetailViewModel);
  }

  Future<void> fetchSalaryRankDetail(
      SalaryDetailViewModel salaryRankDetailViewModel) async {
    try {
      List<Map<String, dynamic>> data =
          await salaryRankDetailViewModel.showSalariesByMonthAndYear(
        int.parse(DateFormat(AppConfigs.year).format(_selectedDate)),
        int.parse(DateFormat(AppConfigs.month).format(_selectedDate)),
      );
      setState(() {
        ranks = data;
        _streamController.add(data);
      });
    } catch (e) {
      print('Error fetching salary detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy tham số từ đường dẫn
    var arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Kiểm tra nếu arguments không null và có giá trị 'date'
    if (arguments != null && arguments.containsKey('date')) {
      _selectedDate = DateTime.parse(arguments['date']);
    }
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "SalaryRank",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            ranks = snapshot.data!;
            // Chuyển đổi kiểu dữ liệu của trường 'tenngach' sang String
            List<Map<String, dynamic>> convertedData =
                snapshot.data!.map((item) {
              return {
                'tennv': item['tennv'].toString(),
                'tongluong': double.parse(item['tongluong'].toString()),
              };
            }).toList();
            return Center(
              child:
                  //Text(convertedData.toString()),

                  _buildSalaryRankChart(convertedData),
            );
          }
        },
      ),
    );
  }
}

Widget _buildSalaryRankChart(List<Map<String, dynamic>> SalaryRankData) {
  List<SalaryRank> data = [];

  // Chuyển đổi dữ liệu và thêm vào danh sách
  for (var item in SalaryRankData) {
    String name = item['tennv'].toString();
    // Kiểm tra nếu giá trị 'tongluong' không phải là null và có thể chuyển đổi sang double
    if (item['tongluong'] != null && item['tongluong'] is num) {
      double? tongluong = item['tongluong']; // Chuyển đổi sang int
      if (tongluong != null) {
        data.add(SalaryRank(name, tongluong));
      } else {
        print('Invalid tongluong value: ${item['tongluong']}');
      }
    } else {
      // Xử lý trường hợp giá trị không hợp lệ hoặc null
      print('Invalid tongluong value1: ${item['tongluong']}');
    }
  }

  return SizedBox(
    height: 400,
    width: 800,
    child: charts.BarChart(
      [
        charts.Series<SalaryRank, String>(
          id: 'SalaryRank',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.chart),
          domainFn: (SalaryRank rank, _) => rank.name,
          measureFn: (SalaryRank rank, _) => rank.Salary,
          data: data,
        ),
      ],
      animate: true,
      // barRendererDecorator: charts.BarLabelDecorator<String>(
      //   labelPosition:
      //       charts.BarLabelPosition.outside, // Đặt vị trí chữ ở bên ngoài cột
      //   // labelAnchor: charts.BarLabelAnchor.end, // Đặt vị trí neo của chữ ở cuối cột
      // ),
      domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec()),
    ),
  );
}

class SalaryRank {
  final String name;
  final double Salary;

  SalaryRank(this.name, this.Salary);
}
