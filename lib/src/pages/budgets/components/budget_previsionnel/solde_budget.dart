import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/widgets/responsive_child5_widget.dart';

class SoldeBudgets extends StatelessWidget {
  const SoldeBudgets(
      {Key? key,
      required this.coutTotal,
      required this.caisseSolde,
      required this.banqueSolde,
      required this.finExterieurSolde,
      required this.touxExecutions})
      : super(key: key);
  final double coutTotal;
  final double caisseSolde;
  final double banqueSolde;
  final double finExterieurSolde;
  final double touxExecutions;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return ResponsiveChild5Widget(
        child1: Column(
          children: [
            const Text("Coût total",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(coutTotal)} \$",
                textAlign: TextAlign.center,
                style: headline6),
          ],
        ),
        child2: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Caisse",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  "${NumberFormat.decimalPattern('fr').format(caisseSolde)} \$",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: headline6),
            ],
          ),
        ),
        child3: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Banque",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  "${NumberFormat.decimalPattern('fr').format(banqueSolde)} \$",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: headline6),
            ],
          ),
        ),
        child4: Column(
          children: [
            const Text("Reste à trouver",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "${NumberFormat.decimalPattern('fr').format(finExterieurSolde)} \$",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: headline6!.copyWith(color: Colors.orange.shade700)),
          ],
        ),
        child5: Column(
          children: [
            const Text("Taux d'executions",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(touxExecutions.toStringAsFixed(0)))} %",
                textAlign: TextAlign.center,
                style: headline6.copyWith(
                    color: (touxExecutions >= 50)
                        ? Colors.green.shade700
                        : Colors.red.shade700)),
          ],
        ));
  }
}
