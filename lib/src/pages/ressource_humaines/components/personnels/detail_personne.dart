import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  bool statutAgent = false;
  String statutPersonel = 'false';

  @override
  Widget build(BuildContext context) {
    final PersonnelsController personnelsController =
        Get.put(PersonnelsController());
    final UsersController usersController = Get.put(UsersController());
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
                                child: ViewPersonne(personne: widget.personne)),
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
    bool isStatutPersonne = false;
    if (widget.personne.statutAgent == "true") {
      isStatutPersonne = true;
    } else if (widget.personne.statutAgent == "false") {
      isStatutPersonne = false;
    }
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
            label:
                (isStatutPersonne) ? "Désactiver le profil" : "Activer profil",
            onPressed: () {
              agentStatutDialog(personnelsController, usersController);
            },
          ),
          SpeedDialChild(
              child: const Icon(Icons.monetization_on),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade700,
              label: (isPayE.isEmpty) ? 'Bulletin de paie' : 'Déja générer',
              onPressed: () {
                if (isPayE.isEmpty) {
                  Get.toNamed(RhRoutes.rhPaiementAdd,
                      arguments: widget.personne);
                }
              })
        ],
        child: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      );
    });
  }

  agentStatutDialog(PersonnelsController personnelsController,
      UsersController usersController) {
    statutPersonel = widget.personne.statutAgent;
    if (statutPersonel == 'true') {
      statutAgent = true;
    } else if (statutPersonel == 'false') {
      statutAgent = false;
    }
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Autorisation d\'accès au système'),
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
                            statutPersonel = 'true';
                          } else {
                            vrai = 'false';
                            statutPersonel = 'false';
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
