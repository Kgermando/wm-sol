import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/table_balance.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class BalanceComptabilite extends StatefulWidget {
  const BalanceComptabilite({super.key});

  @override
  State<BalanceComptabilite> createState() => _BalanceComptabiliteState();
}

class _BalanceComptabiliteState extends State<BalanceComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "balance";

  @override
  Widget build(BuildContext context) {
    final BalanceController controller = Get.put(BalanceController());

    return SafeArea(
      child: controller.obx(
          onLoading: loading(),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => Text(
              "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                  label: const Text("Feuille Balance"),
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
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableBalance(balanceList: controller.balanceList, controller: controller))),
                ],
              ))),
    );
  }

  newFicheDialog(BuildContext context, BalanceController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              scrollable: true,
              title: Text('New document', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  // height: 200,
                  width: 300,
                  child: Form(
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
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget titleBilanWidget(BalanceController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.titleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre du Balance',
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