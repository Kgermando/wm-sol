import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/commercial/courbe_vente_gain_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';

class CourbeVenteGainYear extends StatefulWidget {
  const CourbeVenteGainYear(
      {Key? key, required this.controller, required this.monnaieStorage})
      : super(key: key);
  final DashboardComController controller;
  final MonnaieStorage monnaieStorage;

  @override
  State<CourbeVenteGainYear> createState() => _CourbeVenteGainYearState();
}

class _CourbeVenteGainYearState extends State<CourbeVenteGainYear> {
  TooltipBehavior? _tooltipBehavior;

  bool? isCardView;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Icon(Icons.menu)],
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(
                  text: 'Courbe de Ventes par AN',
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
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
                title: AxisTitle(text: DateFormat("yyyy").format(DateTime.now())),
                numberFormat: NumberFormat.currency(
                    symbol: '${widget.monnaieStorage.monney} ',
                    decimalDigits: 1),
              ),
              series: <LineSeries>[
                LineSeries<CourbeGainModel, String>(
                  name: 'Gains',
                  dataSource: widget.controller.gainYearList,
                  sortingOrder: SortingOrder.ascending,
                  markerSettings: const MarkerSettings(isVisible: true),
                  xValueMapper: (CourbeGainModel ventes, _) {
                    String date = '';
                    if (ventes.created == '1') {
                      date = 'Janvier';
                    } else if (ventes.created == '2') {
                      date = 'Fevrier';
                    } else if (ventes.created == '3') {
                      date = 'Mars';
                    } else if (ventes.created == '4') {
                      date = 'Avril';
                    } else if (ventes.created == '5') {
                      date = 'Mai';
                    } else if (ventes.created == '6') {
                      date = 'Juin';
                    } else if (ventes.created == '7') {
                      date = 'Juillet';
                    } else if (ventes.created == '8') {
                      date = 'Août';
                    } else if (ventes.created == '9') {
                      date = 'Septembre';
                    } else if (ventes.created == '10') {
                      date = 'Octobre';
                    } else if (ventes.created == '11') {
                      date = 'Novembre';
                    } else if (ventes.created == '12') {
                      date = 'Décembre';
                    }
                    return date;
                  },
                  yValueMapper: (CourbeGainModel ventes, _) =>
                      double.parse(ventes.sum.toStringAsFixed(2)),
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
                LineSeries<CourbeVenteModel, String>(
                  name: 'Ventes',
                  dataSource: widget.controller.venteYearList,
                  sortingOrder: SortingOrder.ascending,
                  markerSettings: const MarkerSettings(isVisible: true),
                  xValueMapper: (CourbeVenteModel ventes, _) {
                    String date = '';
                    if (ventes.created == '1') {
                      date = 'Janvier';
                    } else if (ventes.created == '2') {
                      date = 'Fevrier';
                    } else if (ventes.created == '3') {
                      date = 'Mars';
                    } else if (ventes.created == '4') {
                      date = 'Avril';
                    } else if (ventes.created == '5') {
                      date = 'Mai';
                    } else if (ventes.created == '6') {
                      date = 'Juin';
                    } else if (ventes.created == '7') {
                      date = 'Juillet';
                    } else if (ventes.created == '8') {
                      date = 'Août';
                    } else if (ventes.created == '9') {
                      date = 'Septembre';
                    } else if (ventes.created == '10') {
                      date = 'Octobre';
                    } else if (ventes.created == '11') {
                      date = 'Novembre';
                    } else if (ventes.created == '12') {
                      date = 'Décembre';
                    }
                    return date;
                  },
                  yValueMapper: (CourbeVenteModel ventes, _) =>
                      double.parse(ventes.sum.toStringAsFixed(2)),
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ]),
        ],
      ),
    );
  }
}
