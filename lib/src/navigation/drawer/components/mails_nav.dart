import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class MailsNAv extends StatefulWidget {
  const MailsNAv({Key? key}) : super(key: key);

  @override
  State<MailsNAv> createState() => _MailsNAvState();
}

class _MailsNAvState extends State<MailsNAv> {
  ProfilController profilController = Get.find();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    String? pageCurrente = ModalRoute.of(context)!.settings.name;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Image.asset(
            InfoSystem().logo(),
            width: 100,
            height: 100,
          )),
          IconButton(
              color: mainColor,
              onPressed: () async {
                var departement = jsonDecode(profilController.user.departement);
                if (departement.first == "Administration") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(AdminRoutes.adminDashboard);
                  } else {
                    Get.toNamed(AdminRoutes.adminLogistique);
                  }
                } else if (departement.first == "Finances") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(FinanceRoutes.financeDashboard);
                  } else {
                    Get.toNamed(FinanceRoutes.transactionsDettes);
                  }
                } else if (departement.first == "Comptabilites") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(ComptabiliteRoutes.comptabiliteDashboard);
                  } else {
                    Get.toNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
                  }
                } else if (departement.first == "Budgets") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
                  } else {
                    Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
                  }
                } else if (departement.first == "Ressources Humaines") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(RhRoutes.rhDashboard);
                  } else {
                    Get.toNamed(RhRoutes.rhPresence);
                  }
                } else if (departement.first == "Exploitations") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(ExploitationRoutes.expDashboard);
                  } else {
                    Get.toNamed(TacheRoutes.tachePage);
                  }
                } else if (departement.first == "Marketing") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(MarketingRoutes.marketingDashboard);
                  } else {
                    Get.toNamed(MarketingRoutes.marketingAnnuaire);
                  }
                } else if (departement.first == "Commercial") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(ComRoutes.comDashboard);
                  } else {
                    Get.toNamed(ComRoutes.comVente);
                  }
                } else if (departement.first == "Logistique") {
                  if (int.parse(profilController.user.role) <= 2) {
                    Get.toNamed(LogistiqueRoutes.logDashboard);
                  } else {
                    Get.toNamed(LogistiqueRoutes.logMateriel);
                  }
                } else if (departement.first == "Support") {
                  Get.toNamed(AdminRoutes.adminDashboard);
                }
              },
              icon: Row(
                children: const [
                  Icon(Icons.backspace),
                  SizedBox(width: p10),
                  Text("Retour")
                ],
              )),
          const SizedBox(height: p20),
          DrawerWidget(
              selected: pageCurrente == MailRoutes.mails,
              icon: Icons.inbox,
              sizeIcon: 20.0,
              title: 'Boite de reception',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(MailRoutes.mails);
              }),
          DrawerWidget(
              selected: pageCurrente == MailRoutes.mailSend,
              icon: Icons.send,
              sizeIcon: 20.0,
              title: "Boite d'envoie",
              style: bodyText1,
              onTap: () {
                Get.toNamed(MailRoutes.mailSend); 
              }),
          DrawerWidget(
              selected: false,
              icon: Icons.chat,
              sizeIcon: 20.0,
              title: "Messenger",
              style: bodyText1,
              onTap: () {
                // Get.toNamed(MailRoutes.mailSend);
              }),
        ],
      ),
    );
  }
}
