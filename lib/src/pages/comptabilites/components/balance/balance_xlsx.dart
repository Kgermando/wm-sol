import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class BalanceXlsx {
  Future<void> exportToExcel(List<BalanceSumModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Balances";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "comptes",
      "debit",
      "credit", 
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].comptes,
        dataList[i].debit.toString(),
        dataList[i].credit.toString(),  
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
