import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddEtatMateriel extends StatefulWidget {
  const AddEtatMateriel({super.key});

  @override
  State<AddEtatMateriel> createState() => _AddEtatMaterielState();
}

class _AddEtatMaterielState extends State<AddEtatMateriel> {
  final EtatMaterielController controller = Get.find();
  final MaterielController materielController = Get.find();
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
                                          if (materielController
                                              .materielList.isNotEmpty)
                                            ResponsiveChildWidget(
                                                child1: typeObjetWidget(),
                                                child2: nomWidget()),
                                          statutListWidget(),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          Obx(() => BtnWidget(
                                              title: 'Soumettre',
                                              isLoading: controller.isLoading,
                                              press: () {
                                                final form = controller
                                                    .formKey.currentState!;
                                                if (form.validate()) {
                                                  controller.submit();
                                                  form.reset();
                                                }
                                              }))  
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
    List<String> typeObjetList = ["Materiel", "Materiel roulant"];

    List<String> etatMaterielListMap = controller.etatMaterielList
        .map((element) => element.nom)
        .toList();

    
    var materielListMap = materielController.materielList
        .where((e) => e.typeMateriel == 'Materiel')
        .map((e) => e.identifiant)
        .toList();
    List<String> materielList = materielListMap
        .toSet()
        .difference(etatMaterielListMap.toSet())
        .toList();

    var materielRoulantListMap = materielController.materielList
        .where((e) => e.typeMateriel == 'Materiel roulant')
        .map((e) => e.identifiant)
        .toList();
    List<String> materielRoulantList = materielRoulantListMap
        .toSet()
        .difference(etatMaterielListMap.toSet())
        .toList();
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
            switch (controller.typeObjet) {
              case 'Materiel':
                controller.nomList = materielList;
                if (materielList.isNotEmpty) {
                  controller.nom = controller.nomList.first;
                }
                break;
              case 'Materiel roulant':
                controller.nomList = materielRoulantList;
                if (materielRoulantList.isNotEmpty) {
                  controller.nom = controller.nomList.first;
                }
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
          labelText: 'Identifiant',
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
        validator: (value) => value == null ? "Select Identifiant" : null,
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
