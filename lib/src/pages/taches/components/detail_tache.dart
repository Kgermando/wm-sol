import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/taches/components/table_rapport.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailTache extends StatefulWidget {
  const DetailTache({super.key, required this.tacheModel});
  final TacheModel tacheModel;

  @override
  State<DetailTache> createState() => _DetailTacheState();
}

class _DetailTacheState extends State<DetailTache> {
  final TachesController controller = Get.put(TachesController());
  final ProfilController profilController = Get.put(ProfilController());
  final RapportController rapportController = Get.put(RapportController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Tâches";

  Future<TacheModel> refresh() async {
    final TacheModel dataItem =
        await controller.detailView(widget.tacheModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, widget.tacheModel.nom),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Ecrire votre rapport"),
          tooltip: "Ajouter le rapport",
          icon: const Icon(Icons.edit_note),
          onPressed: () {
            Get.toNamed(TacheRoutes.rapportAdd, arguments: widget.tacheModel);
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
                child: rapportController.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!), (state) {
                  int userRole = int.parse(profilController.user.role);
                  var rapportList = state!
                      .where((element) =>
                          element.reference == widget.tacheModel.id)
                      .toList();
                  return SingleChildScrollView(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: p20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleWidget(title: 'Votre tache'),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    tooltip: 'Actualiser',
                                                    onPressed: () async {
                                                      refresh().then((value) =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              MarketingRoutes
                                                                  .marketingCampaignDetail,
                                                              arguments:
                                                                  value));
                                                    },
                                                    icon: const Icon(
                                                        Icons.refresh,
                                                        color: Colors.green)),
                                                if (userRole <= 3 &&
                                                    rapportList.isEmpty)
                                                  deleteButton(),
                                              ],
                                            ),
                                            SelectableText(
                                                DateFormat("dd-MM-yyyy HH:mm")
                                                    .format(widget
                                                        .tacheModel.created),
                                                textAlign: TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    dataWidget(),
                                    Divider(
                                      color: mainColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: p20,
                            ),
                            TableRapport(
                              rapportController: rapportController,
                              tacheModel: widget.tacheModel,
                              profilController: profilController,
                              state: state
                                  .where((element) =>
                                      element.reference == widget.tacheModel.id)
                                  .toList(),
                            ),
                          ],
                        ),
                      ));
                }))
          ],
        ));
  }

  Widget tacheFermerWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Obx(() => ElevatedButton.icon(
        onPressed: () {
          if (widget.tacheModel.readResponsable == 'Ouvert') {
            controller.submitRead(widget.tacheModel);
          }
        },
        icon: const Icon(Icons.check),
        label: controller.isLoading
            ? loadingMini()
            : Text("Fermer la tâche", style: bodyMedium)));
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    var json = jsonDecode(widget.tacheModel.tache);
    controller.quillController = flutter_quill.QuillController(
        document: flutter_quill.Document.fromJson(json),
        selection: const TextSelection.collapsed(offset: 0));
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Titre :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.nom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Numero Tâche :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.numeroTache,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Jalon du projet :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.jalon,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Personne :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.agent,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Responsable :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.signatureResp,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Status tâche :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: Column(
                children: [
                  (widget.tacheModel.readResponsable == 'Fermer')
                      ? Text("✅ Tâche Fermer !",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.green.shade700))
                      : Container(),
                  (widget.tacheModel.signatureResp ==
                              profilController.user.matricule &&
                          widget.tacheModel.readResponsable == 'Ouvert')
                      ? tacheFermerWidget()
                      : Container()
                ],
              )),
          Divider(
            color: mainColor,
          ),
          flutter_quill.QuillEditor.basic(
            controller: controller.quillController,
            readOnly: true,
            locale: const Locale('fr'),
          ),
          // ResponsiveChildWidget(
          //     flex1: 1,
          //     flex2: 3,
          //     child1: Text('Tâche :',
          //         textAlign: TextAlign.start,
          //         style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          //     child2: SelectableText(widget.tacheModel.tache,
          //         textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }

  Widget deleteButton() {
    return IconButton(
      color: Colors.red.shade700,
      icon: const Icon(Icons.delete),
      tooltip: "Suppression",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de supprimé ceci?',
              style: TextStyle(color: Colors.red)),
          content: const Text(
              'Cette action permet de supprimer définitivement ce document.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                controller.deleteData(widget.tacheModel.id!);
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
