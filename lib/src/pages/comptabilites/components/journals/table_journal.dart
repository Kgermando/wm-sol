import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart'; 
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';

class TableJournal extends StatefulWidget {
  const TableJournal({super.key, required this.itemList});
  final List<JournalModel> itemList;

  @override
  State<TableJournal> createState() => _TableJournalState();
}

class _TableJournalState extends State<TableJournal> {
  EasyTableModel<JournalModel>? _model;

  @override
  void initState() {
    List<JournalModel> rows = List.generate(
        widget.itemList.length, (index) => widget.itemList[index]);
    _model = EasyTableModel<JournalModel>(rows: rows, columns: [
      EasyTableColumn(
        name: 'Date',
        width: 200,
        headerAlignment: Alignment.center,
        stringValue: (row) =>
            DateFormat("dd-MM-yyyy HH:mm").format(row.created),
      ),
      EasyTableColumn(
          name: 'N° Operation',
          width: 150,
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          stringValue: (row) => row.numeroOperation),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          name: 'Libele', width: 300, stringValue: (row) => row.libele),
      EasyTableColumn(
          name: 'Compte',
          width: 100,
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          stringValue: (row) {
            var compteSplit = row.compteDebit.split('_');
            var compte = compteSplit.first;
            return compte;
          }),
      EasyTableColumn(
          name: 'Debit',
          width: 100,
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          stringValue: (row) => (row.montantDebit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.montantDebit))} \$"),
      EasyTableColumn(
          name: 'Credit',
          width: 100,
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          stringValue: (row) => (row.montantCredit == "0")
              ? "-"
              : "${NumberFormat.decimalPattern('fr').format(double.parse(row.montantCredit))} \$"),
       
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: EasyTable<JournalModel>(_model, multiSort: true),
      ),
    );
  }
}