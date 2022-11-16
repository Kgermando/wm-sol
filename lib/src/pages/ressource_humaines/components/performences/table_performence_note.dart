import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TablePerformenceNote extends StatefulWidget {
  const TablePerformenceNote({super.key, required this.performenceNoteList, required this.controllerNote});
  final List<PerformenceNoteModel> performenceNoteList;
  final PerformenceNoteController controllerNote;

  @override
  State<TablePerformenceNote> createState() => _TablePerformenceNoteState();
}

class _TablePerformenceNoteState extends State<TablePerformenceNote> {
  EasyTableModel<PerformenceNoteModel>? _model;

  @override
  void initState() {
    super.initState();
    List<PerformenceNoteModel> rows = List.generate(
        widget.performenceNoteList.length,
        (index) => widget.performenceNoteList[index]);
    _model = EasyTableModel<PerformenceNoteModel>(rows: rows, columns: [
      EasyTableColumn(
          headerAlignment: Alignment.center,
          name: 'Date',
          width: 150,
          stringValue: (row) =>
              timeago.format(row.created, locale: 'fr_short')),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Signature', width: 100, stringValue: (row) => row.signature),
      EasyTableColumn(name: 'Matricule', stringValue: (row) => row.agent),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          name: 'Departement',
          width: 300,
          stringValue: (row) => row.departement),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          cellTextStyle: const TextStyle(color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
          name: 'Hospitalité',
          width: 300,
          stringValue: (row) => row.hospitalite),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          cellTextStyle: const TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold),
          name: 'Ponctualité',
          width: 200,
          stringValue: (row) => row.ponctualite),
      EasyTableColumn(
        headerAlignment: Alignment.center,
        cellAlignment: Alignment.center,
        cellTextStyle: const TextStyle(color: Colors.purple, fontSize: 20.0, fontWeight: FontWeight.bold),
        name: 'Travaille', width: 200, stringValue: (row) => row.travaille),
      EasyTableColumn(
        headerAlignment: Alignment.center,  
        name: 'Note', width: 300, stringValue: (row) => row.note),
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
                const TitleWidget(title: 'Cotations'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controllerNote.getList();
                      });
                    },
                    icon: const Icon(Icons.refresh, color: Colors.green))
              ],
            ),
            const SizedBox(height: p10),
            SizedBox(
                height: 400,
                child: EasyTable<PerformenceNoteModel>(
                  _model,
                  multiSort: true,
                )),
          ],
        ),
      ),
    );
  }
}
