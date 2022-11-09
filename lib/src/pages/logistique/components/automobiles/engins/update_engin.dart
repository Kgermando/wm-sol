import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/engin_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';


class UpdateEngin extends StatefulWidget {
  const UpdateEngin({super.key, required this.anguinModel});
  final AnguinModel anguinModel;

  @override
  State<UpdateEngin> createState() => _UpdateEnginState();
}

class _UpdateEnginState extends State<UpdateEngin> {
 final EnginController controller = Get.put(EnginController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique"; 

  @override
  void initState() {
     controller.modeleController = TextEditingController(text: widget.anguinModel.modele);
     controller.marqueController = TextEditingController(text: widget.anguinModel.marque);
     controller.numeroChassieController = TextEditingController(text: widget.anguinModel.numeroChassie);
     controller.couleurController = TextEditingController(text: widget.anguinModel.couleur); 
     controller.qtyMaxReservoirController = TextEditingController(text: widget.anguinModel.qtyMaxReservoir); 
     controller.nomeroPLaqueController = TextEditingController(text: widget.anguinModel.nomeroPLaque);
     controller.kilometrageInitialeController = TextEditingController(text: widget.anguinModel.kilometrageInitiale);
     controller.provenanceController = TextEditingController(text: widget.anguinModel.provenance);
     controller.typeCaburantController = TextEditingController(text: widget.anguinModel.typeCaburant);
     controller.typeMoteurController = TextEditingController(text: widget.anguinModel.typeMoteur);
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
              appBar: headerBar(context, scaffoldKey, title, widget.anguinModel.nomeroEntreprise),
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
                                              title: "Nouvel Engin"),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          ResponsiveChild3Widget(
                                              child1: marqueWidget(),
                                              child2: modeleWidget(),
                                              child3: numeroChassieWidget()),
                                          ResponsiveChildWidget(
                                              child1: couleurNomWidget(),
                                              child2: genreWidget()),
                                          ResponsiveChildWidget(
                                              child1: qtyMaxReservoirWidget(),
                                              child2: dateFabricationWidget()),
                                          ResponsiveChildWidget(
                                              child1: nomeroPLaqueWidget(),
                                              child2: nomeroEntrepriseWidget()),
                                          ResponsiveChildWidget(
                                              child1:
                                                  kilometrageInitialeWidget(),
                                              child2: provenanceWidget()),
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
                                                  controller.submitUpdate(widget.anguinModel);
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

  Widget numeroChassieWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroChassieController,
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
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.genre,
        isExpanded: true,
        validator: (value) => value == null ? "Select Type" : null,
        items: controller.genreDrop.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.genre = value;
          });
        },
      ),
    );
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

  Widget nomeroPLaqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomeroPLaqueController,
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

  Widget nomeroEntrepriseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Text(
          widget.anguinModel.numeroChassie,
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

  Widget provenanceWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.provenanceController,
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
}