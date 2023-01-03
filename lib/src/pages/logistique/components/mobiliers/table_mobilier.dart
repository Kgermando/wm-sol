import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/pages/logistique/components/mobiliers/mobilier_xlsx.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableMobilier extends StatefulWidget {
  const TableMobilier(
      {super.key, required this.mobilierList, required this.controller});
  final List<MobilierModel> mobilierList;
  final MobilierController controller;

  @override
  State<TableMobilier> createState() => _TableMobilierState();
}

class _TableMobilierState extends State<TableMobilier> {
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

        final MobilierModel mobilierModel =
            await widget.controller.detailView(idPlutoRow.value);

        Get.toNamed(LogistiqueRoutes.logMobilierMaterielDetail,
            arguments: mobilierModel);
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
            const TitleWidget(title: "Mobiliers"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, LogistiqueRoutes.logMobilierMateriel);
                    },
                    icon: Icon(Icons.refresh, color: Colors.green.shade700)),
                PrintWidget(onPressed: () {
                  MobilierXlsx().exportToExcel(widget.mobilierList);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Exportation effectué!"),
                    backgroundColor: Colors.green[700],
                  ));
                })
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
            } else if (column.field == 'nom') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'modele') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'marque') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'nombre') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'created') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'approbationDD') {
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
    var i = widget.mobilierList.length;
    for (var item in widget.mobilierList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nom': PlutoCell(value: item.nom),
          'modele': PlutoCell(value: item.modele),
          'marque': PlutoCell(value: item.marque),
          'nombre': PlutoCell(value: item.nombre),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yy HH:mm").format(item.created)),
          'approbationDD': PlutoCell(value: item.approbationDD),
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
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nom complet',
        field: 'nom',
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
        title: 'Modèle',
        field: 'modele',
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
        title: 'Marque',
        field: 'marque',
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
        title: 'Nombre',
        field: 'nombre',
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
        title: 'Date',
        field: 'created',
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
        title: 'Approbation DD',
        field: 'approbationDD',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 300,
        minWidth: 150,
        renderer: (rendererContext) {
          Color textColor = Colors.black;
          if (rendererContext.cell.value == 'Approved') {
            textColor = Colors.green;
          } else if (rendererContext.cell.value == 'Unapproved') {
            textColor = Colors.red;
          } else if (rendererContext.cell.value == '-') {
            textColor = Colors.orange;
          }
          return Text(
            rendererContext.cell.value.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
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
        width: 80,
        minWidth: 80,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
      ),
    ];
  }
}
