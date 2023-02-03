import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/update/update_model.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableUpdate extends StatefulWidget {
  const TableUpdate(
      {super.key, required this.updateList, required this.controller});
  final List<UpdateModel> updateList;
  final UpdateController controller;

  @override
  State<TableUpdate> createState() => _TableUpdateState();
}

class _TableUpdateState extends State<TableUpdate> {
  EasyTableModel<UpdateModel>? _model;

  @override
  void initState() {
    super.initState();
    List<UpdateModel> rows = List.generate(
        widget.updateList.length, (index) => widget.updateList[index]);
    _model = EasyTableModel<UpdateModel>(rows: rows, columns: [
      EasyTableColumn(
          name: 'Ajouté le',
          width: 200,
          stringValue: (row) =>
              DateFormat("dd-MM-yy HH:mm").format(row.created)),
      EasyTableColumn(
          name: 'Version', width: 150, stringValue: (row) => row.version),
      EasyTableColumn(
          name: 'Rapport de mise à jour',
          width: 300,
          stringValue: (row) => row.motif),
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
                const TitleWidget(title: 'Mise à jours'),
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
            Expanded(
              child: EasyTable<UpdateModel>(
                _model,
                multiSort: true,
                columnsFit: true,
                onRowDoubleTap: (row) async {
                  final UpdateModel updateModel =
                      await widget.controller.detailView(row.id!);
                  // ignore: use_build_context_synchronously
                  Navigator.popAndPushNamed(context, UpdateRoutes.updateDetail,
                      arguments: updateModel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
