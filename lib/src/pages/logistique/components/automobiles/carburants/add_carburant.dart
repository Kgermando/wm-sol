import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/carburant_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddCarburant extends StatefulWidget {
  const AddCarburant({super.key});

  @override
  State<AddCarburant> createState() => _AddCarburantState();
}

class _AddCarburantState extends State<AddCarburant> {
  final CarburantController controller = Get.put(CarburantController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Ajout carburant";

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
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Ajouter une personne"),
                tooltip: "Ajout personne à la liste",
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
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
                                              title: "Ajout Carburant"),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child:
                                                      operationEntreSortieWidget()),
                                              const SizedBox(
                                                width: p10,
                                              ),
                                              Expanded(
                                                  child: typeCaburantWidget())
                                            ],
                                          ),
                                          if (controller.operationEntreSortie ==
                                              'Entrer')
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: fournisseurWidget()),
                                                const SizedBox(
                                                  width: p10,
                                                ),
                                                Expanded(
                                                    child:
                                                        nomeroFactureAchatWidget())
                                              ],
                                            ),
                                          Row(
                                            children: [
                                              if (controller
                                                      .operationEntreSortie ==
                                                  'Entrer')
                                                Expanded(
                                                    child:
                                                        prixAchatParLitreWidget()),
                                              const SizedBox(
                                                width: p10,
                                              ),
                                              if (controller
                                                      .operationEntreSortie ==
                                                  'Sortie')
                                                Expanded(
                                                    child:
                                                        nomReceptionisteWidget())
                                            ],
                                          ),
                                          if (controller.operationEntreSortie ==
                                              'Sortie')
                                            Row(
                                              children: [
                                                Expanded(
                                                    child:
                                                        numeroPlaqueWidget()),
                                                const SizedBox(
                                                  width: p10,
                                                ),
                                                Expanded(
                                                    child:
                                                        dateDebutEtFinWidget())
                                              ],
                                            ),
                                          qtyAchatControllerWidget(),
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
                                                  controller.submit();
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

  Widget operationEntreSortieWidget() {
    List<String> typeList = ['Entrer', 'Sortie'];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type d\'operation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.operationEntreSortie,
        isExpanded: true,
        items: typeList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.operationEntreSortie = value!;
          });
        },
      ),
    );
  }

  Widget typeCaburantWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type de carburant',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeCaburant,
        isExpanded: true,
        items: controller.carburantDropList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.typeCaburant = value!;
          });
        },
      ),
    );
  }

  Widget fournisseurWidget() {
    List<String> dataList = [];
    dataList = controller.annuaireList.map((e) => e.nomPostnomPrenom).toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Fournisseur',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          value: controller.fournisseur,
          isExpanded: true,
          items: dataList
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toSet()
              .toList(),
          validator: (value) => value == null ? "Select fournisseur" : null,
          onChanged: (value) {
            setState(() {
              controller.fournisseur = value;
            });
          },
        ));
  }

  Widget nomeroFactureAchatWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomeroFactureAchatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Numero Facture',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (controller.operationEntreSortie == 'Entrer') {
              if (value != null && value.isEmpty) {
                return 'Ce champs est obligatoire';
              } else {
                return null;
              }
            }
            return null;
          },
        ));
  }

  Widget prixAchatParLitreWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.prixAchatParLitreController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prix Achat Par Litre',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          style: const TextStyle(),
          validator: (value) {
            if (controller.operationEntreSortie == 'Entrer') {
              if (value != null && value.isEmpty) {
                return 'Ce champs est obligatoire';
              } else {
                return null;
              }
            }
            return null;
          },
        ));
  }

  Widget nomReceptionisteWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomReceptionisteController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom receptioniste',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (controller.operationEntreSortie == 'Sortie') {
              if (value != null && value.isEmpty) {
                return 'Ce champs est obligatoire';
              } else {
                return null;
              }
            }
            return null;
          },
        ));
  }

  Widget numeroPlaqueWidget() {
    List<String> numPlaque =
        controller.enginList.map((e) => e.nomeroPLaque).toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Numero plaque entreprise',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.numeroPlaque,
        isExpanded: true,
        items: numPlaque.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.numeroPlaque = value!;
          });
        },
      ),
    );
  }

  Widget qtyAchatControllerWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.qtyAchatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Quantités',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
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

  Widget dateDebutEtFinWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date Heure Sortie',
          ),
          controller: controller.dateHeureSortieAnguinController,
          timePickerEntryModeInput: true,
          firstDate: DateTime(1930),
          lastDate: DateTime(2100),
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
