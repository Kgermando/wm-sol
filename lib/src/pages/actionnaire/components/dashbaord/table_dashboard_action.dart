import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TableDahboardAction extends StatefulWidget {
  const TableDahboardAction({super.key, required this.state});
  final List<ActionnaireModel> state;

  @override
  State<TableDahboardAction> createState() => _TableDahboardActionState();
}

class _TableDahboardActionState extends State<TableDahboardAction> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  EasyTableModel<ActionnaireModel>? _model;

  @override
  void initState() {
    super.initState();

    List<ActionnaireModel> rows =
        List.generate(widget.state.length, (index) => widget.state[index]);
    _model = EasyTableModel<ActionnaireModel>(rows: rows, columns: [
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Matricle',
          width: 150,
          stringValue: (row) => row.matricule),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          cellTextStyle: TextStyle(color: Colors.red.shade700),
          name: 'Cotisations',
          width: 150,
          stringValue: (row) =>
              "${NumberFormat.decimalPattern('fr').format(row.cotisations)} ${monnaieStorage.monney}"),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'Temps écouler',
          width: 300,
          stringValue: (row) => timeago.format(row.created, locale: 'fr')),
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
                const TitleWidget(title: "Recents cotisations"),
                Expanded(
                  child: EasyTable<ActionnaireModel>(_model, multiSort: true),
                ),
              ],
            )),
      ),
    );
  }
}
