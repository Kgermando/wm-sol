import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CampagneXlsx {
  Future<void> exportToExcel(List<CampaignModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Campagnes";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([
      "id",
      "Type de Produit",
      "Date Debut Et Fin",
      "Coût Campagne",
      "Lieu Ciblé",
      "Promotion",
      "Objectifs",
      "Observation",
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [
        dataList[i].id.toString(),
        dataList[i].typeProduit,
        dataList[i].dateDebutEtFin,
        dataList[i].coutCampaign,
        dataList[i].lieuCible,
        dataList[i].promotion,
        dataList[i].objectifs,
        dataList[i].observation,
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
