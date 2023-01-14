import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';  
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart'; 
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddEntrepriseInfos extends StatefulWidget {
  const AddEntrepriseInfos({super.key});

  @override
  State<AddEntrepriseInfos> createState() => _AddEntrepriseInfosState();
}

class _AddEntrepriseInfosState extends State<AddEntrepriseInfos> {
  final EntrepriseInfosController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "New Entreprise";

   @override
  Widget build(BuildContext context) {
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
                                  if(controller.typeEntreprise == 'Entreprise')
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
                                  Obx(() => BtnWidget(
                                      title: 'Soumettre',
                                      isLoading: controller.isLoading,
                                      press: () {
                                        final form =
                                            controller.formKey.currentState!;
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
      )
    );
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
            if (controller.typeEntreprise == 'Entreprise') {
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
            if (controller.typeEntreprise == 'Entreprise') {
              if (value != null && value.isEmpty) {
                return 'Ce champs est obligatoire';
              } else {
                return null;
              }
            } return null;
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
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
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
      )
    );
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
          maxLines: 5,
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