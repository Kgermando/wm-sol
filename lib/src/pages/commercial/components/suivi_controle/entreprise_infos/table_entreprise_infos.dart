import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableEntrepriseInfos extends StatefulWidget {
  const TableEntrepriseInfos(
      {super.key, required this.controller, required this.state});
  final EntrepriseInfosController controller;
  final List<EntrepriseInfoModel> state;

  @override
  State<TableEntrepriseInfos> createState() => _TableEntrepriseInfosState();
}

class _TableEntrepriseInfosState extends State<TableEntrepriseInfos> {
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

        final EntrepriseInfoModel entrepriseInfoModel =
            await widget.controller.detailView(idPlutoRow.value);

        Get.toNamed(ComRoutes.comEntrepriseDetail,
            arguments: entrepriseInfoModel);
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
            const TitleWidget(title: "Entreprise & Particulier"),
            IconButton(
                onPressed: () {
                  widget.controller.getList();
                  Navigator.pushNamed(context, ComRoutes.comEntreprise);
                },
                icon: Icon(Icons.refresh, color: Colors.green.shade700))
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
            } else if (column.field == 'dateFinContrat') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'typeContrat') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'typeEntreprise') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'nomSocial') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'emailEntreprise') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'telephone1') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'rccm') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'identificationNationale') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'numerosImpot') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'secteurActivite') {
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
    var i = widget.state.length;
    for (var item in widget.state) {
      String colors = '';

      int dayNow = DateTime.now().day;
      int monthNow = DateTime.now().month;
      int yearNow = DateTime.now().year;

      int day = item.dateFinContrat.day;
      int month = item.dateFinContrat.month;
      int year = item.dateFinContrat.year;

      int dayDifference = day - dayNow;

      if (item.dateFinContrat.isAfter(DateTime.now())) {
        colors == 'green';
      } else if (year <= yearNow && month <= monthNow && day == dayNow) {
        colors == 'red';
      } else if (year <= yearNow && month <= monthNow) {
        colors == 'red';
      } else if (year <= yearNow) {
        colors == 'red';
      } else if (year == yearNow && month == monthNow && dayDifference <= 5) {
        colors == 'orange';
      } else if (year == yearNow && month == monthNow && dayDifference <= 10) {
        colors == 'amber';
      } else if (year == 2100 && month == 12 && day == 30) {
        colors == 'blueGrey';
      }

      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'dateFinContrat': PlutoCell(value: colors),
          'typeContrat': PlutoCell(value: item.typeContrat),
          'typeEntreprise': PlutoCell(value: item.typeEntreprise),
          'nomSocial': PlutoCell(value: item.nomSocial),
          'emailEntreprise': PlutoCell(value: item.emailEntreprise),
          'telephone1': PlutoCell(value: item.telephone1),
          'rccm': PlutoCell(value: item.rccm),
          'identificationNationale':
              PlutoCell(value: item.identificationNationale),
          'numerosImpot': PlutoCell(value: item.numerosImpot),
          'secteurActivite': PlutoCell(value: item.secteurActivite),
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
        title: 'Fin Contrat',
        field: 'dateFinContrat',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          Color textColor = Colors.black;
          String text = '';
          if (rendererContext.cell.value == 'green') {
            textColor = Colors.green;
            text = 'Bon';
          } else if (rendererContext.cell.value == 'red') {
            textColor = Colors.red;
            text = 'Expirer';
          } else if (rendererContext.cell.value == 'orange') {
            textColor = Colors.orange;
            text = 'Expirer dans 5 jours';
          } else if (rendererContext.cell.value == 'amber') {
            textColor = Colors.amber;
            text = 'Expirer dans 10 jours';
          } else if (rendererContext.cell.value == 'blueGrey') {
            textColor = Colors.blueGrey;
            text = 'Pas de contrat';
          }
          return Row(
            children: [
              Icon(Icons.folder, color: textColor),
              const SizedBox(width: p5),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          );
        },
        width: 400,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Type de Contrat',
        field: 'typeContrat',
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
        title: 'Clients',
        field: 'typeEntreprise',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          Color textColor = Colors.black; 
          if (rendererContext.cell.value == 'Entreprise') {
            textColor = Colors.teal; 
          } else if (rendererContext.cell.value == 'Particulier') {
            textColor = Colors.blue; 
          }  
          return Row(
            children: [
              Icon(Icons.folder, color: textColor),
              const SizedBox(width: p5),
              Text(
                rendererContext.cell.value.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          );
        },
        width: 200,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nom Social',
        field: 'nomSocial',
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
        title: 'Email',
        field: 'emailEntreprise',
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
        title: 'Telephone',
        field: 'telephone1',
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
        title: 'RCCM',
        field: 'rccm',
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
        title: 'Id. Nat.',
        field: 'identificationNationale',
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
        title: 'N° impôt',
        field: 'numerosImpot',
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
        title: 'Secteur',
        field: 'secteurActivite',
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
