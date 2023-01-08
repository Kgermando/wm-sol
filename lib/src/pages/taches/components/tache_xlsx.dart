import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class TacheXlsx {
  Future<void> exportToExcel(List<TacheModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Taches";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nom",
      "Numero Tâche",
      "Personne",
      "Jalon",
      "Tache",
      "signature Responsable", 
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nom,
        dataList[i].numeroTache,
        dataList[i].agent,
        dataList[i].jalon,
        dataList[i].tache,
        dataList[i].signatureResp,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created),
      ];

      sheetObject.insertRowIterables(data, i + 1);
    }
    excel.setDefaultSheet(title);
    final dir = await getApplicationDocumentsDirectory();
    final dateTime = DateTime.now();
    final date = DateFormat("dd-MM-yy_HH-mm").format(dateTime);

    var onValue = excel.encode();
    File('${dir.path}/$title$date.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue!);
  }
}
