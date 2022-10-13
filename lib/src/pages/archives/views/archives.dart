import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/archives/components/archive_table.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class ArchiveData extends StatefulWidget {
  const ArchiveData({super.key, required this.archiveFolderModel});
  final ArchiveFolderModel archiveFolderModel;

  @override
  State<ArchiveData> createState() => _ArchiveDataState();
}

class _ArchiveDataState extends State<ArchiveData> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Archives";

  @override
  Widget build(BuildContext context) {
    final ArchiveController controller = Get.put(ArchiveController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.archiveFolderModel.folderName),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Ajouter l'archive"),
                tooltip: "Ajouter votre archive",
                icon: const Icon(Icons.send_and_archive),
                onPressed: () {
                  Get.toNamed(ArchiveRoutes.addArchives,
                      arguments: widget.archiveFolderModel);
                },
              ),
              body: Row(
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableArchive(
                              archiveFolderModel: widget.archiveFolderModel,
                              controller: controller))),
                ],
              ),
            ));
  }
}