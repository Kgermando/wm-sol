import 'dart:io';
 
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';

class JournalXlsx {
  Future<void> exportToExcel(List<JournalModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Journals";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([
      "Numero Operation",
      "Libele",
      "Compte Debit",
      "Montant Debit",
      "Compte Credit",
      "Montant Credit", 
      "Signature", 
      "Date",
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].numeroOperation,
        dataList[i].libele,
        dataList[i].compteDebit,
        dataList[i].montantDebit,
        dataList[i].compteCredit,
        dataList[i].montantCredit, 
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
