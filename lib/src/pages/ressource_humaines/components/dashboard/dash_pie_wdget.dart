import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/rh/agent_count_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';

class DashRHPieWidget extends StatefulWidget {
  const DashRHPieWidget({Key? key, required this.controller}) : super(key: key);
  final PersonnelsController controller;

  @override
  State<DashRHPieWidget> createState() => _DashRHPieWidgetState();
}

class _DashRHPieWidgetState extends State<DashRHPieWidget> {
    TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SizedBox(
      width: MediaQuery.maybeOf(context)!.size.width / 1.1,
      child: Card(
        elevation: 6,
        child: SfCircularChart(
            enableMultiSelection: true,
            title: ChartTitle(
                text: 'Sexe',
                textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
            legend: Legend(isVisible: true, isResponsive: true),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<AgentPieChartModel, String>(
                  dataSource: widget.controller.agentPieChartList, 
                  xValueMapper: (AgentPieChartModel data, _) => data.sexe,
                  yValueMapper: (AgentPieChartModel data, _) => data.count)
            ]),
      ),
    );
  }
}
