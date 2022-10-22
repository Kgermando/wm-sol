import 'dart:io';

import 'package:excel/excel.dart'; 
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';

class MobilierXlsx {
  Future<void> exportToExcel(List<MobilierModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Mobiliers";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nom",
      "Modele",
      "Marque",
      "Description Mobilier",
      "Nombre",
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nom,
        dataList[i].modele,
        dataList[i].marque,
        dataList[i].descriptionMobilier,
        dataList[i].nombre,
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
