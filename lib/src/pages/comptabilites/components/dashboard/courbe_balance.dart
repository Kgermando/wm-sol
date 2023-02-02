import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';

class CourbeBalance extends StatefulWidget {
  const CourbeBalance({Key? key, required this.balanceSumList})
      : super(key: key);
  final List<BalanceChartModel> balanceSumList;

  @override
  State<CourbeBalance> createState() => _CourbeBalanceState();
}

class _CourbeBalanceState extends State<CourbeBalance> {
  final MonnaieStorage monnaieStorage = MonnaieStorage();
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Card(
      child: SfCartesianChart(
        title: ChartTitle(
            text: 'Balance',
            textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
        legend: Legend(
            position: Responsive.isDesktop(context)
                ? LegendPosition.right
                : LegendPosition.bottom,
            isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          ColumnSeries<BalanceChartModel, String>(
              name: 'Debit',
              dataSource: widget.balanceSumList,
              sortingOrder: SortingOrder.descending,
              xValueMapper: (BalanceChartModel gdp, _) => gdp.comptes,
              yValueMapper: (BalanceChartModel gdp, _) =>
                  double.parse(gdp.debit.toStringAsFixed(2)),
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true),
          ColumnSeries<BalanceChartModel, String>(
              name: 'Credit',
              dataSource: widget.balanceSumList,
              sortingOrder: SortingOrder.descending,
              xValueMapper: (BalanceChartModel gdp, _) => gdp.comptes,
              yValueMapper: (BalanceChartModel gdp, _) =>
                  double.parse(gdp.credit.toStringAsFixed(2)),
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(isVisible: true),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(text: 'Balance'),
          numberFormat: NumberFormat.currency(symbol: '${monnaieStorage.monney} ', decimalDigits: 1),
        ),
      ),
    );
  }
}
