import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class UpdateEtatMateriel extends StatefulWidget {
  const UpdateEtatMateriel({super.key, required this.etatMaterielModel});
  final EtatMaterielModel etatMaterielModel;

  @override
  State<UpdateEtatMateriel> createState() => _UpdateEtatMaterielState();
}

class _UpdateEtatMaterielState extends State<UpdateEtatMateriel> {
  final EtatMaterielController controller = Get.put(EtatMaterielController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Ajout du statut materiel";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
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
                              children: [
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p20),
                                    child: Form(
                                      key: controller.formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TitleWidget(
                                              title: "Statut Materiel"),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          ResponsiveChildWidget(
                                              child1: typeObjetWidget(),
                                              child2: nomWidget()),
                                          statutListWidget(),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          BtnWidget(
                                              title: 'Soumettre',
                                              isLoading: controller.isLoading,
                                              press: () {
                                                final form = controller
                                                    .formKey.currentState!;
                                                if (form.validate()) {
                                                  controller.submitUpdate(
                                                      widget.etatMaterielModel);
                                                  form.reset();
                                                }
                                              })
                                        ],
                                      ),
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

  Widget typeObjetWidget() {
    List<String> typeObjetList = ["Mobilier", "Immobilier", "Enguins"];
    var mobiliers = controller.mobilierList.map((e) => e.nom).toList();
    var immobiliers =
        controller.immobilierList.map((e) => e.numeroCertificat).toList();
    var enguins = controller.enguinsList.map((e) => e.nomeroPLaque).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type d\'Objet',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeObjet,
        isExpanded: true,
        validator: (value) => value == null ? "Champs obligatoire" : null,
        items: typeObjetList
            .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            })
            .toSet()
            .toList(),
        onChanged: (value) {
          setState(() {
            controller.typeObjet = value!;
            controller.nomList.clear();
            switch (value) {
              case 'Mobilier':
                controller.nomList = mobiliers;
                controller.nom = controller.nomList.first;
                break;
              case 'Immobilier':
                controller.nomList = immobiliers;
                controller.nom = controller.nomList.first;
                break;
              case 'Enguins':
                controller.nomList = enguins;
                controller.nom = controller.nomList.first;
                break;
              default:
            }
          });
        },
      ),
    );
  }

  Widget nomWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Nom',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.nom,
        isExpanded: true,
        items: controller.nomList
            .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            })
            .toSet()
            .toList(),
        validator: (value) => value == null ? "Champs obligatoire" : null,
        onChanged: (value) {
          setState(() {
            controller.nom = value!;
          });
        },
      ),
    );
  }

  Widget statutListWidget() {
    List<String> statutList = ["Actif", "Inactif", "Déclasser"];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Statut',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.statut,
        isExpanded: true,
        items: statutList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Champs obligatoire" : null,
        onChanged: (value) {
          setState(() {
            controller.statut = value!;
          });
        },
      ),
    );
  }
}
