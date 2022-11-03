import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/vente_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/dashboard/dashboard_com_marketing_controller.dart';

class ArticlePlusVendus extends StatefulWidget {
  const ArticlePlusVendus({Key? key, required this.controller})
      : super(key: key);
  final DashboardcomController controller;

  @override
  State<ArticlePlusVendus> createState() => _ArticlePlusVendusState();
}

class _ArticlePlusVendusState extends State<ArticlePlusVendus> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: SfCartesianChart(
        title: ChartTitle(
            text: 'Produits les plus vendus',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        legend: Legend(
            position: Responsive.isDesktop(context)
                ? LegendPosition.right
                : LegendPosition.bottom,
            isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<VenteChartModel, String>(
              name: 'Produits',
              dataSource: widget.controller.venteChartModel,
              sortingOrder: SortingOrder.descending,
              xValueMapper: (VenteChartModel gdp, _) => gdp.idProductCart,
              yValueMapper: (VenteChartModel gdp, _) => gdp.count,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(isVisible: false),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: '10 produits les plus vendus')),
      ),
    );
  }
}
