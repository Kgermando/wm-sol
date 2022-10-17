import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CreanceXlsx {
  Future<void> exportToExcel(List<CreanceModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Créances";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([
      "Nom Complet",
      "Pièce Justificative",
      "Libelle",
      "Montant",
      "Numero Operation",
      "Statut Paie",
      "Signature",
      "Date",
      "Approbation DG",
      "Motif DG",
      "Signature DG",
      "Approbation DD",
      "Motif DD",
      "Signature DD"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].nomComplet,
        dataList[i].pieceJustificative,
        dataList[i].libelle,
        dataList[i].montant,
        dataList[i].numeroOperation,
        dataList[i].statutPaie,
        dataList[i].signature,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].created),
        dataList[i].approbationDG,
        dataList[i].motifDG,
        dataList[i].signatureDG,
        dataList[i].approbationDD,
        dataList[i].motifDD,
        dataList[i].signatureDD
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
