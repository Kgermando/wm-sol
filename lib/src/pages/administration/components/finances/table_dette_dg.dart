import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/finances/dette_model.dart';
import 'package:wm_solution/src/pages/finances/components/dettes/dette_xlsx.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableDetteDG extends StatefulWidget {
  const TableDetteDG({super.key, required this.detteController});
  final DetteController detteController;

  @override
  State<TableDetteDG> createState() => _TableDetteDGState();
}

class _TableDetteDGState extends State<TableDetteDG> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
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

                final DetteModel detteModel =
                    await widget.detteController.detailView(idPlutoRow.value);

                Get.toNamed(FinanceRoutes.transactionsDetteDetail,
                    arguments: detteModel);
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
                    const TitleWidget(title: "Dettes"),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              widget.detteController.getList();
                              Navigator.pushNamed(
                                  context, AdminRoutes.adminFinance);
                            },
                            icon: Icon(Icons.refresh,
                                color: Colors.green.shade700)),
                        PrintWidget(onPressed: () {
                          DetteXlsx()
                              .exportToExcel(widget.detteController.detteList);
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
    var dataList = widget.detteController.detteList
        .where((element) =>
            element.approbationDG == '-' && element.approbationDD == 'Approved')
        .toList();
    var i = dataList.length;
    List.generate(dataList.length, (index) {
      var item = dataList[index];
      return rows.add(PlutoRow(cells: {
        'numero': PlutoCell(value: i--),
        'nomComplet': PlutoCell(value: item.nomComplet),
        'pieceJustificative': PlutoCell(value: item.pieceJustificative),
        'libelle': PlutoCell(value: item.libelle),
        'montant': PlutoCell(
            value:
                "${NumberFormat.decimalPattern('fr').format(double.parse(item.montant))} ${monnaieStorage.monney}"),
        'numeroOperation': PlutoCell(value: item.numeroOperation),
        'created': PlutoCell(
            value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
        'approbationDG': PlutoCell(value: item.approbationDG),
        'approbationDD': PlutoCell(value: item.approbationDD),
        'id': PlutoCell(value: item.id)
      }));
    });
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
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
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
                    '${NumberFormat.decimalPattern('fr').format(widget.detteController.nonPaye)} ${monnaieStorage.monney}',
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
                    '${NumberFormat.decimalPattern('fr').format(widget.detteController.paye)} ${monnaieStorage.monney}',
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
                    '${NumberFormat.decimalPattern('fr').format(widget.detteController.nonPaye - widget.detteController.paye)} ${monnaieStorage.monney}',
                    style: bodyMedium.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
          )),
    );
  }
}
