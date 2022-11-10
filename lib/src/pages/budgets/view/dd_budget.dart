import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_budget_previsionnel_dd.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_campaigns_budget.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_devis_budget.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_projet_budget.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_salaire_budget.dart';
import 'package:wm_solution/src/pages/budgets/components/dd_budget/table_transport_rest_budget.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/notify/budget_notify_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/notify/marketing_notify.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart';
import 'package:wm_solution/src/pages/exploitations/controller/notify/notify_exp.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class DDBudget extends StatefulWidget {
  const DDBudget({super.key});

  @override
  State<DDBudget> createState() => _DDBudgetState();
}

class _DDBudgetState extends State<DDBudget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
  String subTitle = "Direteur de département";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;
  bool isOpen6 = false;


  @override
  Widget build(BuildContext context) {
    final BudgetPrevisionnelController budgetPrevisionnelController =
        Get.find();
    final BudgetNotifyController budgetNotifyController = Get.find();
    final RHNotifyController rhNotifyController = Get.find();
      final MarketingNotifyController marketingNotifyController = Get.find();
    final NotifyExpController expController = Get.find();
    final SalaireController salaireController = Get.find();
    final TransportRestController transportRestController = Get.find();
    final DevisNotifyController devisNotifyController = Get.find();
    final DevisController devisController = Get.find();
    final CampaignController campaignController = Get.find();
    final ProjetController projetController = Get.find();

    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return SafeArea(
      child: Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.red.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text('Dossier Salaires',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous avez ${rhNotifyController.itemCountSalaireBudget} dossiers necessitent votre approbation",
                          style: bodyMedium!
                              .copyWith(color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen1 = !val;
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      children: [TableSalaireBudget(salaireController: salaireController)],
                    ),
                  ),
                  Card(
                    color: Colors.blue.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text(
                          'Dossier Transports & Restaurations',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous ${rhNotifyController.itemCountTransRestBudget} dossiers necessitent votre approbation",
                          style: bodyMedium.copyWith(
                              color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen6 = !val;
                        });
                      },
                      trailing: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      children: [
                        TableTransportRestBudget(transportRestController: transportRestController)
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.yellow.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text('Dossier Campaigns',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous avez ${marketingNotifyController.campaignCountBudget} dossiers necessitent votre approbation",
                          style: bodyMedium.copyWith(
                              color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen2 = !val;
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      children: [TableCampaignBudget(
                                    campaignController: campaignController)],
                    ),
                  ),
                  Card(
                    color: Colors.grey.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text('Dossier Etat de besoins',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous avez ${devisNotifyController.itemCountDevisBudget} dossiers necessitent votre approbation",
                          style: bodyMedium.copyWith(
                              color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen3 = !val;
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      children: [
                        TableDevisBudget(devisController: devisController)
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.blue.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text('Dossier Projets',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous avez ${expController.itemCountProjetBudget} dossiers necessitent votre approbation",
                          style: bodyMedium.copyWith(
                              color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen4 = !val;
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      children: [TableProjetBudget(projetController: projetController)],
                    ),
                  ),
                  Card(
                    color: Colors.green.shade700,
                    child: ExpansionTile(
                      leading: const Icon(Icons.folder,
                          color: Colors.white),
                      title: Text('Dossier budgets',
                          style: (Responsive.isDesktop(context))
                              ? headline6!
                                  .copyWith(color: Colors.white)
                              : bodyLarge!
                                  .copyWith(color: Colors.white)),
                      subtitle: Text(
                          "Vous avez ${budgetNotifyController.itemCountDD} dossiers necessitent votre approbation",
                          style: bodyMedium.copyWith(
                              color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen5 = !val;
                        });
                      },
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      children: [
                        TableBudgetPrevisionnelDD(
                                        budgetPrevisionnelController:
                                            budgetPrevisionnelController)
                      ],
                    ),
                  ),
                ])),
      ))
            ],
          )),
    );
  }
}