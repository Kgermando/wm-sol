// import 'package:pluto_grid/pluto_grid.dart';

// class PlutotGridDataTable {

//   static List<PlutoRow> rowsByColumns({
//     required int length,
//     required List<PlutoColumn> columns,
//   }) {
//     return List<int>.generate(length, (index) => index).map((_) {
//       return rowByColumns(columns);
//     }).toList();
//   }

//   static PlutoRow rowByColumns(List<PlutoColumn> columns) {
//     final cells = <String, PlutoCell>{};

//     for (var column in columns) {
//       cells[column.field] = PlutoCell(
//         value: valueByColumnType(column),
//       );
//     }

//     return PlutoRow(cells: cells);
//   }

//     static dynamic valueByColumnType(PlutoColumn column) {
//     if (column.type.isNumber || column.type.isCurrency) {
//       return faker.randomGenerator.decimal(scale: 1000000000, min: -500000000);
//     } else if (column.type.isSelect) {
//       return (column.type.select.items.toList()..shuffle()).first;
//     } else if (column.type.isDate) {
//       return DateTime.now()
//           .add(Duration(days: faker.randomGenerator.integer(365, min: -365)))
//           .toString();
//     } else if (column.type.isTime) {
//       final hour = faker.randomGenerator.integer(12).toString().padLeft(2, '0');
//       final minute =
//           faker.randomGenerator.integer(60).toString().padLeft(2, '0');
//       return '$hour:$minute';
//     } else {
//       return faker.randomGenerator.element(multilingualWords);
//     }
//   }
// }