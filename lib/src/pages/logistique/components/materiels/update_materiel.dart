import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class UpdateMateriel extends StatefulWidget {
  const UpdateMateriel({super.key, required this.materielModel});
  final MaterielModel materielModel;

  @override
  State<UpdateMateriel> createState() => _UpdateMaterielState();
}

class _UpdateMaterielState extends State<UpdateMateriel> {
 final MaterielController controller = Get.put(MaterielController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  @override
  void initState() {
    controller.marqueController = TextEditingController(text: widget.materielModel.marque);
    controller.modeleController = TextEditingController(text: widget.materielModel.modele);
    controller.numeroRefController = TextEditingController(text: widget.materielModel.numeroRef);
    controller.couleurController = TextEditingController(text: widget.materielModel.couleur);
    controller.genreController = TextEditingController(text: widget.materielModel.genre);
    controller.qtyMaxReservoirController = TextEditingController(text: widget.materielModel.qtyMaxReservoir);
    controller.numeroPLaqueController = TextEditingController(text: widget.materielModel.numeroPLaque);
    controller.kilometrageInitialeController =TextEditingController(text: widget.materielModel.kilometrageInitiale);
    controller.fournisseurController = TextEditingController(text: widget.materielModel.fournisseur);  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, widget.materielModel.identifiant),
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
                                              title: "Nouvel Fiche technique"),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          typeMaterielWidget(),
                                          ResponsiveChildWidget(
                                              child1: marqueWidget(),
                                              child2: modeleWidget()),
                                          ResponsiveChildWidget(
                                              child1: numeroRefWidget(),
                                              child2: couleurNomWidget()),
                                          ResponsiveChildWidget(
                                              child1: genreWidget(),
                                              child2: qtyMaxReservoirWidget()),
                                          ResponsiveChildWidget(
                                              child1: dateFabricationWidget(),
                                              child2: numeroPLaqueWidget()),
                                          ResponsiveChildWidget(
                                              child1: identifiantWidget(),
                                              child2:
                                                  kilometrageInitialeWidget()),
                                          ResponsiveChildWidget(
                                              child1: fournisseurWidget(),
                                              child2: alimentationWidget()),
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
                                                  controller.submitUpdate(widget.materielModel);
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

  Widget typeMaterielWidget() {
    List<String> suggestionList = ['Materiel', 'Materiel roulant'];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeMateriel,
        isExpanded: true,
        validator: (value) => value == null ? "Select Type Materiel" : null,
        items: suggestionList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.typeMateriel = value;
          });
        },
      ),
    );
  }


  Widget modeleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.modeleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Modèle',
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

  Widget marqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.marqueController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Marque',
              hintText: 'Toyoka, Mercedes, ..'),
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

  Widget numeroRefWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroRefController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Numéro chassie',
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

  Widget couleurNomWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.couleurController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Couleur',
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

  Widget genreWidget() {
    List<String> suggestionList =
        controller.materielList.map((e) => e.genre).toSet().toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          controller: controller.genreController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Genre",
          ),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget qtyMaxReservoirWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.qtyMaxReservoirController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Quantité max reservoir en litre',
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

  Widget dateFabricationWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date de fabrication',
          ),
          controller: controller.dateFabricationController,
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

  Widget numeroPLaqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroPLaqueController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Numéro plaque',
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

  Widget identifiantWidget() {
    String numero = '';
    if (controller.identifiant < 10) {
      numero = "00${controller.identifiant}";
    } else if (controller.identifiant < 99) {
      numero = "0${controller.identifiant}";
    } else {
      numero = "${controller.identifiant}";
    }
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Text(
          "Identifiant N° $numero",
          style: Theme.of(context).textTheme.headline6,
        ));
  }

  Widget kilometrageInitialeWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.kilometrageInitialeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Kilometrage par heure',
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

  Widget fournisseurWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.fournisseurController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Provenance(Pays)',
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

  Widget alimentationWidget() {
    List<String> suggestionList =
        controller.materielList.map((e) => e.alimentation).toSet().toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.alimentation,
        isExpanded: true,
        validator: (value) =>
            value == null ? "Select alimentation source" : null,
        items: suggestionList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.alimentation = value;
          });
        },
      ),
    );
  }
}