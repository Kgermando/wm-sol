import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DetailArchive extends StatefulWidget {
  const DetailArchive({super.key, required this.archiveModel});
  final ArchiveModel archiveModel;

  @override
  State<DetailArchive> createState() => _DetailArchiveState();
}

class _DetailArchiveState extends State<DetailArchive> {
  final ProfilController profilController = Get.find();
  final ArchiveController controller = Get.put(ArchiveController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Archive";
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  Future<ArchiveModel> refresh() async {
    final ArchiveModel dataItem =
        await controller.detailView(widget.archiveModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.archiveModel.folderName),
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
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        refresh().then((value) =>
                                            Navigator.pushNamed(
                                                context,
                                                ArchiveRoutes
                                                    .archivesDetail,
                                                arguments:
                                                    value));
                                      },
                                      icon: const Icon(
                                          Icons.refresh,
                                          color:
                                              Colors.green)),
                                    SelectableText(
                                        DateFormat("dd-MM-yyyy HH:mm")
                                            .format(widget.archiveModel.created),
                                        textAlign: TextAlign.start),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: p20),
                            dataWidget()
                          ],
                        ),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    int roleUser = int.parse(profilController.user.role);
    var departementList = jsonDecode(widget.archiveModel.departement);
    String departement = departementList.first;
    int level = int.parse(widget.archiveModel.level);
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Nom du Document :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.archiveModel.nomDocument,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Département :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(departement,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Description :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.archiveModel.description,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          if(roleUser <= level)
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Fichier archivé :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: (widget.archiveModel.fichier == '-')
                ? const Text('-')
                : TextButton(
                    onPressed: () {
                      Get.toNamed(ArchiveRoutes.archivePdf,
                          arguments: widget.archiveModel.fichier);
                      pdfViewerKey.currentState?.openBookmarkView();
                    },
                    child: Text("Cliquer pour visualiser",
                        textAlign: TextAlign.start,
                        style: bodyMedium.copyWith(color: Colors.red)),
                  ),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Signature :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.archiveModel.signature,
                  textAlign: TextAlign.start, style: bodyMedium))
        ],
      ),
    );
  }
}
