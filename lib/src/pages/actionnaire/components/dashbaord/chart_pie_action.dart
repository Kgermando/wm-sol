import 'package:flutter/material.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';

class ChartPieAction extends StatefulWidget {
  const ChartPieAction({super.key, required this.state});
  final List<ActionnaireModel> state;

  @override
  State<ChartPieAction> createState() => _ChartPieActionState();
}

class _ChartPieActionState extends State<ChartPieAction> {
     TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card( 
      child: SfCircularChart(
          enableMultiSelection: true,
          title: ChartTitle(
              text: 'Parts',
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          legend: Legend(isVisible: true, isResponsive: true),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<ActionnaireModel, String>(
                dataSource: widget.state,
                // pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ActionnaireModel data, _) => "${data.prenom} ${data.nom} ${data.postNom}",
                yValueMapper: (ActionnaireModel data, _) => data.cotisations)
          ]),
    );
  }
}