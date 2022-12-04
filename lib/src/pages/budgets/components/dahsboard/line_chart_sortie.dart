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
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child:  _buildStackedLineChart()

      // SfCartesianChart(primaryXAxis: DateTimeAxis(
      //     dateFormat: DateFormat.M(),
      //   ), series: <ChartSeries>[
      //   // Renders line chart
      //   LineSeries<LigneBudgetaireModel, DateTime>(
      //       dataSource: widget.ligneBudgetaireList,
      //       xValueMapper: (LigneBudgetaireModel item, _) => item.created,
      //       yValueMapper: (LigneBudgetaireModel item, _) => item.caisseSortie),
      //   LineSeries<LigneBudgetaireModel, DateTime>(
      //       dataSource: widget.ligneBudgetaireList,
      //       xValueMapper: (LigneBudgetaireModel item, _) => item.created,
      //       yValueMapper: (LigneBudgetaireModel item, _) => item.banqueSortie),
      //   LineSeries<LigneBudgetaireModel, DateTime>(
      //       dataSource: widget.ligneBudgetaireList,
      //       xValueMapper: (LigneBudgetaireModel item, _) => item.created,
      //       yValueMapper: (LigneBudgetaireModel item, _) => item.finExterieurSortie),
      // ]),
    );
  }


   /// Returns the cartesian stacked line chart.
  SfCartesianChart _buildStackedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Monthly expense of a family'),
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        // labelRotation: isCardView ? 0 : -45,
      ),
      primaryYAxis: NumericAxis(
          maximum: 200,
          axisLine: const AxisLine(width: 0),
          labelFormat: r'${value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  /// Returns the list of chart seris which need to render
  /// on the stacked line chart.
  List<StackedLineSeries<LigneBudgetaireModel, String>> _getStackedLineSeries() {
    return <StackedLineSeries<LigneBudgetaireModel, String>>[
      StackedLineSeries<LigneBudgetaireModel, String>(
          dataSource: widget.ligneBudgetaireList,
          xValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.nomLigneBudgetaire,
          yValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.caisseSortie,
          name: 'Father',
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<LigneBudgetaireModel, String>(
          dataSource: widget.ligneBudgetaireList,
          xValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.nomLigneBudgetaire,
          yValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.banqueSortie,
          name: 'Mother',
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<LigneBudgetaireModel, String>(
          dataSource: widget.ligneBudgetaireList,
          xValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.nomLigneBudgetaire,
          yValueMapper: (LigneBudgetaireModel dataItem, _) => dataItem.finExterieurSortie,
          name: 'Son',
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }


  
}
