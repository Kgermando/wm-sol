import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/objet_remplace_model.dart';
import 'package:wm_solution/src/routes/routes.dart';

class TableObjetRemplace extends StatefulWidget {
  const TableObjetRemplace(
      {super.key,
      required this.objetRemplaceList,
      required this.entretienModel});
  final List<ObjetRemplaceModel> objetRemplaceList;
  final EntretienModel entretienModel;

  @override
  State<TableObjetRemplace> createState() => _TableObjetRemplaceState();
}

class _TableObjetRemplaceState extends State<TableObjetRemplace> {
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
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager!.setShowColumnFilter(true);
          stateManager!.setShowLoading(true);
        },
        createHeader: (PlutoGridStateManager header) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LogistiqueRoutes.logEntretien);
                  },
                  icon: Icon(Icons.refresh, color: Colors.green.shade700)),
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
              } else if (column.field == 'nomObjet') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'cout') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'caracteristique') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'observation') {
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
    var dataLIst = widget.objetRemplaceList
        .where((element) => element.reference == widget.entretienModel.id)
        .toList();

    var i = dataLIst.length;
    for (var item in dataLIst) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nom': PlutoCell(value: item.nom),
          'cout': PlutoCell(value: item.cout),
          'caracteristique': PlutoCell(value: item.caracteristique),
          'observation': PlutoCell(value: item.observation),
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
        title: 'Nom Objet',
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
        title: 'Coût',
        field: 'cout',
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
        title: 'Caracteristique',
        field: 'caracteristique',
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
        title: 'Observation',
        field: 'observation',
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
