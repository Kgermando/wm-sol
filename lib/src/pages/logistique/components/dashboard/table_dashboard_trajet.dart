import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/widgets/title_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TableDahboardTrajet extends StatefulWidget {
  const TableDahboardTrajet({super.key, required this.state, required this.controller});
  final List<TrajetModel> state;
  final TrajetController controller;

  @override
  State<TableDahboardTrajet> createState() => _TableDahboardTrajetState();
}

class _TableDahboardTrajetState extends State<TableDahboardTrajet> { 
  EasyTableModel<TrajetModel>? _model;

  @override
  void initState() {
    super.initState();

    List<TrajetModel> rows =
        List.generate(5, (index) => widget.state[index]);
    _model = EasyTableModel<TrajetModel>(rows: rows, columns: [
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.center,
          name: 'N° plaque',
          width: 150,
          stringValue: (row) => row.nomeroEntreprise),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.centerLeft,
          name: 'Conducteur',
          width: 150,
          stringValue: (row) => row.conducteur),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.centerLeft,
          name: 'Trajet De',
          width: 150,
          stringValue: (row) => row.trajetDe),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.centerLeft,
          cellTextStyle: TextStyle(color: Colors.red.shade700),
          name: 'Trajet A',
          width: 150,
          stringValue: (row) => row.trajetA),
      EasyTableColumn(
          headerAlignment: Alignment.center,
          cellAlignment: Alignment.centerLeft,
          name: 'Mission',
          width: 300,
          stringValue: (row) => row.mission), 
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
                const TitleWidget(title: "Recents Trajets"),
                Expanded(
                  child: EasyTable<TrajetModel>(
                    _model, multiSort: true,
                    onRowTap: (row) async {
                      final TrajetModel trajetModel =
                        await widget.controller.detailView(row.id!);

                    Get.toNamed(LogistiqueRoutes.logTrajetAutoDetail,
                        arguments: trajetModel);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
