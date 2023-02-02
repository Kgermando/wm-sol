import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableHistoryApprovision extends StatefulWidget {
  const TableHistoryApprovision(
      {super.key, required this.approvisionnementList, required this.controller});
  final List<ApprovisionnementModel> approvisionnementList;
  final ApprovisionnementController controller;

  @override
  State<TableHistoryApprovision> createState() =>
      _TableHistoryApprovisionState();
}

class _TableHistoryApprovisionState extends State<TableHistoryApprovision> {
  EasyTableModel<ApprovisionnementModel>? _model;

  @override
  void initState() {
    super.initState();
    List<ApprovisionnementModel> rows = List.generate(
        widget.approvisionnementList.length,
        (index) => widget.approvisionnementList[index]);
    _model = EasyTableModel<ApprovisionnementModel>(rows: rows, columns: [
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Provision',
          width: 300,
          stringValue: (row) => row.provision),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Qté total',
          width: 200,
          stringValue: (row) =>
              "${NumberFormat.decimalPattern('fr').format(double.parse(row.quantityTotal))} ${row.unite}"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Qté Restante',
          width: 200,
          stringValue: (row) =>
              "${NumberFormat.decimalPattern('fr').format(double.parse(row.quantity))} ${row.unite}"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Signature',
          width: 100,
          stringValue: (row) => row.signature),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Date',
          width: 150,
          stringValue: (row) =>
              DateFormat("dd-MM-yy HH:mm").format(row.created)),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Fournisseur',
          width: 200,
          stringValue: (row) => row.fournisseur),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(title: "Historique d'entrer"),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.getList();
                      });
                    },
                    icon: const Icon(Icons.refresh, color: Colors.green))
              ],
            ),
            const SizedBox(height: p10),
            SizedBox(
                height: 300,
                child: EasyTable<ApprovisionnementModel>(
                  _model,
                  multiSort: true,
                  columnsFit: true,
                )),
          ],
        ),
      ),
    );
  }
}
