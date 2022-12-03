import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; 
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';

class LineChartSortie extends StatefulWidget {
  const LineChartSortie({super.key, required this.ligneBudgetaireList});
  final List<LigneBudgetaireModel> ligneBudgetaireList;

  @override
  State<LineChartSortie> createState() => _LineChartSortieState();
}

class _LineChartSortieState extends State<LineChartSortie> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: 
      
      // SfSparkLineChart(
      //   //Enable the trackball
      //   trackball: const SparkChartTrackball(
      //       activationMode: SparkChartActivationMode.tap),
      //   //Enable marker
      //   marker: const SparkChartMarker(
      //       displayMode: SparkChartMarkerDisplayMode.all),
      //   //Enable data label
      //   labelDisplayMode: SparkChartLabelDisplayMode.all,
      //   data: widget.ligneBudgetaireList.map((e) => e.banqueSortie).toList(),
      // )
      
      
      SfCartesianChart(primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.M(),
        ), series: <ChartSeries>[
        // Renders line chart
        LineSeries<LigneBudgetaireModel, DateTime>(
            dataSource: widget.ligneBudgetaireList,
            xValueMapper: (LigneBudgetaireModel item, _) => item.created,
            yValueMapper: (LigneBudgetaireModel item, _) => item.caisseSortie),
        LineSeries<LigneBudgetaireModel, DateTime>(
            dataSource: widget.ligneBudgetaireList,
            xValueMapper: (LigneBudgetaireModel item, _) => item.created,
            yValueMapper: (LigneBudgetaireModel item, _) => item.banqueSortie),
        LineSeries<LigneBudgetaireModel, DateTime>(
            dataSource: widget.ligneBudgetaireList,
            xValueMapper: (LigneBudgetaireModel item, _) => item.created,
            yValueMapper: (LigneBudgetaireModel item, _) => item.finExterieurSortie),
      ]),
    );
  }
}
