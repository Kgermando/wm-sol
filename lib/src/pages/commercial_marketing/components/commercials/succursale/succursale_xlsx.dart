import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/comm_maketing/succursale_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SuccursaleXlsx {
  Future<void> exportToExcel(List<SuccursaleModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Succursales";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([
      "id",
      "name",
      "adresse",
      "province",
      "signature",
      "created",
      "approbationDG",
      "motifDG",
      "signatureDG",
      "approbationDD",
      "motifDD",
      "signatureDD"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [
        dataList[i].id.toString(),
        dataList[i].name,
        dataList[i].adresse,
        dataList[i].province,
        dataList[i].signature,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created),
        dataList[i].approbationDG,
        dataList[i].motifDG,
        dataList[i].signatureDG,
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
