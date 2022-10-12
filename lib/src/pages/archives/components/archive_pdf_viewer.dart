import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class ArchivePdfViewer extends StatefulWidget {
  const ArchivePdfViewer({super.key, required this.url});
  final String url;

  @override
  State<ArchivePdfViewer> createState() => _ArchivePdfViewerState();
}

class _ArchivePdfViewerState extends State<ArchivePdfViewer> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Présences";

    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

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
            context, scaffoldKey, title, widget.url),
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
                      borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: p20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_up,
                                  ),
                                  onPressed: () {
                                    _pdfViewerController
                                        .previousPage();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  onPressed: () {
                                    _pdfViewerController
                                        .nextPage();
                                  },
                                )
                              ]),
                              Expanded(
                                  child: SfPdfViewer.network(
                                widget.url,
                                // password: 'fokad',
                                controller: _pdfViewerController,
                                enableDocumentLinkAnnotation: false,
                                key: _pdfViewerKey,
                              ))
                          ],
                        ),
                      )
                    ],
                  ),
                )))
          ],
        ),
      ));
  }
}
