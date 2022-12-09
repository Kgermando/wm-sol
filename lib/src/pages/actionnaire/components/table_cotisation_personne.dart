import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_cotisation_model.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableCotisationPersonne extends StatefulWidget {
  const TableCotisationPersonne({super.key, required this.state});
  final List<ActionnaireCotisationModel> state;

  @override
  State<TableCotisationPersonne> createState() => _TableCotisationPersonneState();
}

class _TableCotisationPersonneState extends State<TableCotisationPersonne> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  EasyTableModel<ActionnaireCotisationModel>? _model; 

  @override
  void initState() {
    super.initState();
 
    List<ActionnaireCotisationModel> rows =
        List.generate(widget.state.length, (index) => widget.state[index]);
    _model = EasyTableModel<ActionnaireCotisationModel>(rows: rows, columns: [
      EasyTableColumn(
        headerAlignment: Alignment.center,
        cellAlignment: Alignment.center,
        name: 'Montant',
        width: 150,
        stringValue: (row) => "${NumberFormat.decimalPattern('fr').format(double.parse(row.montant))} ${monnaieStorage.monney}"), 
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Note',
          width: 300,
          stringValue: (row) => row.note),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Moyen de Paiement',
          width: 200,
          stringValue: (row) => row.moyenPaiement),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Numero Transaction',
          width: 200,
          stringValue: (row) => row.numeroTransaction),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Signature', width: 150, stringValue: (row) => row.signature),
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
              const TitleWidget(title: "Cotisations"),
              Expanded(
                child: EasyTable<ActionnaireCotisationModel>(
                  _model, 
                  multiSort: true
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
