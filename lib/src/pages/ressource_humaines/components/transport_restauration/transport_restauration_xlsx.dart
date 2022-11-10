import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class TransportRestXlsx {
  Future<void> exportToExcel(List<TransportRestaurationModel> dataList) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Transport & Restauration'];
    sheetObject.insertRowIterables([
      "id",
      "Titre",
      "Observation", 
      "Date",  
      "Ligne Budgetaire",
      "Ressource"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [
        dataList[i].id.toString(),
        dataList[i].title,
        dataList[i].observation, 
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created), 
        dataList[i].ligneBudgetaire,
        dataList[i].ressource
      ];

      sheetObject.insertRowIterables(data, i + 1);
    }
    excel.setDefaultSheet('Transport & Restauration');
    final dir = await getApplicationDocumentsDirectory();
    final dateTime = DateTime.now();
    final date = DateFormat("dd-MM-yy_HH-mm").format(dateTime);

    var onValue = excel.encode();
    File('${dir.path}/transport_restauration$date.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue!);
  }
}
