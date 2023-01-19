import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart';
import 'package:wm_solution/src/utils/list_colors.dart';

class DashMarketingPieWidget extends StatefulWidget {
  const DashMarketingPieWidget({Key? key, required this.controller})
      : super(key: key);
  final AnnuairePieController controller;

  @override
  State<DashMarketingPieWidget> createState() => _DashMarketingPieWidgetState();
}

class _DashMarketingPieWidgetState extends State<DashMarketingPieWidget> {
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
            text: 'Annuaire',
              textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
          legend: Legend(isVisible: true, isResponsive: true),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            PieSeries<CountPieChartModel, String>(
              dataSource: widget.controller.annuairePieList,
              xValueMapper: (CountPieChartModel data, _) => data.categorie,
              yValueMapper: (CountPieChartModel data, _) => data.count
            ),
          ],
          palette: listColors,
        ),
      ),
    );
  }
}
