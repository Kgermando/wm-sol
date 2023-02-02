// import 'package:get/get.dart';
// import 'package:wm_solution/src/constants/app_theme.dart';
// import 'package:easy_table/easy_table.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:wm_solution/src/models/rh/presence_model.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart'; 
// import 'package:wm_solution/src/routes/routes.dart';
// import 'package:wm_solution/src/widgets/title_widget.dart';

// class TablePresenceToday extends StatefulWidget {
//   const TablePresenceToday(
//       {super.key, required this.presenceList, required this.controller});
//   final List<PresenceModel> presenceList;
//   final PresenceController controller;

//   @override
//   State<TablePresenceToday> createState() => _TablePresenceTodayState();
// }

// class _TablePresenceTodayState extends State<TablePresenceToday> { 
//   EasyTableModel<PresenceModel>? _model;

//   @override
//   void initState() {
//     super.initState();
//     List<PresenceModel> rows = List.generate(widget.presenceList.length,
//         (index) => widget.presenceList[index]);
//     _model = EasyTableModel<PresenceModel>(rows: rows, columns: [
//       EasyTableColumn(
//         headerAlignment: Alignment.center,
//         cellAlignment: Alignment.centerLeft,
//           name: 'Designation',
//           width: 300,
//           stringValue: (row) => row.designation),
//       EasyTableColumn(
//           name: 'Signature', width: 100, stringValue: (row) => row.signature),
//       EasyTableColumn(
//           name: 'Date',
//           width: 150,
//           stringValue: (row) =>
//               DateFormat("dd-MM-yy HH:mm").format(row.created)),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(p10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const TitleWidget(title: 'Matières premières'),
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         widget.controller.getList();
//                       });
//                     },
//                     icon: const Icon(Icons.refresh, color: Colors.green))
//               ],
//             ),
//             const SizedBox(height: p10),
//             SizedBox(
//                 height: 300,
//                 child: EasyTable<FournisseurModel>(
//                   _model,
//                   multiSort: true,
                    // columnsFit: true,
//                   onRowDoubleTap: (row) async {
//                     final FournisseurModel fournisseurModel =
//                         await widget.controller.detailView(row.id!);
//                     Get.toNamed(ExploitationRoutes.expFournisseurDetail,
//                         arguments: fournisseurModel);
//                   },
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
