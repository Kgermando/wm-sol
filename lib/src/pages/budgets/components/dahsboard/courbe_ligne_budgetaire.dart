import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart'; 


class CourbeLignBudgetaire extends StatefulWidget {
  const CourbeLignBudgetaire({super.key, required this.ligneBudgetaireList});
  final List<LigneBudgetaireModel> ligneBudgetaireList;

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
    return Card(
      elevation: 10.0,
      child: SfCartesianChart(
          title: ChartTitle(
              text: 'Lignes Budgetaires',
              textStyle:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                xValueMapper: (LigneBudgetaireModel gdp, _) => gdp.nomLigneBudgetaire,
                yValueMapper: (LigneBudgetaireModel gdp, _) => double.parse(gdp.caisseSortie.toStringAsFixed(2)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true),
              ColumnSeries<LigneBudgetaireModel, String>(
                name: 'Banque',
                dataSource: widget.ligneBudgetaireList,
                sortingOrder: SortingOrder.descending,
                xValueMapper: (LigneBudgetaireModel gdp, _) => gdp.nomLigneBudgetaire,
                yValueMapper: (LigneBudgetaireModel gdp, _) => double.parse(gdp.banqueSortie.toStringAsFixed(2)),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true),
          ColumnSeries<LigneBudgetaireModel, String>(
              name: 'Fin. Exterieur',
              dataSource: widget.ligneBudgetaireList,
              sortingOrder: SortingOrder.descending,
              xValueMapper: (LigneBudgetaireModel gdp, _) => gdp.nomLigneBudgetaire,
              yValueMapper: (LigneBudgetaireModel gdp, _) =>
                  double.parse(gdp.finExterieurSortie.toStringAsFixed(2)),
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(isVisible: false),
          primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              title: AxisTitle(text: 'Budgets')),
        ),
    );
    
    
    
  //   SfCartesianChart(
  //       primaryXAxis: CategoryAxis(),
  //       // Chart title
  //       title: ChartTitle(
  //           text: 'Courbe balance',
  //           textStyle: const TextStyle(fontWeight: FontWeight.bold)),
  //       // Enable legend
  //       legend: Legend(
  //           position: Responsive.isDesktop(context)
  //               ? LegendPosition.right
  //               : LegendPosition.bottom,
  //           isVisible: true),
  //       // Enable tooltip
  //       palette: const [
  //         Color.fromRGBO(73, 76, 162, 1),
  //         Color.fromRGBO(51, 173, 127, 1),
  //         Color.fromRGBO(244, 67, 54, 1)
  //       ],
  //       tooltipBehavior: _tooltipBehavior,
  //       series: <LineSeries>[
  //         LineSeries<BalanceChartModel, String>(
  //           name: 'Debit',
  //           dataSource: widget.balanceSumList,
  //           sortingOrder: SortingOrder.ascending,
  //           markerSettings: const MarkerSettings(isVisible: true),
  //           xValueMapper: (BalanceChartModel item, _) => DateFormat("dd-MM-yyyy").format(item.created), 
  //           yValueMapper: (BalanceChartModel item, _) =>
  //               double.parse(item.debit.toStringAsFixed(2)),
  //           // Enable data label
  //           dataLabelSettings: const DataLabelSettings(isVisible: true),
  //         ),
  //         LineSeries<BalanceChartModel, String>(
  //           name: 'Credit',
  //           dataSource: widget.balanceSumList,
  //           sortingOrder: SortingOrder.ascending,
  //           markerSettings: const MarkerSettings(isVisible: true),
  //           xValueMapper: (BalanceChartModel item, _) => DateFormat("dd-MM-yyyy").format(item.created),
  //           yValueMapper: (BalanceChartModel item, _) =>
  //               double.parse(item.credit.toStringAsFixed(2)),
  //           // Enable data label
  //           dataLabelSettings: const DataLabelSettings(isVisible: true),
  //         ),
  //       ]);
  }
}
