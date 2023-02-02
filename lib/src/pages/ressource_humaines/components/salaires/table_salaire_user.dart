import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/update/update_model.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/salaire_xlsx.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class TableSalaireUser extends StatefulWidget {
  const TableSalaireUser(
      {super.key,
      required this.personne,
      required this.salaireController,
      required this.salaireList});
  final AgentModel personne;
  final SalaireController salaireController;
  final List<PaiementSalaireModel> salaireList;

  @override
  State<TableSalaireUser> createState() => _TableSalaireUserState();
}

class _TableSalaireUserState extends State<TableSalaireUser> {
  EasyTableModel<PaiementSalaireModel>? _model;

  @override
  void initState() {
    super.initState();
    List<PaiementSalaireModel> rows = List.generate(
        widget.salaireList.length, (index) => widget.salaireList[index]);
    _model = EasyTableModel<PaiementSalaireModel>(rows: rows, columns: [
      EasyTableColumn(
        name: 'prenom',
        width: 300,
        stringValue: (row) => row.prenom),
      EasyTableColumn(
          name: 'nom', width: 150, stringValue: (row) => row.nom),
      EasyTableColumn(
          name: 'matricule', width: 150, stringValue: (row) => row.matricule),
      EasyTableColumn(
          name: 'departement', width: 150, stringValue: (row) => row.departement),
      EasyTableColumn(
          name: 'observation', width: 150, stringValue: (row) => (row.observation == 'true') ? "Payé" : "Non payé"),
      EasyTableColumn(
          name: 'modePaiement', width: 150, stringValue: (row) => row.modePaiement),
      EasyTableColumn(
          name: 'Date',
          width: 200,
          stringValue: (row) =>
              DateFormat("dd-MM-yy HH:mm").format(row.createdAt)), 
      EasyTableColumn(
          name: 'approbationDD', width: 150, stringValue: (row) => row.approbationDD),
      EasyTableColumn(
          name: 'approbationBudget', width: 150, stringValue: (row) => row.approbationBudget),
      EasyTableColumn(
          name: 'approbationFin', width: 150, stringValue: (row) => row.approbationFin),
      EasyTableColumn(
          name: 'signature', width: 150, stringValue: (row) => row.signature),
      
      
    ]);
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(title: 'Historique de paiements'),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.salaireController.getList();
                            Navigator.pushNamed(context, RhRoutes.rhPaiement);
                          });
                        },
                        icon: const Icon(Icons.refresh, color: Colors.green)),
                    PrintWidget(onPressed: () {
                    SalaireXlsx().exportToExcel(widget
                        .salaireController.paiementSalaireList
                        .where((e) =>
                            e.matricule == widget.personne.matricule &&
                            e.prenom == widget.personne.prenom &&
                            e.nom == widget.personne.nom)
                        .toList());
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Exportation effectué!"),
                      backgroundColor: Colors.green[700],
                    ));
                  })
                  ],
                )
              ],
            ),
            const SizedBox(height: p10),
            Expanded(
              child: EasyTable<PaiementSalaireModel>(
                _model,
                multiSort: true,
                columnsFit: true,
                onRowDoubleTap: (row) async {
                  final UpdateModel updateModel =
                      await widget.salaireController.detailView(row.id!);
                  Get.toNamed(UpdateRoutes.updateDetail,
                      arguments: updateModel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TableSalaireUser extends StatefulWidget {
//   const TableSalaireUser(
//       {super.key, required this.personne, required this.controller});
//   final AgentModel personne;
//   final SalaireController controller;

//   @override
//   State<TableSalaireUser> createState() => _TableSalaireUserState();
// }

// class _TableSalaireUserState extends State<TableSalaireUser> {
//   List<PlutoColumn> columns = [];
//   List<PlutoRow> rows = [];
//   PlutoGridStateManager? stateManager;
//   PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

//   @override
//   initState() {
//     agentsColumn();
//     agentsRow();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 4,
//       child: PlutoGrid(
//         columns: columns,
//         rows: rows,
//         onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent tapEvent) async {
//           final dataId = tapEvent.row.cells.values;
//           final idPlutoRow = dataId.last;

//           final PaiementSalaireModel dataItem =
//               await widget.controller.detailView(idPlutoRow.value);

//           Get.toNamed(RhRoutes.rhPaiementBulletin, arguments: dataItem);
//         },
//         onLoaded: (PlutoGridOnLoadedEvent event) {
//           stateManager = event.stateManager;
//           stateManager!.setShowColumnFilter(true);
//           stateManager!.notifyListeners();
//         },
//         createHeader: (PlutoGridStateManager header) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const TitleWidget(title: "Salaires"),
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         widget.controller.getList();
//                         Navigator.pushNamed(context, RhRoutes.rhPaiement);
//                       },
//                       icon: Icon(Icons.refresh, color: Colors.green.shade700)),
//                   PrintWidget(onPressed: () {
//                     SalaireXlsx().exportToExcel(widget
//                         .controller.paiementSalaireList
//                         .where((e) =>
//                             e.matricule == widget.personne.matricule &&
//                             e.prenom == widget.personne.prenom &&
//                             e.nom == widget.personne.nom)
//                         .toList());
//                     if (!mounted) return;
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: const Text("Exportation effectué!"),
//                       backgroundColor: Colors.green[700],
//                     ));
//                   })
//                 ],
//               ),
//             ],
//           );
//         },
//         configuration: PlutoGridConfiguration(
//           columnFilter: PlutoGridColumnFilterConfig(
//             filters: const [
//               ...FilterHelper.defaultFilters,
//             ],
//             resolveDefaultColumnFilter: (column, resolver) {
//               if (column.field == 'numero') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'prenom') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'nom') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'matricule') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'departement') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'observation') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'modePaiement') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'salaire') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'created') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'approbationDD') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'approbationBudget') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'approbationFin') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               } else if (column.field == 'id') {
//                 return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//               }
//               return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
//             },
//           ),
//         ),
//         createFooter: (stateManager) {
//           stateManager.setPageSize(20, notify: false); // default 40
//           return PlutoPagination(stateManager);
//         },
//       ),
//     );
//   }

//   Future<List<PlutoRow>> agentsRow() async {
//     var dataList = widget.controller.paiementSalaireList
//         .where((e) =>
//             e.matricule == widget.personne.matricule &&
//             e.prenom == widget.personne.prenom &&
//             e.nom == widget.personne.nom)
//         .toList();
//     var i = dataList.length;
//     List.generate(dataList.length, (index) {
//       var item = dataList[index];
//       return rows.add(PlutoRow(cells: {
//         'numero': PlutoCell(value: i--),
//         'prenom': PlutoCell(value: item.prenom),
//         'nom': PlutoCell(value: item.nom),
//         'matricule': PlutoCell(value: item.matricule),
//         'departement': PlutoCell(value: item.departement),
//         'observation': PlutoCell(
//             value: (item.observation == 'true') ? "Payé" : "Non payé"),
//         'modePaiement': PlutoCell(value: item.modePaiement),
//         'createdAt': PlutoCell(
//             value: DateFormat("dd-MM-yyyy HH:mm").format(item.createdAt)),
//         'approbationDD': PlutoCell(value: item.approbationDD),
//         'approbationBudget': PlutoCell(value: item.approbationBudget),
//         'approbationFin': PlutoCell(value: item.approbationFin),
//         'id': PlutoCell(value: item.id)
//       }));
//     });
//     return rows;
//   }

//   void agentsColumn() {
//     columns = [
//       PlutoColumn(
//         readOnly: true,
//         title: 'N°',
//         field: 'numero',
//         type: PlutoColumnType.number(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 100,
//         minWidth: 80,
//         renderer: (rendererContext) {
//           return Text(
//             rendererContext.cell.value.toString(),
//             textAlign: TextAlign.center,
//           );
//         },
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Prénom',
//         field: 'prenom',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Nom',
//         field: 'nom',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Matricule',
//         field: 'matricule',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Département',
//         field: 'departement',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Observation',
//         field: 'observation',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Mode de paiement',
//         field: 'modePaiement',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Date',
//         field: 'createdAt',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 200,
//         minWidth: 150,
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Approbation DD',
//         field: 'approbationDD',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 300,
//         minWidth: 150,
//         renderer: (rendererContext) {
//           Color textColor = Colors.black;
//           if (rendererContext.cell.value == 'Approved') {
//             textColor = Colors.green;
//           } else if (rendererContext.cell.value == 'Unapproved') {
//             textColor = Colors.red;
//           } else if (rendererContext.cell.value == '-') {
//             textColor = Colors.orange;
//           }
//           return Text(
//             rendererContext.cell.value.toString(),
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         },
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Approbation Budget',
//         field: 'approbationBudget',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 300,
//         minWidth: 150,
//         renderer: (rendererContext) {
//           Color textColor = Colors.black;
//           if (rendererContext.cell.value == 'Approved') {
//             textColor = Colors.green;
//           } else if (rendererContext.cell.value == 'Unapproved') {
//             textColor = Colors.red;
//           } else if (rendererContext.cell.value == '-') {
//             textColor = Colors.orange;
//           }
//           return Text(
//             rendererContext.cell.value.toString(),
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         },
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Approbation Fin',
//         field: 'approbationFin',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 300,
//         minWidth: 150,
//         renderer: (rendererContext) {
//           Color textColor = Colors.black;
//           if (rendererContext.cell.value == 'Approved') {
//             textColor = Colors.green;
//           } else if (rendererContext.cell.value == 'Unapproved') {
//             textColor = Colors.red;
//           } else if (rendererContext.cell.value == '-') {
//             textColor = Colors.orange;
//           }
//           return Text(
//             rendererContext.cell.value.toString(),
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         },
//       ),
//       PlutoColumn(
//         readOnly: true,
//         title: 'Id',
//         field: 'id',
//         type: PlutoColumnType.text(),
//         enableRowDrag: true,
//         enableContextMenu: false,
//         enableDropToResize: true,
//         titleTextAlign: PlutoColumnTextAlign.left,
//         width: 300,
//         minWidth: 80,
//         renderer: (rendererContext) {
//           return Text(
//             rendererContext.cell.value.toString(),
//             textAlign: TextAlign.center,
//           );
//         },
//       ),
//     ];
//   }
// }
