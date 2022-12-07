import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/utils/list_colors.dart'; 

class ChartBarActions extends StatefulWidget {
  const ChartBarActions({super.key, required this.state});
  final List<ActionnaireModel> state;

  @override
  State<ChartBarActions> createState() => _ChartBarActionsState();
}

class _ChartBarActionsState extends State<ChartBarActions> {
  late TooltipBehavior _tooltipBehavior;
  

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card( 
      child: SfCartesianChart(
        title: ChartTitle(
            text: 'Actions',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        legend: Legend(
            position: Responsive.isDesktop(context)
                ? LegendPosition.right
                : LegendPosition.bottom,
            isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<ActionnaireModel, String>(
              name: 'Parts',
              pointColorMapper: (datum, index) =>
                  listColors[index % listColors.length],
              dataSource: widget.state,
              // sortingOrder: SortingOrder.descending,
              xValueMapper: (ActionnaireModel gdp, _) => "${gdp.prenom} ${gdp.nom} ${gdp.postNom}",
              yValueMapper: (ActionnaireModel gdp, _) => gdp.cotisations,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(isVisible: false),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: 'Cotisations actionnaires')),
      ),
    );
  }
}
