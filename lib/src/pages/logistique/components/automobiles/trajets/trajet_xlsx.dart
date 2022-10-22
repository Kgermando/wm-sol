import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class TrajetXlsx {
  Future<void> exportToExcel(List<TrajetModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Trajets";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nomero Entreprise",
      "Conducteur",
      "Trajet De",
      "Trajet A",
      "Mission",
      "kilometrage Sorite",
      "kilometrage Retour",
      "Signature",
      "Date",
      "Approbation DD",
      "Motif DD",
      "Signature DD"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nomeroEntreprise,
        dataList[i].conducteur,
        dataList[i].trajetDe,
        dataList[i].trajetA,
        dataList[i].mission,
        dataList[i].kilometrageSorite,
        dataList[i].kilometrageRetour,
        dataList[i].signature,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created),
        dataList[i].approbationDD,
        dataList[i].motifDD,
        dataList[i].signatureDD,
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
