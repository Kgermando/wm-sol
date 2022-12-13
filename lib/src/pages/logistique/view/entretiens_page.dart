import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/entretiens/table_entretien.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class EntretiensPage extends StatefulWidget {
  const EntretiensPage({super.key});

  @override
  State<EntretiensPage> createState() => _EntretiensPageState();
}

class _EntretiensPageState extends State<EntretiensPage> {
  final EntretienController controller = Get.find();
  final ObjetRemplaceController objetRemplaceController = Get.find();
  final MaterielController materielController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Entretiens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Fiche d'entretien"),
        tooltip: "Ajouter une fiche d'entretien",
        icon: const Icon(Icons.add),
        onPressed: () {
          newFicheDialog();
        },
      ),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: TableEntretien(
                          entretienList: controller.entretienList,
                          controller: controller)))),
          ],
        ));
  }

  newFicheDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            Widget typeObjetWidget() {
              List<String> typeObjetList = ["Materiel", "Materiel roulant"];

              List<String> etatMaterielListMap = controller.entretienList
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    contentPadding: const EdgeInsets.only(left: 5.0),
                  ),
                  value: controller.typeObjet,
                  isExpanded: true,
                  validator: (value) =>
                      value == null ? "Champs obligatoire" : null,
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
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
                  validator: (value) =>
                      value == null ? "Select Identifiant" : null,
                  onChanged: (value) {
                    setState(() {
                      controller.nom = value!;
                    });
                  },
                ),
              );
            }

            return AlertDialog(
              scrollable: true,
              title: Text("Generer la fiche d'entretien",
                  style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isDesktop(context) ? 350 : 600,
                  width: 500,
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          if (materielController.materielList.isNotEmpty)
                            ResponsiveChildWidget(
                                child1: typeObjetWidget(), child2: nomWidget()),
                          etatObjetWidget(),
                          dureeTravauxWidget(),
                          const SizedBox(
                            height: p20,
                          ),
                        ],
                      ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit();
                      form.reset();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget dureeTravauxWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.dureeTravauxController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Durée Travaux',
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

  Widget etatObjetWidget() {
    List<String> typeMaintenanceList = [
      'Maintenance curative',
      'Maintenance préventive',
      'Maintenance corrective',
      'Maintenance améliorative'
    ];
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Type de maintenance',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          value: controller.typeMaintenance,
          isExpanded: true,
          items: typeMaintenanceList
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toSet()
              .toList(),
          validator: (value) => value == null ? "Select maintenance" : null,
          onChanged: (value) {
            setState(() {
              controller.typeMaintenance = value;
            });
          },
        ));
  }
}
