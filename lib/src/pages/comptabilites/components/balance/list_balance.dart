import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart';
import 'package:wm_solution/src/widgets/responsive_child4_widget.dart';

class ListBalance extends StatefulWidget {
  const ListBalance(
      {super.key, required this.balanceList, required this.controller});
  final List<BalanceSumModel> balanceList;
  final BalanceSumController controller;

  @override
  State<ListBalance> createState() => _ListBalanceState();
}

class _ListBalanceState extends State<ListBalance> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(child: dataWidget())),
        totalMontant()
      ],
    );
  }

  Widget totalMontant() {
    final headline6 = Theme.of(context).textTheme.headline6;
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    double totalSolde = 0.0;

    for (var item in widget.balanceList) {
      totalDebit += item.debit;
      totalCredit += item.credit;
      totalSolde += item.debit - item.credit;

      // print("item.debit ${item.debit} ");
    }

    return Container(
      padding: const EdgeInsets.all(p10),
      height: 80,
      child: Column(
        children: [
          ResponsiveChild4Widget(
              flex1: 3,
              flex2: 1,
              flex3: 1,
              flex4: 1,
              child1: Text("TOTAL :",
                  textAlign: TextAlign.start,
                  style: headline6!.copyWith(fontWeight: FontWeight.bold)),
              child2: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalDebit)} ${monnaieStorage.monney}",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ),
              child3: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalCredit)} ${monnaieStorage.monney}",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ),
              child4: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                )),
                child: Text(
                    "${NumberFormat.decimalPattern('fr').format(totalSolde)} ${monnaieStorage.monney}",
                    textAlign: TextAlign.center,
                    style: headline6.copyWith(fontWeight: FontWeight.bold)),
              ))
        ],
      ),
    );
  }

  Widget dataWidget() {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChild4Widget(
            mainAxisAlignment: MainAxisAlignment.start,
            flex1: 3,
            flex2: 1,
            flex3: 1,
            flex4: 1,
            child1: Container(
              decoration: const BoxDecoration(),
              child: Text("Comptes",
                  textAlign: TextAlign.start,
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
            child2: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Débit",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
            child3: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Crédit",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
            child4: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: Text("Solde",
                  textAlign: TextAlign.center,
                  style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(color: mainColor),
          const SizedBox(height: p30),
          compteWidget()
        ],
      ),
    );
  }

  Widget compteWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return ListView.builder(
      controller: widget.controller.balanceScroll,
      shrinkWrap: true,
      itemCount: widget.balanceList.length,
      itemBuilder: (context, index) {
        final compte = widget.balanceList[index];

        double solde = compte.debit - compte.credit;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(compte.comptes,
                      textAlign: TextAlign.start, style: bodyMedium),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: mainColor,
                        width: 2,
                      ),
                    )),
                    child: Text(
                        (compte.debit == 0.0)
                            ? "-"
                            : "${NumberFormat.decimalPattern('fr').format(compte.debit)} ${monnaieStorage.monney}",
                        textAlign: TextAlign.center,
                        style: bodyMedium),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: mainColor,
                        width: 2,
                      ),
                    )),
                    child: Text(
                        (compte.credit == 0.0)
                            ? "-"
                            : "${NumberFormat.decimalPattern('fr').format(compte.credit)} ${monnaieStorage.monney}",
                        textAlign: TextAlign.center,
                        style: bodyMedium),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: mainColor,
                        width: 2,
                      ),
                    )),
                    child: Text(
                        "${NumberFormat.decimalPattern('fr').format(solde)} ${monnaieStorage.monney}",
                        textAlign: TextAlign.center,
                        style: bodyMedium),
                  ),
                )
              ],
            ),
            Divider(
              color: mainColor,
            ),
          ],
        );
      },
    );
  }

  // Widget deleteButton(int id) {
  //   return IconButton(
  //     icon: Icon(Icons.delete, color: Colors.red.shade700),
  //     tooltip: "Supprimer",
  //     onPressed: () => showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: const Text(
  //           'Etes-vous sûr de faire cette action ?',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //         content: const Text(
  //             'Cette action permet de permet de mettre ce fichier en corbeille.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Annuler', style: TextStyle(color: Colors.red)),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               widget.controller.deleteData(id);
  //               Navigator.pop(context, 'ok');
  //             },
  //             child: Obx(() => controller.isLoading ? loading() : const Text('OK', style: TextStyle(color: Colors.red))),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
