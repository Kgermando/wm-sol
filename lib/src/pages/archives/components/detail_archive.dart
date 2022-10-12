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
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailArchive extends StatefulWidget {
  const DetailArchive({super.key, required this.archiveModel});
  final ArchiveModel archiveModel;

  @override
  State<DetailArchive> createState() => _DetailArchiveState();
}

class _DetailArchiveState extends State<DetailArchive> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Archive"; 
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

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
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: p20),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleWidget(
                                        title: widget.archiveModel.departement),
                                    Column(
                                      children: [
                                        // PrintWidget(
                                        //     tooltip: 'Imprimer le document', onPressed: () {}),
                                        SelectableText(
                                            DateFormat(
                                                    "dd-MM-yyyy HH:mm")
                                                .format(widget
                                                            .archiveModel
                                                            .created),
                                            textAlign: TextAlign.start),
                                      ],
                                    )
                                  ],
                                ),
                                dataWidget()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    ));
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
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
                textAlign: TextAlign.start, style: bodyMedium)
          ), 
          Divider(color: mainColor),
          ResponsiveChildWidget(
            flex1: 1, 
            flex2: 3, 
            child1: Text('Département :',
              textAlign: TextAlign.start,
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.archiveModel.departement,
              textAlign: TextAlign.start, style: bodyMedium)
          ), 
          Divider(color: mainColor),
          ResponsiveChildWidget(
            flex1: 1, 
            flex2: 3, 
            child1: Text('Description :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)), 
            child2: SelectableText(widget.archiveModel.description,
                    textAlign: TextAlign.start, style: bodyMedium)
          ), 
          Divider(color: mainColor),
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
                    Navigator.pushNamed(context, ArchiveRoutes.archivePdf,
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
                    textAlign: TextAlign.start, style: bodyMedium)
          ) 
        ],
      ),
    );
  }
}
