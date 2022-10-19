import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/exploitations/agent_role_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PersonnelsRolesXlsx {
  Future<void> exportToExcel(List<AgentRoleModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Personnels";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables(["Personnels", "Rôles"], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].agent,
        dataList[i].role,
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
