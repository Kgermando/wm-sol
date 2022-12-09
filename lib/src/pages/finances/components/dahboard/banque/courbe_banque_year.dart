
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';

class CourbeBanqueYear extends StatefulWidget {
  const CourbeBanqueYear({Key? key}) : super(key: key);

  @override
  State<CourbeBanqueYear> createState() => _CourbeBanqueYearState();
}

class _CourbeBanqueYearState extends State<CourbeBanqueYear> {
  final BanqueController controller = Get.put(BanqueController());
  // List<CourbeChartModel> dataList1 = [];
  // List<CourbeChartModel> dataList2 = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    // _tooltipBehavior = TooltipBehavior(enable: true);

    // Timer.periodic(const Duration(milliseconds: 500), (t) {
    //   setState(() {
    //     loadData();
    //   });
    //   t.cancel();
    // });
    super.initState();
  }

  // void loadData() async {
  //   List<CourbeChartModel> data1 = await BanqueApi().getAllDataYearDepot();
  //   List<CourbeChartModel> data2 = await BanqueApi().getAllDataYearRetrait();
  //   if (mounted) {
  //     setState(() {
  //       dataList1 = data1;
  //       dataList2 = data2;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(p8),
      child: Material(elevation: 10.0, child: _buildAnimationLineChart()),
    );
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildAnimationLineChart() {
    return SfCartesianChart(
        title: ChartTitle(
            text: "Banque par an",
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        plotAreaBorderWidth: 0,
        tooltipBehavior: _tooltipBehavior,
        legend: Legend(
            isVisible: true,
            isResponsive: true,
            position: Responsive.isDesktop(context)
                ? LegendPosition.right
                : LegendPosition.bottom),
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(color: Colors.transparent),
            axisLine: const AxisLine(width: 0),
            minimum: 0,
            maximum: 100),
        series: _getDefaultLineSeries());
  }

 /// The method returns line series to chart.
  List<LineSeries<BanqueModel, num>> _getDefaultLineSeries() {
    return <LineSeries<BanqueModel, num>>[
      LineSeries<BanqueModel, num>(
          dataSource: controller.banqueList,
          name: 'Depôt',
          xValueMapper: (BanqueModel dataItem, _) =>
              int.parse(DateFormat("MM").format(dataItem.created)),
          yValueMapper: (BanqueModel dataItem, _) =>
              int.parse(dataItem.montantDepot),
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<BanqueModel, num>(
          dataSource: controller.banqueList,
          name: 'Retrait',
          xValueMapper: (BanqueModel dataItem, _) =>
              int.parse(DateFormat("MM").format(dataItem.created)),
          yValueMapper: (BanqueModel dataItem, _) =>
              int.parse(dataItem.montantRetrait),
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}
