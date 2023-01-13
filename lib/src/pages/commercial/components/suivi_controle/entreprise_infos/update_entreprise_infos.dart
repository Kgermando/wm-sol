import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class UpdateEntrperiseInfos extends StatefulWidget {
  const UpdateEntrperiseInfos({super.key, required this.entrepriseInfoModel});
  final EntrepriseInfoModel entrepriseInfoModel;

  @override
  State<UpdateEntrperiseInfos> createState() => _UpdateEntrperiseInfosState();
}

class _UpdateEntrperiseInfosState extends State<UpdateEntrperiseInfos> {
  final EntrepriseInfosController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial"; 

  @override
  void initState() {
     controller.nomSocialController = TextEditingController(text: widget.entrepriseInfoModel.nomSocial);
    controller.nomGerantController = TextEditingController(text: widget.entrepriseInfoModel.nomGerant);
    controller.emailEntrepriseController = TextEditingController(text: widget.entrepriseInfoModel.emailEntreprise);
    controller.emailGerantController = TextEditingController(text: widget.entrepriseInfoModel.emailGerant);
    controller.telephone1Controller = TextEditingController(text: widget.entrepriseInfoModel.telephone1);
    controller.telephone2Controller = TextEditingController(text: widget.entrepriseInfoModel.telephone2);
    controller.rccmController = TextEditingController(
        text: widget.entrepriseInfoModel.rccm);
    controller.identificationNationaleController =
        TextEditingController(text: widget.entrepriseInfoModel.identificationNationale);
    controller.numerosImpotController = TextEditingController(text: widget.entrepriseInfoModel.numerosImpot);
    controller.secteurActiviteController = TextEditingController(text: widget.entrepriseInfoModel.secteurActivite);
    controller.adressePhysiqueEntrepriseController =
        TextEditingController(text: widget.entrepriseInfoModel.adressePhysiqueEntreprise);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, widget.entrepriseInfoModel.nomSocial),
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: p20),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TitleWidget(title: "Nouvel Entreprise"),
                                  const SizedBox(
                                    height: p30,
                                  ),
                                  typeEntrepriseWidget(),
                                  ResponsiveChildWidget(
                                    child1: nomSocialidget(),
                                    child2: emailEntrepriseWidget(),
                                  ),
                                  ResponsiveChildWidget(
                                    child1: nomGerantWidget(),
                                    child2: emailGerantWidget(),
                                  ),
                                  ResponsiveChildWidget(
                                    child1: telephone1Widget(),
                                    child2: telephone2Widget(),
                                  ),
                                  if (controller.typeEntreprise == 'Entreprise')
                                    ResponsiveChildWidget(
                                      child1: rccmWidget(),
                                      child2: identificationNationaleWidget(),
                                    ),
                                  if (controller.typeEntreprise == 'Entreprise')
                                    ResponsiveChildWidget(
                                      child1: numerosImpotWidget(),
                                      child2: secteurActiviteWidget(),
                                    ),
                                  adressePhysiqueEntrepriseWidget(),
                                  const SizedBox(
                                    height: p20,
                                  ),
                                  BtnWidget(
                                    title: 'Soumettre',
                                    isLoading: controller.isLoading,
                                    press: () {
                                      final form =
                                          controller.formKey.currentState!;
                                      if (form.validate()) {
                                        controller.submitUpdate(widget.entrepriseInfoModel);
                                        form.reset();
                                      }
                                    }
                                  )
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
    );
  }

  Widget nomSocialidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomSocialController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom social',
          ),
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

  Widget nomGerantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomGerantController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom Gerant',
          ),
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

  Widget emailEntrepriseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.emailEntrepriseController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email entreprise',
          ),
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

  Widget emailGerantWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.emailGerantController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email Gerant',
          ),
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

  Widget telephone1Widget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.telephone1Controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Telephone 1',
          ),
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

  Widget telephone2Widget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.telephone2Controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Telephone 2',
          ),
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

  Widget rccmWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.rccmController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'RCCM',
          ),
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

  Widget identificationNationaleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.identificationNationaleController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Id. Natianale',
          ),
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

  Widget numerosImpotWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numerosImpotController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'N° Impôt',
          ),
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

  Widget secteurActiviteWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.secteurActiviteController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Secteur d'activité",
          ),
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

  Widget adressePhysiqueEntrepriseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.adressePhysiqueEntrepriseController,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse physique',
          ),
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

  Widget typeEntrepriseWidget() {
    List<String> suggestionList = ['Entreprise', 'Particulier'];
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type client',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeEntreprise,
        isExpanded: true,
        validator: (value) => value == null ? "Select Type client" : null,
        items: suggestionList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.typeEntreprise = value;
          });
        },
      ),
    );
  }
}