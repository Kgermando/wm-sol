import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/models/finances/caisse_model.dart';
import 'package:wm_solution/src/models/finances/caisse_name_model.dart';
import 'package:wm_solution/src/pages/finances/components/caisses/caisse_xlsx.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class Tablecaisse extends StatefulWidget {
  const Tablecaisse(
      {super.key,
      required this.caisseList,
      required this.controller,
      required this.caisseNameModel});
  final List<CaisseModel> caisseList;
  final CaisseController controller;
  final CaisseNameModel caisseNameModel;

  @override
  State<Tablecaisse> createState() => _TablecaisseState();
}

class _TablecaisseState extends State<Tablecaisse> {
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
    return Column(
      children: [
        Expanded(
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
              final dataId = tapEvent.row.cells.values;
              final idPlutoRow = dataId.last;

              final CaisseModel caisseModel =
                  await widget.controller.detailView(idPlutoRow.value);

              Get.toNamed(FinanceRoutes.transactionsCaisseDetail,
                  arguments: caisseModel);
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
                  TitleWidget(title: widget.caisseNameModel.nomComplet),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context,
                                '/transactions-caisse/${widget.caisseNameModel.id}',
                                arguments: widget.caisseNameModel);
                          },
                          icon: Icon(Icons.refresh,
                              color: Colors.green.shade700)),
                      PrintWidget(onPressed: () {
                        CaisseXlsx().exportToExcel(widget.caisseList);
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
                  } else if (column.field == 'typeOperation') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  } else if (column.field == 'numeroOperation') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  } else if (column.field == 'created') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  } else if (column.field == 'id') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
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
        ),
        totalSolde()
      ],
    );
  }

  Future<List<PlutoRow>> agentsRow() async {
    var i = widget.caisseList.length;
    for (var item in widget.caisseList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomComplet': PlutoCell(value: item.nomComplet),
          'pieceJustificative': PlutoCell(value: item.pieceJustificative),
          'libelle': PlutoCell(value: item.libelle),
          'montant': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montant))} \$"),
          'typeOperation': PlutoCell(value: item.typeOperation),
          'numeroOperation': PlutoCell(value: item.numeroOperation),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy H:mm").format(item.created)),
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
        title: 'Type d\'operation',
        field: 'typeOperation',
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
    double recette = 0.0;
    double depenses = 0.0;
    List<CaisseModel?> recetteList = widget.caisseList
        .where((element) =>
            element.caisseName == widget.caisseNameModel.nomComplet &&
            element.typeOperation == "Encaissement")
        .toList();
    List<CaisseModel?> depensesList = widget.caisseList
        .where((element) =>
            element.caisseName == widget.caisseNameModel.nomComplet &&
            element.typeOperation == "Decaissement")
        .toList();
    for (var item in recetteList) {
      recette += double.parse(item!.montant);
    }
    for (var item in depensesList) {
      depenses += double.parse(item!.montant);
    }
    return Card(
      color: Colors.red.shade700,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ResponsiveChild3Widget(
              child1: Row(
                children: [
                  SelectableText('Total recette: ',
                      style: bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SelectableText(
                      '${NumberFormat.decimalPattern('fr').format(recette)} \$',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ),
              child2: Row(
                children: [
                  SelectableText('Total dépenses: ',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SelectableText(
                      '${NumberFormat.decimalPattern('fr').format(depenses)} \$',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ),
              child3: Row(
                children: [
                  SelectableText('Solde: ',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SelectableText(
                      '${NumberFormat.decimalPattern('fr').format(recette - depenses)} \$',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ))),
    );
  }
}
