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
    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.all(p8),
      child: Material(
        elevation: 10.0,
        child: SfCircularChart(
          palette: _lightColors,
            title: ChartTitle(
                text: "Materiels",
                textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
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

   
final _lightColors = [
  Colors.blueAccent.shade700,
    Colors.brown.shade700,
    Colors.cyanAccent.shade700,
    Colors.grey.shade700,
    Colors.indigoAccent.shade700,
    Colors.redAccent.shade700,
    Colors.deepPurple.shade700,
    Colors.amber.shade700,
    Colors.lightGreen.shade700,
    Colors.lightBlue.shade700,
    Colors.orange.shade700,
    Colors.pinkAccent.shade700,
    Colors.tealAccent.shade700,
    Colors.purpleAccent.shade700,
    Colors.limeAccent.shade700,
    
  ];
}
