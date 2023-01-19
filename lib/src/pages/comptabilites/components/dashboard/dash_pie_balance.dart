import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/utils/list_colors.dart'; 

class ChartPieBalance extends StatefulWidget {
  const ChartPieBalance({Key? key, required this.balanceChartPieList}) : super(key: key);
  final List<BalancePieChartModel> balanceChartPieList;

  @override
  State<ChartPieBalance> createState() => _ChartPieBalanceState();
}

class _ChartPieBalanceState extends State<ChartPieBalance> {
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
      child: SfCircularChart(
          enableMultiSelection: true,
          title: ChartTitle(
              text: 'Comptes',
              textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
          legend: Legend(isVisible: true, isResponsive: true),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<BalancePieChartModel, String>(
                dataSource: widget.balanceChartPieList,
                // pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (BalancePieChartModel data, _) => data.comptes,
                yValueMapper: (BalancePieChartModel data, _) => data.count)
          ],
          palette : listColors
        ),
    );
  }
}
