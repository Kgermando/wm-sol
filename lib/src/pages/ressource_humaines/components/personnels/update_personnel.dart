import 'dart:convert';

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/regex.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class UpdatePersonnel extends StatefulWidget {
  const UpdatePersonnel({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<UpdatePersonnel> createState() => _UpdatePersonnelState();
}

class _UpdatePersonnelState extends State<UpdatePersonnel> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final PersonnelsController controller = Get.find();
  final UsersController usersController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  List<String> departementSelected = [];

  
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // photo = widget.personne.photo!;
    List<dynamic> dep = jsonDecode(widget.personne.departement);

    departementSelected = dep.cast<String>();

    controller.departementSelectedUpdateList.addAll(departementSelected);

    controller.matricule = widget.personne.matricule;
    controller.sexe = widget.personne.sexe;
    controller.role = widget.personne.role;
    controller.nationalite = widget.personne.nationalite;
    controller.typeContrat = widget.personne.typeContrat;
    controller.servicesAffectation = widget.personne.servicesAffectation;
    controller.fonctionOccupe = widget.personne.fonctionOccupe;
    controller.nomController = TextEditingController(text: widget.personne.nom);
    controller.postNomController =
        TextEditingController(text: widget.personne.postNom);
    controller.prenomController =
        TextEditingController(text: widget.personne.prenom);
    controller.emailController =
        TextEditingController(text: widget.personne.email);
    controller.telephoneController =
        TextEditingController(text: widget.personne.telephone);
    controller.adresseController =
        TextEditingController(text: widget.personne.adresse);
    controller.numeroSecuriteSocialeController =
        TextEditingController(text: widget.personne.numeroSecuriteSociale);
    controller.dateNaissanceController =
        TextEditingController(text: widget.personne.dateNaissance.toString());
    controller.dateNaissanceController =
        TextEditingController(text: widget.personne.dateNaissance.toString());
    controller.lieuNaissanceController =
        TextEditingController(text: widget.personne.lieuNaissance);
    controller.dateDebutContratController = TextEditingController(
        text: widget.personne.dateDebutContrat.toString());
    controller.dateFinContratController =
        TextEditingController(text: widget.personne.dateFinContrat.toString());

    controller.salaireController =
        TextEditingController(text: widget.personne.salaire);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          "${widget.personne.prenom} ${widget.personne.nom}"),
      drawer: const DrawerMenu(),
      body: Row(
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
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(p20),
                        child: Form(
                          key: controller.formKey,
                          child: Column(children: [
                            const TitleWidget(title: "Modification du profil"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                fichierWidget(),
                              ],
                            ),
                            const SizedBox(height: p20),
                            ResponsiveChildWidget(
                                child1: nomWidget(controller),
                                child2: postNomWidget(controller)),
                            ResponsiveChildWidget(
                                child1: prenomWidget(controller),
                                child2: sexeWidget(controller)),
                            ResponsiveChildWidget(
                                child1: dateNaissanceWidget(controller),
                                child2: lieuNaissanceWidget(controller)),
                            ResponsiveChildWidget(
                                child1: nationaliteWidget(controller),
                                child2: adresseWidget(controller)),
                            ResponsiveChildWidget(
                                child1: emailWidget(controller),
                                child2: telephoneWidget(controller)),
                            departmentWidget(controller),
                            servicesAffectationWidget(controller),
                            ResponsiveChildWidget(
                                child1: matriculeWidget(controller),
                                child2:
                                    numeroSecuriteSocialeWidget(controller)),
                            ResponsiveChildWidget(
                                child1: fonctionOccupeWidget(controller),
                                child2: roleWidget(controller)),
                            ResponsiveChildWidget(
                                child1: typeContratWidget(controller),
                                child2: salaireWidget(controller)),
                            ResponsiveChildWidget(
                                child1: dateDebutContratWidget(controller),
                                child2: (controller.typeContrat == 'CDD')
                                    ? dateFinContratWidget(controller)
                                    : Container()),
                            competanceWidget(),
                            // experienceWidget(),
                            const SizedBox(height: p20),
                            Obx(() => BtnWidget(
                                title: 'Soumettre modification',
                                isLoading: controller.isLoading,
                                press: () {
                                  final form = controller.formKey.currentState!;
                                  if (form.validate()) {
                                    if(widget.personne.statutAgent ==
                                        "Actif") {
                                      usersController.deleteUser(widget.personne);
                                    }
                                    controller.submitUpdate(widget.personne); 
                                    form.reset();
                                  }
                                })) 
                          ]),
                        ),
                      ),
                    )),
              ))
        ],
      ),
    );
  }

  Widget fichierWidget() {
    return Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(2),
        child: Obx(() => controller.isUploading
            ? const SizedBox(
                height: 50.0, width: 50.0, child: LinearProgressIndicator())
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: CircleAvatar(
                          child: CachedNetworkImageBuilder(
                        url: widget.personne.photo!,
                        builder: (image) {
                          return Center(
                              child: Image.file(
                            image,
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ));
                        },
                        // Optional Placeholder widget until image loaded from url
                        placeHolder: loadingMini(),
                        // Optional error widget
                        errorWidget: Image.asset('assets/images/avatar.jpg'),
                        // Optional describe your image extensions default values are; jpg, jpeg, gif and png
                        imageExtensions: const ['jpg', 'png'],
                      )),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 70,
                      child: IconButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg'],
                            );
                            if (result != null) {
                              setState(() {
                                controller
                                    .uploadFile(result.files.single.path!);
                              });
                            } else {
                              const Text("Le fichier n'existe pas");
                            }
                          },
                          icon: const Icon(Icons.camera_alt)))
                ],
              )));
  }

  Widget nomWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom',
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

  Widget postNomWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.postNomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Post-Nom',
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

  Widget prenomWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.prenomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prénom',
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

  Widget emailWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.emailController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(),
          validator: (value) => RegExpIsValide().validateEmail(value),
        ));
  }

  Widget telephoneWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.telephoneController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Téléphone',
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

  Widget adresseWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.adresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
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

  Widget sexeWidget(PersonnelsController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Sexe',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.sexe,
        isExpanded: true,
        items: controller.sexeList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Sexe" : null,
        onChanged: (value) {
          setState(() {
            controller.sexe = value!;
          });
        },
      ),
    );
  }

  Widget roleWidget(PersonnelsController controller) {
    final ProfilController profilController = Get.find();
    List<String> roleList = [];
    if (int.parse(profilController.user.role) == 0) {
      roleList = Dropdown().roleAdmin;
    } else if (int.parse(profilController.user.role) <= 3) {
      roleList = Dropdown().roleSuperieur;
    } else if (int.parse(profilController.user.role) > 3) {
      roleList = Dropdown().roleAgent;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Niveau d\'accréditation',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                contentPadding: const EdgeInsets.only(left: 5.0),
              ),
              value: controller.role,
              isExpanded: true,
              items: roleList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? "Select accréditation" : null,
              onChanged: (value) {
                setState(() {
                  controller.role = value!;
                });
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: "Besoin d'aide ?",
                  color: Colors.red.shade700,
                  onPressed: () {
                    helpDialog(controller);
                  },
                  icon: const Icon(Icons.help)))
        ],
      ),
    );
  }

  Widget matriculeWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          readOnly: true,
          initialValue: controller.matricule,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.red),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: controller.matricule,
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }

  Widget numeroSecuriteSocialeWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroSecuriteSocialeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Numero Sécurité Sociale',
          ),
          keyboardType: TextInputType.text,
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

  Widget dateNaissanceWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date de naissance',
          ),
          controller: controller.dateNaissanceController,
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

  Widget lieuNaissanceWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.lieuNaissanceController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Lieu de naissance',
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

  Widget nationaliteWidget(PersonnelsController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Nationalite',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.nationalite,
        isExpanded: true,
        items: controller.world.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Nationalite" : null,
        onChanged: (value) {
          setState(() {
            controller.nationalite = value!;
          });
        },
      ),
    );
  }

  Widget typeContratWidget(PersonnelsController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type de contrat',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.typeContrat,
        isExpanded: true,
        items: controller.typeContratList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select contrat" : null,
        onChanged: (value) {
          setState(() {
            controller.typeContrat = value!;
          });
        },
      ),
    );
  }

  Widget departmentWidget(PersonnelsController controller) {
    double width = 100;
    if (MediaQuery.of(context).size.width >= 1100) {
      width = 300;
    } else if (MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 650) {
      width = 200;
    } else if (MediaQuery.of(context).size.width < 650) {
      width = 500;
    }

    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Département",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              Wrap(
                children:
                    List.generate(controller.departementList.length, (index) {
                  var depName = controller.departementList[index];
                  return SizedBox(
                    width: width,
                    child: ListTile(
                      leading: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: controller.departementSelectedUpdateList
                            .contains(depName),
                        onChanged: (bool? value) {
                          setState(() {
                            onSelectedDep(controller, value!, depName);
                          });
                        },
                      ),
                      title: Text(depName),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  void onSelectedDep(
      PersonnelsController controller, bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        controller.departementSelectedUpdateList.add(dataName);

        if (controller.departementSelectedUpdateList.first == 'Actionnaire') {
          controller.fonctionList = controller.fonctionActionnaireList;
          controller.servAffectList = controller.serviceAffectationActionnaire;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationActionnaire.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Administration') {
          controller.fonctionList = controller.fonctionAdminList;
          controller.servAffectList = controller.serviceAffectationAdmin;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationAdmin.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Finances') {
          controller.fonctionList = controller.fonctionFinList;
          controller.servAffectList = controller.serviceAffectationFin;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationFin.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Comptabilites') {
          controller.fonctionList = controller.fonctionComptabiliteList;
          controller.servAffectList = controller.serviceAffectationCompt;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationCompt.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Budgets') {
          controller.fonctionList = controller.fonctionBudList;
          controller.servAffectList = controller.serviceAffectationBud;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationBud.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Ressources Humaines') {
          controller.fonctionList = controller.fonctionrhList;
          controller.servAffectList = controller.serviceAffectationRH;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationRH.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Exploitations') {
          controller.fonctionList = controller.fonctionExpList;
          controller.servAffectList = controller.serviceAffectationEXp;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationEXp.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Marketing') {
          controller.fonctionList = controller.fonctionMarketingList;
          controller.servAffectList = controller.serviceAffectationMark;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationMark.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Commercial') {
          controller.fonctionList = controller.fonctionCommList;
          controller.servAffectList = controller.serviceAffectationCom;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationCom.first;
        } else if (controller.departementSelectedUpdateList.first ==
            'Logistique') {
          controller.fonctionList = controller.fonctionlogList;
          controller.servAffectList = controller.serviceAffectationLog;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationLog.first;
        }
      });
    } else {
      setState(() {
        controller.departementSelectedUpdateList.remove(dataName);
      });
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.green;
  }

  Widget servicesAffectationWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Service d\'affectation',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          value: controller.servicesAffectation,
          isExpanded: true,
          items: controller.servAffectList 
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toSet()
              .toList(),
          validator: (value) => value == null ? "Select Service" : null,
          onChanged: (value) {
            setState(() {
              controller.servicesAffectation = value;
            });
          },
        ));
  }

  Widget dateDebutContratWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date de début du Contrat',
          ),
          controller: controller.dateDebutContratController,
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

  Widget dateFinContratWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Date de Fin du Contrat',
          ),
          controller: controller.dateFinContratController,
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

  Widget fonctionOccupeWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Fonction occupée',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          value: controller.fonctionOccupe,
          isExpanded: true,
          items: controller.fonctionList
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toSet()
              .toList(),
          validator: (value) => value == null ? "Select Fonction" : null,
          onChanged: (value) {
            setState(() {
              controller.fonctionOccupe = value;
            });
          },
        ));
  }


  Widget competanceWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Column(
          children: [
            flutter_quill.QuillToolbar.basic(
                controller: controller.competanceController),
            SizedBox(
              height: 400,
              child: Row(
                children: [
                  Expanded(
                    child: flutter_quill.QuillEditor(
                      controller: controller.competanceController,
                      readOnly: false, // true for view only mode
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: _focusNode,
                      autoFocus: false,
                      placeholder: 'Formation, Comptence, Experience, ...',
                      expands: true,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      );
    }

  // Widget experienceWidget() {
  //   var json = jsonDecode(widget.personne.experience!);
  //   controller.experienceController = flutter_quill.QuillController(
  //       document: flutter_quill.Document.fromJson(json),
  //       selection: const TextSelection.collapsed(offset: 0));
  //   return Container(
  //       margin: const EdgeInsets.only(bottom: p20),
  //       child: Column(
  //         children: [
  //           flutter_quill.QuillToolbar.basic(
  //               controller: controller.experienceController),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height / 1.5,
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: flutter_quill.QuillEditor(
  //                     controller: controller.experienceController,
  //                     readOnly: false, // true for view only mode
  //                     scrollController: ScrollController(),
  //                     scrollable: true,
  //                     focusNode: _focusNode,
  //                     autoFocus: false,
  //                     placeholder: 'Ecrire votre rapport ici...',
  //                     expands: true,
  //                     padding: EdgeInsets.zero,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ));
  // }


  Widget salaireWidget(PersonnelsController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.salaireController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Salaire',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: const TextStyle(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(width: p20),
            Expanded(
                flex: 1,
                child: Text(monnaieStorage.monney,
                    style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }

  helpDialog(PersonnelsController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Accreditation'),
              content: SizedBox(
                  height: 300,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Niveau 0: PCA, Président",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: p8),
                      Text("Niveau 1: Directeur général",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: p8),
                      Text("Niveau 2: Directeur département",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: p8),
                      Text("Niveau 3: Chef de service",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: p8),
                      Text("Niveau 4: Personnel travailleur (perosne)",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: p8),
                      Text("Niveau 5: Stagiaire, Expert, Consultant, ...",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }
}
