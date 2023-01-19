import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wm_solution/src/api/logistiques/etat_materiel_api.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EtatMaterielPie extends StatefulWidget {
  const EtatMaterielPie({Key? key}) : super(key: key);

  @override
  State<EtatMaterielPie> createState() => _EtatMaterielPieState();
}

class _EtatMaterielPieState extends State<EtatMaterielPie> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<PieChartMaterielModel> dataList = [];
  Future<void> getData() async {
    var data = await EtatMaterielApi().getChartPieStatut();
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
                text: 'Statut materiels',
                textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
            legend: Legend(isVisible: true, isResponsive: true),
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<PieChartMaterielModel, String>(
                  dataSource: dataList,
                  // pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (PieChartMaterielModel data, _) => data.statut,
                  yValueMapper: (PieChartMaterielModel data, _) => data.count)
            ]),
      ),
    );
  }

  
final _lightColors = [
    Colors.amber.shade700,
    Colors.lightGreen.shade700,
    Colors.lightBlue.shade700,
    Colors.orange.shade700,
    Colors.pinkAccent.shade700,
    Colors.tealAccent.shade700,
    Colors.purpleAccent.shade700,
    Colors.limeAccent.shade700,
    Colors.blueAccent.shade700,
    Colors.brown.shade700,
    Colors.cyanAccent.shade700,
    Colors.grey.shade700,
    Colors.indigoAccent.shade700,
    Colors.redAccent.shade700,
    Colors.deepPurple.shade700
  ];

}
