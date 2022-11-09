import 'dart:io';

import 'package:excel/excel.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class EnginXlsx {
  Future<void> exportToExcel(List<AnguinModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Engins";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      "Nomero PLaque",
      "Marque",
      "Modèle",
      "Numero Chassie",
      "Couleur",
      "Genre",
      "Qty Max Reservoir",
      "Date Fabrication",
      "Nomero Entreprise",
      "Kilometrage Initiale",
      "Provenance",
      "Type Caburant",
      "Type Moteur",
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].marque,
        dataList[i].nomeroPLaque,
        dataList[i].modele,
        dataList[i].numeroChassie,
        dataList[i].couleur,
        dataList[i].genre,
        dataList[i].qtyMaxReservoir,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].dateFabrication),
        dataList[i].nomeroEntreprise,
        dataList[i].kilometrageInitiale,
        dataList[i].provenance,
        dataList[i].typeCaburant,
        dataList[i].typeMoteur,
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
