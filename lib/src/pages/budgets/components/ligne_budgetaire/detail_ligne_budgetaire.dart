import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DetailLigneBudgetaire extends StatefulWidget {
  const DetailLigneBudgetaire({super.key, required this.ligneBudgetaireModel});
  final LigneBudgetaireModel ligneBudgetaireModel;

  @override
  State<DetailLigneBudgetaire> createState() => _DetailLigneBudgetaireState();
}

class _DetailLigneBudgetaireState extends State<DetailLigneBudgetaire> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets"; 

  @override
  Widget build(BuildContext context) {
    final LignBudgetaireController controller =
      Get.put(LignBudgetaireController());

    return controller.obx(
    onLoading: loading(),
    onEmpty: const Text('Aucune donnée'),
    onError: (error) => Text(
        "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
    (state) => Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.ligneBudgetaireModel.nomLigneBudgetaire),
      drawer: const DrawerMenu(), 
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: p20, bottom: p8, right: p20, left: p20),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: p20),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
                ],
              ),
            ));
  }
}
