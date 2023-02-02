import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/bilan/table_blan.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class BilanComptabilite extends StatefulWidget {
  const BilanComptabilite({super.key});

  @override
  State<BilanComptabilite> createState() => _BilanComptabiliteState();
}

class _BilanComptabiliteState extends State<BilanComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "Bilan";

  @override
  Widget build(BuildContext context) {
    final BilanController controller = Get.find();
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: Responsive.isMobile(context) ? FloatingActionButton( 
          tooltip: "Ajpouter le Bilan",
          child: const Icon(Icons.add),
          onPressed: () {
            newFicheDialog(context, controller);
          }) :  FloatingActionButton.extended(
          label: const Text("Feuille Bilan"),
          tooltip: "Ajpouter le Bilan",
          icon: const Icon(Icons.add),
          onPressed: () {
            newFicheDialog(context, controller);
          }),
      body: Row(
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (data) => Container(
                  margin: const EdgeInsets.only(
                      top: p20, right: p20, left: p20, bottom: p8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TableBilan(
                      bilanList: controller.bilanList,
                      controller: controller)))),
        ],
      ) 
      
      );
  }

  newFicheDialog(BuildContext context, BilanController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Génerer le bilan'),
              content: SizedBox(
                  height: 200,
                  width: 300,
                  child: controller.isLoading
                      ? loading()
                      : Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              titleBilanWidget(controller)
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    controller.submit();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget titleBilanWidget(BilanController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.titleBilanController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre du Bilan',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }
}
