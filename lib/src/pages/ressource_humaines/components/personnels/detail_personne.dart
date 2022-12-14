import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/infos_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/view_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DetailPersonne extends StatefulWidget {
  const DetailPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<DetailPersonne> createState() => _DetailPersonneState();
}

class _DetailPersonneState extends State<DetailPersonne> {
  final PersonnelsController personnelsController = Get.find();
  final UsersController usersController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  bool statutAgent = false;
  String statutPersonel = 'false';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          "${widget.personne.prenom} ${widget.personne.nom}"),
      drawer: const DrawerMenu(),
      floatingActionButton:
          speedialWidget(personnelsController, usersController),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: DefaultTabController(
                  length: 2,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 30,
                        child: TabBar(
                          physics: ScrollPhysics(),
                          tabs: [Tab(text: "Profil"), Tab(text: "Stats")],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: p20, bottom: p8, right: p20, left: p20),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: TabBarView(
                          physics: const ScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                                child: ViewPersonne(
                                    personne: widget.personne,
                                    controller: personnelsController)),
                            SingleChildScrollView(
                                child: InfosPersonne(personne: widget.personne))
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  Widget speedialWidget(PersonnelsController personnelsController,
      UsersController usersController) {
    final SalaireController salaireController = Get.put(SalaireController());
    final ActionnaireController actionnaireController =
        Get.put(ActionnaireController());

    int userRole = int.parse(actionnaireController.profilController.user.role);

    bool isStatutPersonne = false;
    if (widget.personne.statutAgent == "Actif") {
      isStatutPersonne = true;
    } else if (widget.personne.statutAgent == "Inactif") {
      isStatutPersonne = false;
    }

    return actionnaireController.obx(onLoading: loadingMini(), (actionnaires) {
      var isActionnaireActif = actionnaires!
          .where((element) => element.matricule == widget.personne.matricule)
          .toList();

      return salaireController.obx(onLoading: loadingMini(), (state) {
        var isPayE = state!
            .where((element) => element.matricule == widget.personne.matricule)
            .toList();
        return SpeedDial(
          closedForegroundColor: themeColor,
          openForegroundColor: Colors.white,
          closedBackgroundColor: themeColor,
          openBackgroundColor: themeColor,
          speedDialChildren: <SpeedDialChild>[
            SpeedDialChild(
              child: const Icon(
                Icons.content_paste_sharp,
                size: 15.0,
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange.shade700,
              label: 'Modifier CV profil',
              onPressed: () {
                Get.toNamed(RhRoutes.rhPersonnelsUpdate,
                    arguments: widget.personne);
              },
            ),
            // if (int.parse(user.role) <= 2)
            SpeedDialChild(
              child: const Icon(Icons.safety_divider, size: 15.0),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red.shade700,
              label: (isStatutPersonne)
                  ? "D??sactiver le profil"
                  : "Activer profil",
              onPressed: () {
                agentStatutDialog(personnelsController, usersController);
              },
            ),
            SpeedDialChild(
                child: const Icon(Icons.monetization_on),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade700,
                label: (isPayE.isEmpty) ? 'Bulletin de paie' : 'D??ja g??n??rer',
                onPressed: () {
                  if (isPayE.isEmpty) {
                    Get.toNamed(RhRoutes.rhPaiementAdd,
                        arguments: widget.personne);
                  }
                }),
            if (userRole <= 1)
              SpeedDialChild(
                  child: const Icon(Icons.sensor_occupied),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal.shade700,
                  label: (isActionnaireActif.isEmpty)
                      ? 'Ajout?? actionnaire'
                      : 'D??ja Ajout??',
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: Colors.amber.shade100,
                          padding: const EdgeInsets.all(p20),
                          child: Form(
                            key: actionnaireController.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            (isActionnaireActif.isNotEmpty)
                                                ? "Retir?? ${widget.personne.prenom} comme Actionnaire"
                                                    .toUpperCase()
                                                : "Ajout?? ${widget.personne.prenom} comme Actionnaire"
                                                    .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium)),
                                  ],
                                ),
                                const SizedBox(
                                  height: p20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: Text("Actionnaire",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall)),
                                    Expanded(
                                      child: FlutterSwitch(
                                        width: 225.0,
                                        height: 50.0,
                                        activeColor: Colors.green,
                                        inactiveColor: Colors.red,
                                        valueFontSize: 25.0,
                                        toggleSize: 45.0,
                                        value: isActionnaireActif.isNotEmpty,
                                        borderRadius: 30.0,
                                        padding: 8.0,
                                        showOnOff: true,
                                        activeText: 'Retir??',
                                        inactiveText: 'Ajout??',
                                        onToggle: (val) {
                                          setState(() { 
                                            if (isActionnaireActif.isNotEmpty) {
                                              var actionnaire = actionnaires
                                                  .where((element) =>
                                                      element.matricule ==
                                                      widget.personne.matricule)
                                                  .first;
                                              if(actionnaire.cotisations ==0) {
                                                actionnaireController
                                                    .deleteData(
                                                        actionnaire.id!); 
                                              } 
                                            } else {
                                              actionnaireController
                                                  .submit(widget.personne);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: p50,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
          ],
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        );
      });
    });
  }

  agentStatutDialog(PersonnelsController personnelsController,
      UsersController usersController) {
    statutPersonel = widget.personne.statutAgent;
    if (statutPersonel == 'Actif') {
      statutAgent = true;
    } else if (statutPersonel == 'Inactif') {
      statutAgent = false;
    }
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Autorisation d\'acc??s au syst??me'),
              content: SizedBox(
                height: 100,
                width: 200,
                child: Column(
                  children: [
                    FlutterSwitch(
                      width: 225.0,
                      height: 55.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.red,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: statutAgent,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      activeText: 'Active',
                      inactiveText: 'Inactive',
                      onToggle: (val) {
                        // isLoading == true;
                        setState(() {
                          statutAgent = val;
                          String vrai = '';
                          if (statutAgent) {
                            vrai = 'true';
                            statutPersonel = 'Actif';
                          } else {
                            vrai = 'false';
                            statutPersonel = 'Inactif';
                          }
                          if (vrai == 'true') {
                            usersController.createUser(widget.personne);
                            personnelsController.updateStatus(
                                widget.personne, statutPersonel);
                          } else if (vrai == 'false') {
                            usersController.deleteUser(widget.personne);
                            personnelsController.updateStatus(
                                widget.personne, statutPersonel);
                          }
                          personnelsController.detailView(widget.personne.id!);
                        });
                      },
                    ),
                  ],
                ),
              ),
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
