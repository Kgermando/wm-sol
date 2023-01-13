
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/taches/rapport_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart'; 

class DetailRapport extends StatefulWidget {
  const DetailRapport({super.key, required this.rapportModel});
  final RapportModel rapportModel;

  @override
  State<DetailRapport> createState() => _DetailRapportState();
}

class _DetailRapportState extends State<DetailRapport> {
  final RapportController controller = Get.put(RapportController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Rapports";

  @override
  Widget build(BuildContext context) { 
    final bodyMedium = Theme.of(context).textTheme.bodyMedium; 
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, "Tâche N°${widget.rapportModel.numeroTache}"),
      drawer: const DrawerMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          (state) {
            var json = jsonDecode(widget.rapportModel.rapport);
            controller.quillControllerRead = flutter_quill.QuillController(
              document: flutter_quill.Document.fromJson(json),
              selection: const TextSelection.collapsed(offset: 0)
            );
            return SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              child: Container( 
                // margin: const EdgeInsets.only(
                //     top: p20, bottom: p8, right: p20, left: p20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ 
                            Row(
                              children: [
                                const TitleWidget(title: "Rapport"),
                                Column(
                                  children: [
                                    PrintWidget(
                                      tooltip: 'Imprimer le document',
                                      onPressed: () {},
                                    ),
                                    SelectableText(
                                        DateFormat("dd-MM-yyyy HH:mm").format(
                                            widget.rapportModel.created),
                                        textAlign: TextAlign.start),
                                  ],
                                ),
                              ],
                            ), 
                            const SizedBox(height: p20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text('N° tâche :',
                                      textAlign: TextAlign.start,
                                      style: bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                        widget.rapportModel.numeroTache,
                                      textAlign: TextAlign.start,
                                      style: bodyMedium),
                                )
                              ],
                            ),
                            Divider(color: mainColor),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text('Titre :',
                                      textAlign: TextAlign.start,
                                      style: bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(widget.rapportModel.nom,
                                      textAlign: TextAlign.start,
                                      style: bodyMedium),
                                )
                              ],
                            ),
                            Divider(color: mainColor),
                            flutter_quill.QuillEditor.basic(
                              controller: controller.quillControllerRead,
                              readOnly: true,
                              locale: const Locale('fr'),
                            ), 
                            const SizedBox(height: p30),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
          }) )
        ],
      ),
    );
  }

  Widget deleteButton(RapportController controller) {
    return IconButton(
      color: Colors.red.shade700,
      icon: const Icon(Icons.delete),
      tooltip: "Suppression",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de supprimé ceci?'),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                controller.rapportApi.deleteData(widget.rapportModel.id!);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
