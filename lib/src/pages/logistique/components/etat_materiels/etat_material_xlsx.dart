import 'dart:io';

import 'package:excel/excel.dart'; 
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';

class EtatMaterielXlsx {
  Future<void> exportToExcel(List<EtatMaterielModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "EtatMateriels";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nom",
      "Nodele",
      "Marque",
      "Type Objet",
      "Statut",
      "Signature",
      "Date", 
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nom,
        dataList[i].modele,
        dataList[i].marque,
        dataList[i].typeObjet,
        dataList[i].statut,
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
