import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart'; 
import 'package:wm_solution/src/models/charts/courbe_budget_model.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';

class CourbeLignBudgetaire extends StatefulWidget {
  const CourbeLignBudgetaire(
      {super.key,
      required this.controller,
      required this.monnaieStorage});
  final DashboardBudgetController controller;
  final MonnaieStorage monnaieStorage;

  @override
  State<CourbeLignBudgetaire> createState() => _CourbeLignBudgetaireState();
}

class _CourbeLignBudgetaireState extends State<CourbeLignBudgetaire> {
  TooltipBehavior? _tooltipBehavior;

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
                text: 'Courbe de dépenses annuelle',
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
              title:
                  AxisTitle(text: DateFormat("MM-yyyy").format(DateTime.now())),
              numberFormat: NumberFormat.currency(
                  symbol: '${widget.monnaieStorage.monney} ', decimalDigits: 1),
            ),
            series: <LineSeries>[
              LineSeries<CourbeBudgetModel, String>(
                name: 'Banque',
                dataSource: widget.controller.courbeBanqueList,
                sortingOrder: SortingOrder.ascending,
                markerSettings: const MarkerSettings(isVisible: true),
                xValueMapper: (CourbeBudgetModel ventes, _) {
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
                yValueMapper: (CourbeBudgetModel ventes, _) =>
                    double.parse(ventes.sum.toStringAsFixed(2)),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries<CourbeBudgetModel, String>(
                name: 'Caisse',
                dataSource: widget.controller.courbeCaisseList,
                sortingOrder: SortingOrder.ascending,
                markerSettings: const MarkerSettings(isVisible: true),
                xValueMapper: (CourbeBudgetModel ventes, _) {
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
                yValueMapper: (CourbeBudgetModel ventes, _) =>
                    double.parse(ventes.sum.toStringAsFixed(2)),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries<CourbeBudgetModel, String>(
                name: 'Fin. Exterieur',
                dataSource: widget.controller.courbeFinExterieurList,
                sortingOrder: SortingOrder.ascending,
                markerSettings: const MarkerSettings(isVisible: true),
                xValueMapper: (CourbeBudgetModel ventes, _) {
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
                yValueMapper: (CourbeBudgetModel ventes, _) =>
                    double.parse(ventes.sum.toStringAsFixed(2)),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ]),
      ),
    ); 
  }

  
}
