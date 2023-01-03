import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:wm_solution/src/pages/logistique/components/trajets/trajet_xlsx.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableTrajetRoulant extends StatefulWidget {
  const TableTrajetRoulant(
      {super.key, required this.controller, required this.materielModel});
  final TrajetController controller;
  final MaterielModel materielModel;

  @override
  State<TableTrajetRoulant> createState() => _TableTrajetRoulantState();
}

class _TableTrajetRoulantState extends State<TableTrajetRoulant> {
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
    return SizedBox(
      height: 400,
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
          final dataId = tapEvent.row.cells.values;
          final idPlutoRow = dataId.last;

          final TrajetModel trajetModel =
              await widget.controller.detailView(idPlutoRow.value);

          Get.toNamed(LogistiqueRoutes.logTrajetAutoDetail,
              arguments: trajetModel);
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
              const TitleWidget(title: "Trajets"),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, LogistiqueRoutes.logMaterielDetail,
                            arguments: widget.materielModel);
                      },
                      icon: Icon(Icons.refresh, color: Colors.green.shade700)),
                  PrintWidget(onPressed: () {
                    TrajetXlsx().exportToExcel(widget.controller.trajetList);
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
              } else if (column.field == 'nomeroEntreprise') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'conducteur') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'trajetA') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'mission') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'kilometrageSorite') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'kilometrageRetour') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'created') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'approbationDD') {
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
      ),
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var dataList = widget.controller.trajetList
        .where((element) => element.reference == widget.materielModel.id)
        .toList();
    var i = dataList.length;
    for (var item in dataList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomeroEntreprise': PlutoCell(value: item.nomeroEntreprise),
          'conducteur': PlutoCell(value: item.conducteur),
          'trajetDe': PlutoCell(value: item.trajetDe),
          'trajetA': PlutoCell(value: item.trajetA),
          'mission': PlutoCell(value: item.mission),
          'kilometrageSorite':
              PlutoCell(value: "${item.kilometrageSorite} km/h"),
          'kilometrageRetour':
              PlutoCell(value: "${item.kilometrageRetour} km/h"),
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
        title: 'Nom Utilisateur(chauffeur)',
        field: 'conducteur',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 250,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'De',
        field: 'trajetDe',
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
        title: 'A',
        field: 'trajetA',
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
        title: 'Mission',
        field: 'mission',
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
        title: 'kilometrage Soritie',
        field: 'kilometrageSorite',
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
        title: 'kilometrage Retour',
        field: 'kilometrageRetour',
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
      PlutoColumn(
        readOnly: true,
        title: 'Approbation DD',
        field: 'approbationDD',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        width: 200,
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
