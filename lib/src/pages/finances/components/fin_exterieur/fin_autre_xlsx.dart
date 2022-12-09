import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FinAutreXlsx {
  Future<void> exportToExcel(List<FinanceExterieurModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Banque";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Compte",
      "Titre",
      "PièceJustificative",
      "Libelle",
      "TypeOperation",
      "Montant Depot",
      "Montant Retrait",
      "Numero d'Operation",
      "Signature", 
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].financeExterieurName,
        dataList[i].nomComplet,
        dataList[i].pieceJustificative,
        dataList[i].libelle,
        dataList[i].typeOperation,
        dataList[i].montantDepot,
        dataList[i].montantRetrait, 
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
