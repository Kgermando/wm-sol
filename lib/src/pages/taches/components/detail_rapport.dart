import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/models/taches/rapport_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailRapport extends StatefulWidget {
  const DetailRapport({super.key, required this.rapportModel});
  final RapportModel rapportModel;

  @override
  State<DetailRapport> createState() => _DetailRapportState();
}

class _DetailRapportState extends State<DetailRapport> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Rapports";

  @override
  Widget build(BuildContext context) {
    final RapportController controller = Get.find();
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.rapportModel.numeroTache),
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
                                        ListTile(
                                          leading: const Icon(Icons.person,
                                              size: p50),
                                          title: SelectableText(
                                            widget.rapportModel.signature,
                                            style: bodySmall,
                                          ),
                                          subtitle: SelectableText(
                                            widget.rapportModel.numeroTache,
                                            style: bodySmall,
                                          ),
                                          trailing: SelectableText(
                                              timeago.format(
                                                  widget.rapportModel.created,
                                                  locale: 'fr_short'),
                                              textAlign: TextAlign.start,
                                              style: bodySmall),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text('Nom :',
                                                  textAlign: TextAlign.start,
                                                  style: bodyMedium!.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SelectableText(
                                                  widget.rapportModel.nom,
                                                  textAlign: TextAlign.start,
                                                  style: bodyMedium),
                                            )
                                          ],
                                        ),
                                        Divider(color: mainColor),
                                        SelectableText(
                                            widget.rapportModel.rapport,
                                            style: bodyMedium,
                                            textAlign: TextAlign.justify),
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
