import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/dd_comptabilite/table_balance_dd.dart';
import 'package:wm_solution/src/pages/comptabilites/components/dd_comptabilite/table_blan_dd.dart';
import 'package:wm_solution/src/pages/comptabilites/components/dd_comptabilite/table_compte_resultat_dd.dart';
import 'package:wm_solution/src/pages/comptabilites/components/dd_comptabilite/table_journal_livre_dd.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';


class DDComptabilite extends StatefulWidget {
  const DDComptabilite({super.key});

  @override
  State<DDComptabilite> createState() => _DDComptabiliteState();
}

class _DDComptabiliteState extends State<DDComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilité";
  String subTitle = "Direteur de département";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;

  @override
  Widget build(BuildContext context) {
    final ComptabiliteNotifyController notify = Get.find();
    final BalanceController balanceController = Get.find();
    final BilanController bilanController = Get.find();
    final CompteResultatController compteResultatController = Get.find();
    final JournalLivreController journalLivreController = Get.find();
    
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          body: Obx(() => Row(
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
                                color: Colors.orange.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(
                                    Icons.folder,
                                    color: Colors.white,
                                  ),
                                  title: Text('Dossier Compte Balances',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle: Text(
                                          "Vous avez ${notify.balanceCount} dossiers necessitent votre approbation",
                                          style: bodyMedium!
                                              .copyWith(color: Colors.white70)),
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
                                  children: [TableBalanceCompteDD(balanceController: balanceController)],
                                ),
                              ),
                              Card(
                                color: Colors.blue.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(
                                    Icons.folder,
                                    color: Colors.white,
                                  ),
                                  title: Text('Dossier Bilans',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${notify.bilanCount} dossiers necessitent votre approbation",
                                      style: bodyMedium.copyWith(
                                          color: Colors.white70))) ,
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
                                  children: [TableCompteBilanDD(bilanController: bilanController)],
                                ),
                              ),
                              Card(
                                color: Colors.teal.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(
                                    Icons.folder,
                                    color: Colors.white,
                                  ),
                                  title: Text('Dossier Compte resultats',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle: Text(
                                          "Vous avez ${notify.compteResultatCount} dossiers necessitent votre approbation",
                                          style: bodyMedium.copyWith(color: Colors.white70)),
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
                                  children: [TableCompteResultatDD(compteResultatController: compteResultatController)],
                                ),
                              ),
                              Card(
                                color: Colors.purple.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(
                                    Icons.folder,
                                    color: Colors.white,
                                  ),
                                  title: Text('Dossier Compte journals',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle: Text(
                                          "Vous avez ${notify.journalCount} dossiers necessitent votre approbation",
                                          style: bodyMedium.copyWith(color: Colors.white70)),
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
                                  children: [
                                    TableJournalComptabiliteDD(journalLivreController: journalLivreController)
                                  ],
                                ),
                              ),
                            ])),
                  ))
            ],
          )) ),
    );
  }
}