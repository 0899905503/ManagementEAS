import 'dart:async';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Salary_infor/salary_infor_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:provider/provider.dart';

class SalaryRankOnlyPersonArguments {
  String param;

  SalaryRankOnlyPersonArguments({
    required this.param,
  });
}

class SalaryRankOnlyPersonPage extends StatelessWidget {
  // final SalaryRankOnlyPersonArguments arguments;

  const SalaryRankOnlyPersonPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: SalaryRankOnlyPersonChildPage()),
      ),
    );
  }
}

class SalaryRankOnlyPersonChildPage extends StatefulWidget {
  const SalaryRankOnlyPersonChildPage({Key? key}) : super(key: key);

  @override
  State<SalaryRankOnlyPersonChildPage> createState() =>
      _SalaryRankOnlyPersonChildPageState();
}

class _SalaryRankOnlyPersonChildPageState
    extends State<SalaryRankOnlyPersonChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;

  SalaryInforViewModel salaryInforViewModel = SalaryInforViewModel();
  List<Map<String, dynamic>> ranks = [];
  int? userid;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    userid = Get.arguments['userId'];
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch dữ liệu khi dependencies thay đổi
    fetchUsers(userid!);
  }

  Future<void> fetchUsers(int userid) async {
    try {
      List<Map<String, dynamic>> salaryData =
          await salaryInforViewModel.getSalaryInfor(userid);
      setState(() {
        // Update the list of users
        ranks = salaryData;
        _streamController.add(salaryData);
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy tham số từ đường dẫn

    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Salary Rank MySelf",
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
                'thang': item['thang'].toString(),
                'tongluong': double.parse(item['tongluong'].toString()),
              };
            }).toList();
            return Center(
              child:
                  //Text(convertedData.toString()),
                  _buildSalaryRankOnlyPersonChart(convertedData),
            );
          }
        },
      ),
    );
  }
}

Widget _buildSalaryRankOnlyPersonChart(
    List<Map<String, dynamic>> SalaryRankOnlyPersonData) {
  List<SalaryRankOnlyPerson> data = [];

  // Chuyển đổi dữ liệu và thêm vào danh sách
  for (var item in SalaryRankOnlyPersonData) {
    String name = item['thang'].toString();
    // Kiểm tra nếu giá trị 'tongluong' không phải là null và có thể chuyển đổi sang double
    if (item['tongluong'] != null && item['tongluong'] is num) {
      double? tongluong = item['tongluong']; // Chuyển đổi sang int
      if (tongluong != null) {
        data.add(SalaryRankOnlyPerson(name, tongluong));
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
        charts.Series<SalaryRankOnlyPerson, String>(
          id: 'SalaryRankOnlyPerson',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.chart),
          domainFn: (SalaryRankOnlyPerson rank, _) => rank.name,
          measureFn: (SalaryRankOnlyPerson rank, _) => rank.Salary,
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

class SalaryRankOnlyPerson {
  final String name;
  final double Salary;

  SalaryRankOnlyPerson(this.name, this.Salary);
}
