import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/api/finances/caisse_api.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/charts/courbe_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/finances/caisse_model.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';

class CourbeCaisseMounth extends StatefulWidget {
  const CourbeCaisseMounth({Key? key}) : super(key: key);

  @override
  State<CourbeCaisseMounth> createState() => _CourbeCaisseMounthState();
}

class _CourbeCaisseMounthState extends State<CourbeCaisseMounth> {
  final CaisseController controller = Get.put(CaisseController());
  List<CourbeChartModel> dataList1 = [];
  // List<CourbeChartModel> dataList2 = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // loadData();
    super.initState();
  }

  // void loadData() async {
  //   List<CourbeChartModel> data1 =
  //       await CaisseApi().getAllDataMouthEncaissement();
  //   // List<CourbeChartModel> data2 =
  //   //     await CaisseApi().getAllDataMouthDecaissement();
  //   if (mounted) {
  //     setState(() {
  //       dataList1 = data1;
  //       // dataList2 = data2;
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
            text: "Caisse par mois",
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
  List<LineSeries> _getDefaultLineSeries() {
    return <LineSeries>[
      LineSeries<CaisseModel, num>(
          dataSource: controller.caisseList,
          name: 'Encaissements',
          xValueMapper: (CaisseModel dataItem, _) => int.parse(
              DateFormat("MM").format(dataItem.created)),
          yValueMapper: (CaisseModel dataItem, _) => int.parse(dataItem.montantEncaissement),
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<CaisseModel, num>(
          dataSource: controller.caisseList,
          name: 'Décaissements',
          xValueMapper: (CaisseModel dataItem, _) => int.parse(
              DateFormat("MM").format(dataItem.created)),
          yValueMapper: (CaisseModel dataItem, _) => int.parse(dataItem.montantDecaissement),
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}
