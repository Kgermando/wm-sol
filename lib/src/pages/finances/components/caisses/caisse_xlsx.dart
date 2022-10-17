import 'dart:io';

import 'package:excel/excel.dart'; 
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/finances/caisse_model.dart';

class CaisseXlsx {
  Future<void> exportToExcel(List<CaisseModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Caisse";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nom Complet",
      "Pièce Justificative",
      "Libelle",
      "Montant",
      "Département",
      "Type Operation",
      "Numero Operation",
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nomComplet,
        dataList[i].pieceJustificative,
        dataList[i].libelle,
        dataList[i].montant,
        dataList[i].departement,
        dataList[i].typeOperation,
        dataList[i].numeroOperation,
        dataList[i].signature,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created)
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
