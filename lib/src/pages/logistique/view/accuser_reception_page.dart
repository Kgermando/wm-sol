import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class AccuseReceptionPage extends StatefulWidget {
  const AccuseReceptionPage({super.key});

  @override
  State<AccuseReceptionPage> createState() => _AccuseReceptionPageState();
}

class _AccuseReceptionPageState extends State<AccuseReceptionPage> {
  final ApprovisionReceptionController controller = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Accusé receptions";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!), (state) {
      var dataList = [];
      List<dynamic> departementList =
          jsonDecode(profilController.user.departement);
      for (var element in departementList) {
        dataList = controller.approvisionReceptionList
            .where((p0) => p0.departement == element)
            .toList();
 
      }

      return Scaffold(
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
                    controller: controller.scrollController,
                    physics: const ScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            final data = dataList[index];
                            return bonLivraisonItemWidget(data);
                          }),
                    )))
          ],
        ),
      );
    });
  }

  Widget bonLivraisonItemWidget(
      ApprovisionReceptionModel approvisionReceptionModel) {
    Color? nonRecu;
    if (approvisionReceptionModel.accuseReception == 'false') {
      nonRecu = const Color(0xFFFFC400);
    } else if (approvisionReceptionModel.livraisonAnnuler == 'true') {
      nonRecu = Colors.blueGrey[100];
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed(LogistiqueRoutes.logApprovisionReceptionDetail,
            arguments: approvisionReceptionModel);
      },
      child: Card(
        elevation: 10,
        color: nonRecu,
        child: ListTile(
          hoverColor: grey,
          dense: true,
          leading: const Icon(
            Icons.description_outlined,
            size: 40.0,
          ),
          title: Text(approvisionReceptionModel.provision,
              overflow: TextOverflow.clip,
              style: Responsive.isDesktop(context)
                  ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )
                  : const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    )),
          subtitle: Text(
            approvisionReceptionModel.departement,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (approvisionReceptionModel.livraisonAnnuler == 'true')
                const Text('Annulé', style: TextStyle(color: Colors.red)),
              Text(
                DateFormat("dd-MM-yyyy HH:mm")
                    .format(approvisionReceptionModel.created),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
