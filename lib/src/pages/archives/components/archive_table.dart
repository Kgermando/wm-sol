import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_folder_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableArchive extends StatefulWidget {
  const TableArchive(
      {super.key,
      required this.archiveFolderModel,
      required this.controller,
      required this.controllerFolder,
      required this.profilController});
  final ArchiveFolderModel archiveFolderModel;
  final ArchiveController controller;
  final ArchiveFolderController controllerFolder;
  final ProfilController profilController;

  @override
  State<TableArchive> createState() => _TableArchiveState();
}

class _TableArchiveState extends State<TableArchive> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  initState() {
    agentsColumn();
    agentsRow().then((value) => stateManager!.setShowLoading(false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: columns,
      rows: rows,
      onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
        final dataId = tapEvent.row.cells.values;
        final idPlutoRow = dataId.last;

        final ArchiveModel archiveModel =
            await widget.controller.detailView(idPlutoRow.value);

        Get.toNamed(ArchiveRoutes.archivesDetail, arguments: archiveModel);
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setShowColumnFilter(true);
        stateManager!.setShowLoading(true);
      },
      createHeader: (PlutoGridStateManager header) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleWidget(title: widget.archiveFolderModel.folderName),
            Row(
              children: [
                deleteButton(),
                IconButton(
                    onPressed: () {
                        widget.controller.getList();
                      Navigator.pushNamed(context, ArchiveRoutes.archivesDetail,
                          arguments: widget.archiveFolderModel);
                    },
                    icon: Icon(Icons.refresh, color: Colors.green.shade700)),
              ],
            ),
          ],
        );
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [...FilterHelper.defaultFilters],
          resolveDefaultColumnFilter: (column, resolver) {
            if (column.field == 'numero') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'nomDocument') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'departement') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'signature') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'created') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'id') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            }
            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
      createFooter: (stateManager) {
        stateManager.setPageSize(20, notify: true); // default 40
        return PlutoPagination(stateManager);
      },
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var dataItemList = widget.controller.archiveList
        .where((element) => element.reference == widget.archiveFolderModel.id);

    var i = dataItemList.length;
    for (var item in dataItemList) {
      var departementList = jsonDecode(item.departement);
      String departement = departementList.first;
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomDocument': PlutoCell(value: item.nomDocument),
          'departement': PlutoCell(value: departement),
          'signature': PlutoCell(value: item.signature),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
          'id': PlutoCell(value: item.id)
        }));
      });
    }
    return rows;
  }

  void agentsColumn() {
    columns = [
      PlutoColumn(
        readOnly: true,
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.number(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 100,
        minWidth: 80,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nom du document',
        field: 'nomDocument',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 300,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'D??partement',
        field: 'departement',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Signature',
        field: 'signature',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Date',
        field: 'created',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
        minWidth: 150,
      ),
    ];
  }

  Widget deleteButton() {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous s??r de faire cette action ?', style: TextStyle(color: Colors.red),),
          content: const Text(
              'Cette action permet de permet de mettre ce fichier en corbeille.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'cancel'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red))
            ),
            TextButton(
              onPressed: () {
                widget.controllerFolder
                    .deleteData(widget.archiveFolderModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
