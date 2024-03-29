import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/commercial/courbe_vente_gain_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';

class CourbeVenteGainMounth extends StatefulWidget {
  const CourbeVenteGainMounth({Key? key, required this.controller, required this.monnaieStorage})
      : super(key: key);
  final DashboardComController controller;
  final MonnaieStorage monnaieStorage;

  @override
  State<CourbeVenteGainMounth> createState() => _CourbeVenteGainMounthState();
}

class _CourbeVenteGainMounthState extends State<CourbeVenteGainMounth> {
  TooltipBehavior? _tooltipBehavior;

  bool? isCardView;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p8),
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: 'Courbe de Ventes mensuelles',
                textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
            // Enable legend
            legend: Legend(
                position: Responsive.isDesktop(context)
                    ? LegendPosition.right
                    : LegendPosition.bottom,
                isVisible: true),
            // Enable tooltip
            palette: const [
              Color.fromRGBO(73, 76, 162, 1),
              Color.fromRGBO(51, 173, 127, 1),
              Color.fromRGBO(244, 67, 54, 1)
            ],
            tooltipBehavior: _tooltipBehavior,
            primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              title: AxisTitle(text: DateFormat("MM-yyyy").format(DateTime.now())),
              numberFormat: NumberFormat.currency(           
                  symbol: '${widget.monnaieStorage.monney} ',
                  decimalDigits: 1),
            ),
            series: <LineSeries>[
              
              LineSeries<CourbeVenteModel, String>(
                name: 'Ventes',
                dataSource: widget.controller.venteMouthList,
                sortingOrder: SortingOrder.ascending,
                markerSettings: const MarkerSettings(isVisible: true),
                xValueMapper: (CourbeVenteModel ventes, _) => "Le ${ventes.created}",
                yValueMapper: (CourbeVenteModel ventes, _) =>
                    double.parse(ventes.sum.toStringAsFixed(2)),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries<CourbeGainModel, String>(
                name: 'Gains',
                dataSource: widget.controller.gainMouthList,
                sortingOrder: SortingOrder.ascending,
                markerSettings: const MarkerSettings(isVisible: true),
                xValueMapper: (CourbeGainModel ventes, _) =>
                    "Le ${ventes.created}",
                yValueMapper: (CourbeGainModel ventes, _) =>
                    double.parse(ventes.sum.toStringAsFixed(2)),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ]),
      ),
    );
  }
}
