import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wm_solution/src/api/logistiques/materiels_api.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MaterielPie extends StatefulWidget {
  const MaterielPie({Key? key}) : super(key: key);

  @override
  State<MaterielPie> createState() => _MaterielPieState();
}

class _MaterielPieState extends State<MaterielPie> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<PieChartEnguinModel> dataList = [];
  Future<void> getData() async {
    var data = await MaterielsApi().getChartPie();
    if (mounted) {
      setState(() {
        dataList = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(p8),
      child: Material(
        elevation: 10.0,
        child: SfCircularChart(
            title: ChartTitle(
                text: "Materiels",
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
            legend: Legend(isVisible: true, isResponsive: true),
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<PieChartEnguinModel, String>(
                  dataSource: dataList,
                  // pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (PieChartEnguinModel data, _) => data.genre,
                  yValueMapper: (PieChartEnguinModel data, _) => data.count)
            ]),
      ),
    );
  }
}
