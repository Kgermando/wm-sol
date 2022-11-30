import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/journal_xlsx.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableJournal extends StatefulWidget {
  const TableJournal(
      {super.key, required this.controller, required this.journalList});
  final JournalController controller;
  final List<JournalModel> journalList;

  @override
  State<TableJournal> createState() => _TableJournalState();
}

class _TableJournalState extends State<TableJournal> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  late PlutoGridStateManager stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  initState() {
    agentsColumn();
    agentsRow().then((value) => stateManager.setShowLoading(false));
    // fetchRows().then((fetchedRows) {
    //   print("fetchedRows $fetchedRows");
    //   PlutoGridStateManager.initializeRowsAsync(
    //     columns,
    //     fetchedRows,
    //   ).then((value) {
    //     stateManager.refRows.addAll(value);
    //     stateManager.setShowLoading(false);
    //   });
    // });

    super.initState();
  }

  // Future<List<PlutoRow>> fetchRows() {
  //   final Completer<List<PlutoRow>> completer = Completer();

  //   final List<PlutoRow> _rows = [];

  //   int count = 0;

  //   int max = widget.journalList.length;

  //   int totalRows = max;
  //   print("totalRows $totalRows");

  //   Timer.periodic(const Duration(milliseconds: 1), (timer) {
  //     if (count == max) {
  //       return;
  //     }

  //     ++count;

  //     print("count $count");

  //     Future(() {
  //       var i = widget.journalList.length;
  //       for (var item in widget.journalList) {
  //         _rows.add(PlutoRow(cells: {
  //           'numero': PlutoCell(value: i--),
  //           'numeroOperation': PlutoCell(value: item.numeroOperation),
  //           'libele': PlutoCell(value: item.libele),
  //           'compteDebit': PlutoCell(value: item.compteDebit),
  //           'montantDebit': PlutoCell(value: "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantDebit))} ${monnaieStorage.monney}"),
  //           'compteCredit': PlutoCell(value: item.compteCredit),
  //           'montantCredit': PlutoCell(value: "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantCredit))} ${monnaieStorage.monney}"),
  //           'signature': PlutoCell(value: item.signature),
  //           'created': PlutoCell(
  //               value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
  //           'locker': PlutoCell(value: item.locker),
  //           'id': PlutoCell(value: item.id)
  //         }));
  //       }
  //       return _rows;
  //     }).then((value) {
  //       // _rows.addAll(value);
  //       print("length ${value.length}");
  //       print("value $value");

  //       if (value.length == totalRows) {
  //         completer.complete(value);

  //         timer.cancel();
  //       }
  //     });
  //   });
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: columns,
      rows: rows,
      // onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
      //   final dataId = tapEvent.row.cells.values;
      //   final idPlutoRow = dataId.last;

      //   final JournalModel journalModel =
      //       await widget.controller.detailView(idPlutoRow.value);

      //   Get.toNamed(ComptabiliteRoutes.comptabiliteJournalDetail,
      //       arguments: journalModel);
      // },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setShowColumnFilter(true);
        stateManager.setShowLoading(true);
      },
      createHeader: (PlutoGridStateManager header) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleWidget(title: "Livre Journal"),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ComptabiliteRoutes.comptabiliteJournalLivre);
                    },
                    icon: Icon(Icons.refresh, color: Colors.green.shade700)),
                PrintWidget(onPressed: () {
                  JournalXlsx().exportToExcel(widget.controller.journalList);
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
            } else if (column.field == 'numeroOperation') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'libele') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'compteDebit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'montantDebit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'compteCredit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'montantCredit') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'signature') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'created') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'locker') {
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
    var i = widget.journalList.length;
    for (var item in widget.journalList) {
      setState(() {
        rows.add(PlutoRow(cells: {
          'numero': PlutoCell(value: i--),
          'numeroOperation': PlutoCell(value: item.numeroOperation),
          'libele': PlutoCell(value: item.libele),
          'compteDebit': PlutoCell(value: item.compteDebit),
          'montantDebit': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantDebit))} ${monnaieStorage.monney}"),
          'compteCredit': PlutoCell(value: item.compteCredit),
          'montantCredit': PlutoCell(
              value:
                  "${NumberFormat.decimalPattern('fr').format(double.parse(item.montantCredit))} ${monnaieStorage.monney}"),
          'signature': PlutoCell(value: item.signature),
          'created': PlutoCell(
              value: DateFormat("dd-MM-yyyy HH:mm").format(item.created)),
          // 'locker': PlutoCell(value: item.locker),
          // 'id': PlutoCell(value: item.id)
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
        title: 'N° Operation',
        field: 'numeroOperation',
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
        title: 'Libele',
        field: 'libele',
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
        title: 'Compte Debit',
        field: 'compteDebit',
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
        title: 'Montant Debit',
        field: 'montantDebit',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          );
        },
        width: 150,
        minWidth: 150,
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Compte Credit',
        field: 'compteCredit',
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
        title: 'Montant Credit',
        field: 'montantCredit',
        type: PlutoColumnType.text(),
        enableRowDrag: true,
        enableContextMenu: false,
        enableDropToResize: true,
        titleTextAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          return Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          );
        },
        width: 150,
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
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Locker',
      //   field: 'locker',
      //   type: PlutoColumnType.text(),
      //   enableRowDrag: true,
      //   enableContextMenu: false,
      //   enableDropToResize: true,
      //   titleTextAlign: PlutoColumnTextAlign.left,
      //   width: 150,
      //   minWidth: 150,
      // renderer: (rendererContext) {
      //   Color textColor = Colors.black;
      //   if (rendererContext.cell.value == 'Approved') {
      //     textColor = Colors.green;
      //   } else if (rendererContext.cell.value == 'Unapproved') {
      //     textColor = Colors.red;
      //   } else if (rendererContext.cell.value == '-') {
      //     textColor = Colors.orange;
      //   }
      //   return Text(
      //     rendererContext.cell.value.toString(),
      //     style: TextStyle(
      //       color: textColor,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   );
      // },
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Id',
      //   field: 'id',
      //   type: PlutoColumnType.text(),
      //   enableRowDrag: true,
      //   enableContextMenu: false,
      //   enableDropToResize: true,
      //   titleTextAlign: PlutoColumnTextAlign.left,
      //   width: 80,
      //   minWidth: 80,
      // ),
    ];
  }
}
