import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';

class ChartBudgetaire extends StatefulWidget {
  const ChartBudgetaire(
      {super.key,
      required this.ligneBudgetaireList,
      required this.monnaieStorage});
  final List<LigneBudgetaireModel> ligneBudgetaireList;
  final MonnaieStorage monnaieStorage;

  @override
  State<ChartBudgetaire> createState() => _ChartBudgetaireState();
}

class _ChartBudgetaireState extends State<ChartBudgetaire> {
  final MonnaieStorage monnaieStorage = MonnaieStorage();
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
          title: ChartTitle(
              text: 'Lignes Budgetaires',
              textStyle: headline6!.copyWith(fontWeight: FontWeight.bold)),
          legend: Legend(
              position: Responsive.isDesktop(context)
                  ? LegendPosition.right
                  : LegendPosition.bottom,
              isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            ColumnSeries<LigneBudgetaireModel, String>(
                name: 'Caisse',
                dataSource: widget.ligneBudgetaireList,
                sortingOrder: SortingOrder.descending,
                xValueMapper: (LigneBudgetaireModel gdp, _) =>
                    gdp.nomLigneBudgetaire,
                yValueMapper: (LigneBudgetaireModel gdp, _) =>
                    double.parse(gdp.caisseSortie.toStringAsFixed(2)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true),
            ColumnSeries<LigneBudgetaireModel, String>(
                name: 'Banque',
                dataSource: widget.ligneBudgetaireList,
                sortingOrder: SortingOrder.descending,
                xValueMapper: (LigneBudgetaireModel gdp, _) =>
                    gdp.nomLigneBudgetaire,
                yValueMapper: (LigneBudgetaireModel gdp, _) =>
                    double.parse(gdp.banqueSortie.toStringAsFixed(2)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true),
            ColumnSeries<LigneBudgetaireModel, String>(
                name: 'Fin. Exterieur',
                dataSource: widget.ligneBudgetaireList,
                sortingOrder: SortingOrder.descending,
                xValueMapper: (LigneBudgetaireModel gdp, _) =>
                    gdp.nomLigneBudgetaire,
                yValueMapper: (LigneBudgetaireModel gdp, _) =>
                    double.parse(gdp.finExterieurSortie.toStringAsFixed(2)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(isVisible: true),
          primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: 'Budgets'),
            numberFormat: NumberFormat.currency(
                  symbol: '${widget.monnaieStorage.monney} ', decimalDigits: 1),
          ),
        ),
      ),
    );

  }
}
