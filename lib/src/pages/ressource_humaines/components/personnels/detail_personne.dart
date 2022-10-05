import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/agent_pdf.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/view_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart'; 
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailPersonne extends StatefulWidget {
  const DetailPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<DetailPersonne> createState() => _DetailPersonneState();
}

class _DetailPersonneState extends State<DetailPersonne> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          "${widget.personne.prenom} ${widget.personne.nom}"),
      drawer: const DrawerMenu(),
      floatingActionButton: speedialWidget(),
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
                    child: ViewPersonne(personne: widget.personne)
                ),
              ))
        ],
      ),
    );
  }
  




  Widget speedialWidget() {
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
              // agentStatutDialog(widget.personne);
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

}
