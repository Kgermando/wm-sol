import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/utils/regex.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddPersonnel extends StatefulWidget {
  const AddPersonnel({super.key, required this.personnelList});
  final List<AgentModel> personnelList;

  @override
  State<AddPersonnel> createState() => _AddPersonnelState();
}

class _AddPersonnelState extends State<AddPersonnel> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final PersonnelsController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Add profil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
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
              (data) => SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const ScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: p20),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                const TitleWidget(
                                    title: "Nouveau profil"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    fichierWidget(),
                                  ],
                                ),
                                const SizedBox(height: p20),
                                ResponsiveChildWidget(
                                    child1: nomWidget(),
                                    child2: postNomWidget()),
                                ResponsiveChildWidget(
                                    child1: prenomWidget(),
                                    child2: sexeWidget()),
                                ResponsiveChildWidget(
                                    child1: dateNaissanceWidget(),
                                    child2: lieuNaissanceWidget()),
                                ResponsiveChildWidget(
                                    child1: nationaliteWidget(),
                                    child2: adresseWidget()),
                                ResponsiveChildWidget(
                                    child1: emailWidget(),
                                    child2: telephoneWidget()),
                                departmentWidget(),
                                servicesAffectationWidget(),
                                ResponsiveChildWidget(
                                    child1: matriculeWidget(),
                                    child2:
                                        numeroSecuriteSocialeWidget()),
                                ResponsiveChildWidget(
                                    child1: fonctionOccupeWidget(),
                                    child2: roleWidget()),
                                ResponsiveChildWidget(
                                    child1: typeContratWidget(),
                                    child2: salaireWidget()),
                                ResponsiveChildWidget(
                                    child1: dateDebutContratWidget(),
                                    child2:
                                        (controller.typeContrat == 'CDD')
                                            ? dateFinContratWidget()
                                            : Container()),
                                competanceWidget(),
                                experienceWidget(),
                                const SizedBox(height: p20),
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
                                  }
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))),
            ],
          ));
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
                          child: (controller.uploadedFileUrl == '')
                              ? Image.asset('assets/images/avatar.jpg')
                              : Image.network(controller.uploadedFileUrl)),
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

  Widget nomWidget() {
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

  Widget postNomWidget() {
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

  Widget prenomWidget() {
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

  Widget emailWidget() {
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

  Widget telephoneWidget() {
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

  Widget adresseWidget() {
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

  Widget sexeWidget() {
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

  Widget roleWidget() {
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
                    helpDialog();
                  },
                  icon: const Icon(Icons.help)))
        ],
      ),
    );
  }

  Widget matriculeWidget() {
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

  Widget numeroSecuriteSocialeWidget() {
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

  Widget dateNaissanceWidget() {
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

  Widget lieuNaissanceWidget() {
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

  Widget nationaliteWidget() {
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

  Widget typeContratWidget() {
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

  Widget departmentWidget() {
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
                        value: controller.departementSelectedList
                            .contains(depName),
                        onChanged: (bool? value) {
                          setState(() {
                            onSelectedDep(value!, depName);
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

  void onSelectedDep(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        controller.departementSelectedList.add(dataName);
        String prefix = InfoSystem().prefix();
        final date = DateFormat("yy").format(DateTime.now());

        String numero = '';
        if (controller.identifiant < 10) {
          numero = "00${controller.identifiant}";
        } else if (controller.identifiant < 99) {
          numero = "0${controller.identifiant}";
        } else {
          numero = "${controller.identifiant}";
        }

        if (controller.departementSelectedList.first == 'Actionnaire') {
          controller.matricule = "${prefix}ACT$date-$numero";
          controller.fonctionList = controller.fonctionActionnaireList;
          controller.servAffectList = controller.serviceAffectationActionnaire;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationActionnaire.first;
        } else if (controller.departementSelectedList.first ==
            'Administration') {
          controller.matricule = "${prefix}ADM$date-$numero";
          controller.fonctionList = controller.fonctionAdminList;
          controller.servAffectList = controller.serviceAffectationAdmin;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationAdmin.first;
        } else if (controller.departementSelectedList.first == 'Finances') {
          controller.matricule = "${prefix}FIN$date-$numero";
          controller.fonctionList = controller.fonctionFinList;
          controller.servAffectList = controller.serviceAffectationFin;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationFin.first;
        } else if (controller.departementSelectedList.first ==
            'Comptabilites') {
          controller.matricule = "${prefix}CPT$date-$numero";
          controller.fonctionList = controller.fonctionComptabiliteList;
          controller.servAffectList = controller.serviceAffectationCompt;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationCompt.first;
        } else if (controller.departementSelectedList.first == 'Budgets') {
          controller.matricule = "${prefix}BUD$date-$numero";
          controller.fonctionList = controller.fonctionBudList;
          controller.servAffectList = controller.serviceAffectationBud;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationBud.first;
        } else if (controller.departementSelectedList.first ==
            'Ressources Humaines') {
          controller.matricule = "${prefix}RH$date-$numero";
          controller.fonctionList = controller.fonctionrhList;
          controller.servAffectList = controller.serviceAffectationRH;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationRH.first;
        } else if (controller.departementSelectedList.first ==
            'Exploitations') {
          controller.matricule = "${prefix}EXP$date-$numero";
          controller.fonctionList = controller.fonctionExpList;
          controller.servAffectList = controller.serviceAffectationEXp;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationEXp.first;
        } else if (controller.departementSelectedList.first == 'Marketing') {
          controller.matricule = "${prefix}MKT$date-$numero";
          controller.fonctionList = controller.fonctionMarketingList;
          controller.servAffectList = controller.serviceAffectationMark;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationMark.first;
        } else if (controller.departementSelectedList.first == 'Commercial') {
          controller.matricule = "${prefix}COM$date-$numero";
          controller.fonctionList = controller.fonctionCommList;
          controller.servAffectList = controller.serviceAffectationCom;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationCom.first;
        } else if (controller.departementSelectedList.first == 'Logistique') {
          controller.matricule = "${prefix}LOG$date-$numero";
          controller.fonctionList = controller.fonctionlogList;
          controller.servAffectList = controller.serviceAffectationLog;
          controller.fonctionOccupe = controller.fonctionList.first;
          controller.servicesAffectation =
              controller.serviceAffectationLog.first;
        }
      });
    } else {
      setState(() {
        controller.departementSelectedList.remove(dataName);
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

  Widget servicesAffectationWidget() {
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

  Widget dateDebutContratWidget() {
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

  Widget dateFinContratWidget() {
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

  Widget fonctionOccupeWidget() {
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
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 100,
          controller: controller.competanceController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Formation',
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

  Widget experienceWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 100,
          controller: controller.experienceController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Experience',
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

  Widget salaireWidget() {
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

  helpDialog() {
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
