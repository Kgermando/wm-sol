import 'dart:io';

import 'package:excel/excel.dart'; 
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';

class ActionnaireXlsx {
  Future<void> exportToExcel(List<ActionnaireModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Actionnaires";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nom",
      "PostNom",
      "Prenom",
      "Email",
      "Telephone",
      "Adresse",
      "Sexe",
      "Matricule",
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nom,
        dataList[i].postNom,
        dataList[i].prenom,
        dataList[i].email,
        dataList[i].telephone,
        dataList[i].adresse,
        dataList[i].sexe,
        dataList[i].matricule,
        dataList[i].signature,
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
