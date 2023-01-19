import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/commercial/vente_chart_model.dart'; 
import 'package:wm_solution/src/utils/list_colors.dart';

class ArticlePlusVendus extends StatefulWidget {
  const ArticlePlusVendus(
      {Key? key, required this.state, required this.monnaieStorage})
      : super(key: key);
  final List<VenteChartModel> state;
  final MonnaieStorage monnaieStorage;

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
    final headline6 = Theme.of(context).textTheme.headline6;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        child: SfCartesianChart(
          title: ChartTitle(
              text: 'Produits les plus vendus',
              textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
          legend: Legend(
              position: Responsive.isDesktop(context)
                  ? LegendPosition.right
                  : LegendPosition.bottom,
              isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            // VenteChartModel
            BarSeries<VenteChartModel, String>(
                name: 'Produits',
                pointColorMapper: (datum, index) =>
                    listColors[index % listColors.length],
                dataSource: widget.state,
                // sortingOrder: SortingOrder.descending,
                xValueMapper: (VenteChartModel gdp, _) => gdp.idProductCart,
                yValueMapper: (VenteChartModel gdp, _) => gdp.count,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(isVisible: true),
          primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: '10 produits les plus vendus'), 
          ),
        ),
      ),
    );
  }
}
