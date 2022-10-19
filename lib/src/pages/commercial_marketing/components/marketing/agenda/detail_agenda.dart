import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/marketing/agenda/agenda_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/models/comm_maketing/agenda_model.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailAgenda extends StatefulWidget {
  const DetailAgenda({super.key, required this.agendaColor});
  final AgendaColor agendaColor;

  @override
  State<DetailAgenda> createState() => _DetailAgendaState();
}

class _DetailAgendaState extends State<DetailAgenda> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines"; 

  @override
  Widget build(BuildContext context) {
    final AgendaController controller = Get.put(AgendaController());

    return controller.obx(
    onLoading: loading(),
    onEmpty: const Text('Aucune donnée'),
    onError: (error) => Text(
      "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
    (state) => Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          widget.agendaColor.agendaModel.title),
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
                                  title: widget.agendaColor
                                      .agendaModel.title),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      editButton(),
                                      deleteButton(controller),
                                    ],
                                  ),
                                  SelectableText(
                                      DateFormat(
                                              "dd-MM-yyyy HH:mm")
                                          .format(widget
                                              .agendaColor
                                              .agendaModel
                                              .created),
                                      textAlign: TextAlign.start),
                                ],
                                    )
                                  ],
                                ),
                                dataWidget(),
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
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: p10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.date_range, color: widget.agendaColor.color),
              const SizedBox(width: p20),
              SelectableText(
                "Rappel le ${DateFormat("dd-MM-yyyy").format(widget.agendaColor.agendaModel.dateRappel)}",
                style: bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: p20),
          SelectableText(
            widget.agendaColor.agendaModel.description,
            style: bodyLarge,
          )
        ],
      ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: "Modification",
      onPressed: () async {
        Get.toNamed(ComMarketingRoutes.comMarketingAgendaUpdate,
            arguments: AgendaColor(
                agendaModel: widget.agendaColor.agendaModel,
                color: widget.agendaColor.color));
      });

  Widget deleteButton(AgendaController controller) {
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
              onPressed: () async {
                controller.deleteData(widget.agendaColor.agendaModel.id!); 
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
