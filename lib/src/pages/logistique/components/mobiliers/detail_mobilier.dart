import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/mobiliers/approbation_mobilier.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailMobiler extends StatefulWidget {
  const DetailMobiler({super.key, required this.mobilierModel});
  final MobilierModel mobilierModel;

  @override
  State<DetailMobiler> createState() => _DetailMobilerState();
}

class _DetailMobilerState extends State<DetailMobiler> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  @override
  Widget build(BuildContext context) {
    final MobilierController controller = Get.find();
    final ProfilController profilController = Get.find();

    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.mobilierModel.nom),
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
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(
                                                title: "Mobilier"),
                                            Column(
                                              children: [
                                                if (int.parse(profilController
                                                            .user.role) <=
                                                        3 ||
                                                    widget.mobilierModel
                                                            .approbationDD ==
                                                        "Unapproved")
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          tooltip: 'Modifier',
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                LogistiqueRoutes
                                                                    .logMobilierMaterielUpdate,
                                                                arguments: widget
                                                                    .mobilierModel);
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
                                                      IconButton(
                                                          tooltip: 'Supprimer',
                                                          onPressed: () async {
                                                            alertDeleteDialog(
                                                                controller);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors
                                                              .red.shade700),
                                                    ],
                                                  ),
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .mobilierModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget()
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: p20),
                                ApprobationMobilier(
                                    data: widget.mobilierModel,
                                    controller: controller,
                                    profilController: profilController)
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  alertDeleteDialog(MobilierController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.red)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le document")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    controller.deleteData(widget.mobilierModel.id!);
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              child1: Text('Nom Complet :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.nom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Modèle :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.modele,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Marque :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.marque,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Description :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.descriptionMobilier,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Nombre :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.nombre,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Signature :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.mobilierModel.signature,
                  textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }
}
