import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wm_solution/src/api/finances/banque_api.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/charts/courbe_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CourbeBanqueMounth extends StatefulWidget {
  const CourbeBanqueMounth({Key? key}) : super(key: key);

  @override
  State<CourbeBanqueMounth> createState() => _CourbeBanqueMounthState();
}

class _CourbeBanqueMounthState extends State<CourbeBanqueMounth> {
  List<CourbeChartModel> dataList1 = [];
  List<CourbeChartModel> dataList2 = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    Timer.periodic(const Duration(milliseconds: 500), (t) {
      setState(() {
        loadData();
      });
      t.cancel();
    });
    super.initState();
  }

  void loadData() async {
    List<CourbeChartModel> data1 = await BanqueApi().getAllDataMouthDepot();
    List<CourbeChartModel> data2 = await BanqueApi().getAllDataMouthRetrait();
    if (mounted) {
      setState(() {
        dataList1 = data1;
        dataList2 = data2;
      });
    }
  }

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
            text: "Banque par mois",
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
  List<LineSeries<CourbeChartModel, num>> _getDefaultLineSeries() {
    return <LineSeries<CourbeChartModel, num>>[
      LineSeries<CourbeChartModel, num>(
          dataSource: dataList1,
          name: 'Retrait',
          xValueMapper: (CourbeChartModel sales, _) => int.parse(sales.created),
          yValueMapper: (CourbeChartModel sales, _) => sales.sum,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<CourbeChartModel, num>(
          dataSource: dataList2,
          name: 'Depôt',
          xValueMapper: (CourbeChartModel sales, _) => int.parse(sales.created),
          yValueMapper: (CourbeChartModel sales, _) => sales.sum,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}
