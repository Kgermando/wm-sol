import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_transfert_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableTransfertPersonne extends StatefulWidget {
  const TableTransfertPersonne({super.key, required this.state});
  final List<ActionnaireTransfertModel> state;

  @override
  State<TableTransfertPersonne> createState() => _TableTransfertPersonneState();
}

class _TableTransfertPersonneState extends State<TableTransfertPersonne> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  EasyTableModel<ActionnaireTransfertModel>? _model;

  @override
  void initState() {
    super.initState();

    List<ActionnaireTransfertModel> rows =
        List.generate(widget.state.length, (index) => widget.state[index]);
    _model = EasyTableModel<ActionnaireTransfertModel>(rows: rows, columns: [
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Transfer De',
          width: 200,
          stringValue: (row) => row.matriculeEnvoi),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Transfer A',
          width: 200,
          stringValue: (row) => row.matriculeRecu),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Montant',
          width: 150,
          stringValue: (row) =>
              "${NumberFormat.decimalPattern('fr').format(double.parse(row.montant))} ${monnaieStorage.monney}"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Signature',
          width: 150,
          stringValue: (row) => row.signature),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Date',
          width: 200,
          stringValue: (row) =>
              DateFormat("dd-MM-yy HH:mm").format(row.created)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: SizedBox(
            height: 400,
            child: Column(
              children: [
                const TitleWidget(title: "Historique de Transfert"),
                Expanded(
                  child: EasyTable<ActionnaireTransfertModel>(_model,
                      multiSort: true),
                ),
              ],
            )),
      ),
    );
  }
}
