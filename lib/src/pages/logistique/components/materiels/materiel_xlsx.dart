import 'dart:io';

import 'package:excel/excel.dart'; 
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';

class MaterielXlsx {
  Future<void> exportToExcel(List<MaterielModel> dataList) async {
    var excel = Excel.createExcel();
    String title = "Engins";
    Sheet sheetObject = excel[title];
    sheetObject.insertRowIterables([ 
      'Type materiel',
      "Identifiant",
      "Marque",
      "Modèle",
      "Couleur", 
      "Numero Reference",
      "Numero PLaque",   
      "Genre",
      "Qty Max Reservoir",
      "Date Fabrication", 
      "Kilometrage Initiale",
      "Fournisseur",
      "Alimentation source", 
      "Signature",
      "Date"
    ], 0);

    for (int i = 0; i < dataList.length; i++) {
      List<String> data = [ 
        dataList[i].typeMateriel,
        dataList[i].identifiant,
        dataList[i].marque,
        dataList[i].modele,
        dataList[i].couleur,
        dataList[i].numeroRef,
        dataList[i].numeroPLaque, 
        dataList[i].genre,
        dataList[i].qtyMaxReservoir,
        DateFormat("dd/MM/yy HH-mm").format(dataList[i].dateFabrication), 
        dataList[i].kilometrageInitiale,
        dataList[i].fournisseur,
        dataList[i].alimentation, 
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
