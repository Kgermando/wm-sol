import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_folder_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade400,
  Colors.lightBlue.shade400,
  Colors.orange.shade400,
  Colors.pinkAccent.shade400,
  Colors.tealAccent.shade400,
  Colors.purpleAccent.shade400,
  Colors.limeAccent.shade400,
  Colors.blueAccent.shade400,
  Colors.brown.shade400,
  Colors.cyanAccent.shade400,
  Colors.grey.shade400,
  Colors.indigoAccent.shade400,
  Colors.redAccent.shade400,
  Colors.deepPurple.shade400
];

Color listColor =
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

class ArchiveFolderPage extends StatefulWidget {
  const ArchiveFolderPage({super.key});

  @override
  State<ArchiveFolderPage> createState() => _ArchiveFolderPageState();
}

class _ArchiveFolderPageState extends State<ArchiveFolderPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Archives";

  @override
  Widget build(BuildContext context) {
    final ArchiveFolderController controller =
        Get.put(ArchiveFolderController());
    final ProfilController profilController = Get.find();
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!), (state) {
      var archiveFolderList = controller.archiveFolderList
          .where((element) =>
              element.departement == profilController.user.departement)
          .toList();
      return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, ""),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Nouveau dossier"),
          tooltip: "Ajouter Nouveau dossier",
          icon: const Icon(Icons.archive),
          onPressed: () {
            detailAgentDialog(controller);
          },
        ),
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
                      child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: p20,
                          runSpacing: p20,
                          children:
                              List.generate(archiveFolderList.length, (index) {
                            final data = archiveFolderList[index];
                            final color =
                                _lightColors[index % _lightColors.length];
                            return cardFolder(data, color);
                          })),
                    )))
          ],
        ),
      );
    });
  }

  Widget cardFolder(ArchiveFolderModel data, Color color) {
    return GestureDetector(
        onDoubleTap: () {
          Get.toNamed(ArchiveRoutes.archiveTable, arguments: data);
        },
        child: Column(
          children: [
            Icon(
              Icons.folder,
              color: color,
              size: 100.0,
            ),
            Text(data.folderName)
          ],
        ));
  }

  detailAgentDialog(ArchiveFolderController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title:
                  Text('Nouveau dossier', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: 100,
                  width: 200,
                  child: Form(
                      key: controller.formKey, child: nomWidget(controller))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit();
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget nomWidget(ArchiveFolderController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.folderNameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom du dossier',
          ),
          keyboardType: TextInputType.text,
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
