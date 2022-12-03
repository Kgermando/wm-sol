import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
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
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setShowColumnFilter(true);
        stateManager!.setShowLoading(true);
      },
      createHeader: (PlutoGridStateManager header) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleWidget(title: "Mise à jours"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, UpdateRoutes.updatePage);
                    },
                    icon: Icon(Icons.refresh, color: Colors.green.shade700)),
              ],
            ),
          ],
        );
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            ...FilterHelper.defaultFilters,
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            if (column.field == 'numero') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'created') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'version') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'isActive') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'motif') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'urlUpdate') {
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
    var i = widget.updateList.length;
    for (var item in widget.updateList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
          'version': PlutoCell(value: item.version), 
          'isActive': PlutoCell(value: item.isActive),
          'motif': PlutoCell(value: item.motif),
          'urlUpdate': PlutoCell(value: item.urlUpdate),
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
        title: 'N°',
        field: 'numero',
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
      PlutoColumn(
        readOnly: true,
        title: 'Version',
        field: 'version',
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
        title: 'Actif',
        field: 'isActive',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Rapport update',
        field: 'motif',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Télécharger',
        field: 'urlUpdate',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          return IconButton(
            onPressed: () {
              rendererContext.cell.value.toString();
            },
            icon: Icon(Icons.download, color: mainColor));
        },
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        minWidth: 80,
      ),
    ];
  }
}
