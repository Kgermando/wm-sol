import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/charts/chart_multi.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_caisse_controller.dart';

class ChartCaisse extends StatefulWidget {
  const ChartCaisse({Key? key, required this.chartCaisseController})
      : super(key: key);
  final ChartCaisseController chartCaisseController;

  @override
  State<ChartCaisse> createState() => _ChartCaisseState();
}

class _ChartCaisseState extends State<ChartCaisse> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
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
    final headline6 = Theme.of(context).textTheme.headline6;
    return SfCartesianChart(
        title: ChartTitle(
            text: "Caisses",
            textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
        plotAreaBorderWidth: 0,
        tooltipBehavior: _tooltipBehavior,
        legend: Legend(
            isVisible: true,
            isResponsive: true,
            position: Responsive.isDesktop(context)
                ? LegendPosition.right
                : LegendPosition.bottom),
        primaryXAxis: CategoryAxis(isVisible: true),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(text: 'Transations 2'),
          numberFormat:
              NumberFormat.compactCurrency(symbol: '\$ ', decimalDigits: 1),
        ),
        series: <ChartSeries<ChartFinanceModel, String>>[
          ColumnSeries<ChartFinanceModel, String>(
            dataSource: widget.chartCaisseController.chartList,
            xValueMapper: (ChartFinanceModel data, _) => data.name,
            yValueMapper: (ChartFinanceModel data, _) => data.depot,
            name: 'Encaissements',
            color: const Color.fromARGB(255, 31, 224, 118),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<ChartFinanceModel, String>(
            dataSource: widget.chartCaisseController.chartList,
            xValueMapper: (ChartFinanceModel data, _) => data.name,
            yValueMapper: (ChartFinanceModel data, _) => data.retrait,
            name: 'Décaissements',
            color: const Color.fromARGB(216, 202, 43, 22),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ]);
  }
}
