import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/charts/chart_multi.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_banque_controller.dart';

class ChartBanque extends StatefulWidget {
  const ChartBanque(
      {Key? key,
      required this.chartBanqueController,
      required this.monnaieStorage})
      : super(key: key);
  final ChartBanqueController chartBanqueController;
  final MonnaieStorage monnaieStorage;

  @override
  State<ChartBanque> createState() => _ChartBanqueState();
}

class _ChartBanqueState extends State<ChartBanque> {
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

  /// Get the cartesian chart with line series
  SfCartesianChart _buildAnimationLineChart() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SfCartesianChart(
        title: ChartTitle(
            text: "Banques",
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
          title: AxisTitle(text: 'Transations 1'),
          numberFormat: NumberFormat.currency(
              symbol: '${widget.monnaieStorage.monney} ', decimalDigits: 1),
        ),
        series: <ChartSeries<ChartFinanceModel, String>>[
          ColumnSeries<ChartFinanceModel, String>(
            dataSource: widget.chartBanqueController.chartList,
            xValueMapper: (ChartFinanceModel data, _) => data.name,
            yValueMapper: (ChartFinanceModel data, _) => data.depot,
            name: 'Dépôt',
            color: const Color.fromRGBO(8, 142, 255, 1),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<ChartFinanceModel, String>(
            dataSource: widget.chartBanqueController.chartList,
            xValueMapper: (ChartFinanceModel data, _) => data.name,
            yValueMapper: (ChartFinanceModel data, _) => data.retrait,
            name: 'Retrait',
            color: const Color.fromARGB(255, 255, 107, 8),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ]);
  }
}
