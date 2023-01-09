import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/taches/rapport_model.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableRapport extends StatefulWidget {
  const TableRapport(
      {super.key,
      required this.rapportController,
      required this.tacheModel,
      required this.profilController,
      required  this.state});
  final RapportController rapportController;
  final TacheModel tacheModel;
  final ProfilController profilController;
  final List<RapportModel> state;

  @override
  State<TableRapport> createState() => _TableRapportState();
}

class _TableRapportState extends State<TableRapport> {
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

          final RapportModel rapportModel =
              await widget.rapportController.detailView(idPlutoRow.value);
          if (widget.tacheModel.signatureResp == "Non Lu" && widget.tacheModel.signatureResp ==
              widget.profilController.user.matricule) {
            widget.rapportController.submiReadRapport(rapportModel);
            
          }
          Get.toNamed(TacheRoutes.rapportDetail, arguments: rapportModel);
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
              const TitleWidget(title: "Rapports"),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TacheRoutes.tacheDetail,
                            arguments: widget.tacheModel);
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
              } else if (column.field == 'readResponsable') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'nom') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'numeroTache') {
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
      ),
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var i = widget.state.length;
    for (var item in widget.state) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'readRapport': PlutoCell(value: item.readRapport),
          'nom': PlutoCell(value: item.nom),
          'numeroTache': PlutoCell(value: item.numeroTache),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yy HH:mm").format(item.created)),
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
        title: 'Statut',
        field: 'readRapport',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        renderer: (rendererContext) {
          Color textColor = Colors.black;
          if (rendererContext.cell.value == 'Lu') {
            textColor = Colors.green;
          } else if (rendererContext.cell.value == 'Non Lu') {
            textColor = Colors.red;
          }
          return Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: p5),
              Text(
                rendererContext.cell.value.toString(),
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Titre',
        field: 'nom',
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
        title: 'N° Tache',
        field: 'numeroTache',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
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
