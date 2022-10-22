import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ImmobilierXlsx {
  Future<void> exportToExcel(List<ImmobilierModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Immobiliers";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Type Allocation",
      "Adresse",
      "Numero Certificat",
      "Superficie",
      "Date Acquisition",
      "Signature",
      "Date", 
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].typeAllocation,
        dataList[i].adresse,
        dataList[i].numeroCertificat,
        dataList[i].superficie,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].dateAcquisition),
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
