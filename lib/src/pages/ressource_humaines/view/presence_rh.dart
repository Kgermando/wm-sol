import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/presences/table_presence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class PresenceRH extends StatefulWidget {
  const PresenceRH({super.key});

  @override
  State<PresenceRH> createState() => _PresenceRHState();
}

class _PresenceRHState extends State<PresenceRH> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Presence";

  @override
  Widget build(BuildContext context) {
    final PresenceController controller = Get.find();
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Liste de présence"),
        tooltip: "Nouvelle Liste de présence",
        icon: const Icon(Icons.group_add),
        onPressed: () {
          newFicheDialog(controller);
        },
      ),
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
          (data) => Container(
                  margin: const EdgeInsets.only(
                      top: p20, right: p20, left: p20, bottom: p8),
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                  child: TablePresence(
                      presenceList: controller.presenceList,
                      controller: controller))) ),
        ],
      )
      
      ); 
  }

  newFicheDialog(PresenceController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Génerer la fiche de presence'),
              content: SizedBox(
                  height: 200,
                  width: 300,
                  child: controller.isLoading
                      ? loading()
                      : Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              AutoSizeText(
                                "Fiche du ${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now())}",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                              const SizedBox(height: 20),
                              const Icon(Icons.co_present, size: p50)
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    controller.submit();
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }
}
