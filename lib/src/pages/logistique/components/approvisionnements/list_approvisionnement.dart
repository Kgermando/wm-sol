import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/routes/routes.dart';

class ListApprovisionnement extends StatelessWidget {
  const ListApprovisionnement(
      {Key? key, required this.approvisionnementModel, required this.role})
      : super(key: key);
  final ApprovisionnementModel approvisionnementModel;
  final String role;

  @override
  Widget build(BuildContext context) {
    var restesenPourcent =
        (double.parse(approvisionnementModel.quantity) * 100) /
            double.parse(approvisionnementModel.quantityTotal);
    int roleAgent = int.parse(role);
    return GestureDetector(
      onTap: () {
        if (roleAgent <= 3) {
          Get.toNamed(LogistiqueRoutes.logApprovisionnementDetail,
              arguments: approvisionnementModel);
        }
      },
      child: Card(
          elevation: 10,
          color: colorQty(),
          child: ListTile(
            dense: true,
            leading: const Icon(
              Icons.shopping_basket_sharp,
              color: Colors.black,
              size: 40.0,
            ),
            title: Text(approvisionnementModel.provision,
                overflow: TextOverflow.clip,
                style: Responsive.isDesktop(context)
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black)
                    : const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
            subtitle: Text(
  'Qté disponible: ${double.parse(approvisionnementModel.quantity).toStringAsFixed(0)} ${approvisionnementModel.unite}',
              overflow: TextOverflow.clip,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.black),
            ),
            trailing: Text('${restesenPourcent.toStringAsFixed(2)} %',
                style: Responsive.isDesktop(context)
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black)
                    : const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black)),
          )),
    );
  }

  colorQty() {
    var color50 = double.parse(approvisionnementModel.quantityTotal) / 2;
    var color40 = double.parse(approvisionnementModel.quantityTotal) / 4;
    var color8 = color40 / 4;

    var color35 = color40 + color8;
    var color75 = color50 + color40;

    if (double.parse(approvisionnementModel.quantityTotal) ==
        double.parse(approvisionnementModel.quantity)) {
      return Colors.green[400];
    } else if (double.parse(approvisionnementModel.quantity) >= color75) {
      return Colors.green[300];
    } else if (double.parse(approvisionnementModel.quantity) >= color50) {
      return Colors.teal[200];
    } else if (double.parse(approvisionnementModel.quantity) >= color50) {
      return Colors.teal[100];
    } else if (double.parse(approvisionnementModel.quantity) >= color35) {
      return Colors.yellow[200];
    } else if (double.parse(approvisionnementModel.quantity) >= color40) {
      return Colors.orange[200];
    } else if (double.parse(approvisionnementModel.quantity) >= color8) {
      return Colors.yellow;
    } else if (double.parse(approvisionnementModel.quantity) >= 0.0) {
      return Colors.red[300];
    } else {
      return Colors.red[400];
    }
  }
}
