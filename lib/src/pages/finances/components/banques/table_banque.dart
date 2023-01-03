import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:wm_solution/src/models/finances/banque_name_model.dart';
import 'package:wm_solution/src/pages/finances/components/banques/banque_xlsx.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableBanque extends StatefulWidget {
  const TableBanque(
      {super.key,
      required this.banqueList,
      required this.controller,
      required this.banqueNameModel});
  final List<BanqueModel> banqueList;
  final BanqueController controller;
  final BanqueNameModel banqueNameModel;

  @override
  State<TableBanque> createState() => _TableBanqueState();
}

class _TableBanqueState extends State<TableBanque> {
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
    return Column(
      children: [
        Expanded(
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
              final dataId = tapEvent.row.cells.values;
              final idPlutoRow = dataId.last;

              final BanqueModel banqueModel =
                  await widget.controller.detailView(idPlutoRow.value);

              Get.toNamed(FinanceRoutes.transactionsBanqueDetail,
                  arguments: banqueModel);
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
                  TitleWidget(
                      title: widget.banqueNameModel.nomComplet.toUpperCase()),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.controller.getList();
                            Navigator.pushNamed(context,
                                '/transactions-banque/${widget.banqueNameModel.id}',
                                arguments: widget.banqueNameModel);
                          },
                          icon: Icon(Icons.refresh,
                              color: Colors.green.shade700)),
                      PrintWidget(onPressed: () {
                        BanqueXlsx().exportToExcel(widget.banqueList);
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
                  } else if (column.field == 'typeOperation') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  } else if (column.field == 'montantDepot') {
                    return resolver<PlutoFilterTypeContains>()
                        as PlutoFilterType;
                  } else if (column.field == 'montantRetrait') {
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
            rowColorCallback: (rowColorContext) {
              if (rowColorContext.row.cells.entries.elementAt(4).value.value ==
                  'Retrait') {
                return Colors.orange;
              }

              return Colors.white;
            },
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
    var i = widget.banqueList.length;
    for (var item in widget.banqueList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'nomComplet': PlutoCell(value: item.nomComplet),
          'pieceJustificative': PlutoCell(value: item.pieceJustificative),
          'libelle': PlutoCell(value: item.libelle),
          'typeOperation': PlutoCell(value: item.typeOperation),
          'montantDepot': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantDepot))} ${monnaieStorage.monney}"),
          'montantRetrait': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantRetrait))} ${monnaieStorage.monney}"),
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
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
          );
        },
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Titre',
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
        title: 'Montant Depot',
        field: 'montantDepot',
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
        title: 'Montant Retrait',
        field: 'montantRetrait',
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
        width: 300,
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

  Widget totalSolde() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    double recette = 0.0;
    double depenses = 0.0;
    var recetteList = widget.banqueList
        .where((element) =>
            element.banqueName == widget.banqueNameModel.nomComplet &&
            element.typeOperation == "Depot")
        .toList();
    var depensesList = widget.banqueList
        .where((element) =>
            element.banqueName == widget.banqueNameModel.nomComplet &&
            element.typeOperation == "Retrait")
        .toList();
    for (var item in recetteList) {
      recette += double.parse(item.montantDepot);
    }
    for (var item in depensesList) {
      depenses += double.parse(item.montantRetrait);
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
                      '${NumberFormat.decimalPattern('fr').format(recette)} ${monnaieStorage.monney}',
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
                      '${NumberFormat.decimalPattern('fr').format(depenses)} ${monnaieStorage.monney}',
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
                      '${NumberFormat.decimalPattern('fr').format(recette - depenses)} ${monnaieStorage.monney}',
                      style: bodyMedium.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ))),
    );
  }
}
