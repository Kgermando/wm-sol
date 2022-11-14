import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:wm_solution/src/pages/finances/components/creances/creance_xlsx.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableCreanceDD extends StatefulWidget {
  const TableCreanceDD({super.key, required this.creanceController});
  final CreanceController creanceController;

  @override
  State<TableCreanceDD> createState() => _TableCreanceDDState();
}

class _TableCreanceDDState extends State<TableCreanceDD> {
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
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
                final dataId = tapEvent.row.cells.values;
                final idPlutoRow = dataId.last;

                final CreanceModel creanceModel =
                    await widget.creanceController.detailView(idPlutoRow.value);

                Get.toNamed(FinanceRoutes.transactionsCreanceDetail,
                    arguments: creanceModel);
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
                    const TitleWidget(title: "Créances"),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, FinanceRoutes.finDD);
                            },
                            icon: Icon(Icons.refresh,
                                color: Colors.green.shade700)),
                        PrintWidget(onPressed: () {
                          CreanceXlsx().exportToExcel(
                              widget.creanceController.creanceList);
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
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'nomComplet') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'pieceJustificative') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'libelle') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'montant') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'numeroOperation') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'created') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'approbationDG') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'approbationDD') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'id') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    }
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  },
                ),
              ),
              createFooter: (stateManager) {
                stateManager.setPageSize(20, notify: true); // default 40
                return PlutoPagination(stateManager);
              },
            ),
          ),
          totalSolde()
        ],
      ),
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var dataList = widget.creanceController.creanceList
        .where((element) => element.approbationDD == "-")
        .toList();
    var i = dataList.length;
    for (var item in dataList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomComplet': PlutoCell(value: item.nomComplet),
          'pieceJustificative': PlutoCell(value: item.pieceJustificative),
          'libelle': PlutoCell(value: item.libelle),
          'montant': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montant))} \$"),
          'numeroOperation': PlutoCell(value: item.numeroOperation),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
          'approbationDG': PlutoCell(value: item.approbationDG),
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
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Nom complet',
        field: 'nomComplet',
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
        title: 'Pièce justificative',
        field: 'pieceJustificative',
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
        title: 'Libelle',
        field: 'libelle',
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
        title: 'Montant',
        field: 'montant',
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
        title: 'Numero d\'operation',
        field: 'numeroOperation',
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
        title: 'Approbation DG',
        field: 'approbationDG',
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
      ),
    ];
  }

  Widget totalSolde() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Card(
      color: Colors.red.shade700,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ResponsiveChild3Widget(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            child1: Row(
              children: [
                SelectableText('Total: ',
                    style: bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SelectableText(
                    '${NumberFormat.decimalPattern('fr').format(widget.creanceController.nonPaye)} \$',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
            child2: Row(
              children: [
                SelectableText('Payé: ',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SelectableText(
                    '${NumberFormat.decimalPattern('fr').format(widget.creanceController.paye)} \$',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
            child3: Row(
              children: [
                SelectableText('Non Payé: ',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SelectableText(
                    '${NumberFormat.decimalPattern('fr').format(widget.creanceController.nonPaye - widget.creanceController.paye)} \$',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
          )),
    );
  }
}
