import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/table_performence_note.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

final _lightColors = [
  Colors.pinkAccent.shade700,
  Colors.tealAccent.shade700,
  mainColor,
  Colors.lightGreen.shade700,
  Colors.lightBlue.shade700,
  Colors.orange.shade700,
];

class DetailPerformence extends StatefulWidget {
  const DetailPerformence({super.key, required this.performenceModel});
  final PerformenceModel performenceModel;

  @override
  State<DetailPerformence> createState() => _DetailPerformenceState();
}

class _DetailPerformenceState extends State<DetailPerformence> {
  final PerformenceNoteController controllerNote = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title,
              "${widget.performenceModel.prenom} ${widget.performenceModel.nom}"),
          drawer: const DrawerMenu(),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Donnez une note"),
            tooltip: "Donnez une note de performence",
            icon: const Icon(Icons.add_task),
            onPressed: () {
              Get.toNamed(RhRoutes.rhPerformenceAddNote,
                  arguments: widget.performenceModel);
            },
          ),
          body: controllerNote.obx(
            onLoading: loadingPage(context),
            onEmpty: const Text('Aucune donnée'),
            onError: (error) => loadingError(context, error!),
            (state) => Row(
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
                              dataWidget(state!
                                  .where((element) =>
                                      element.agent ==
                                      widget.performenceModel.agent)
                                  .toList()),
                              const SizedBox(height: p30),
                              listRapport(state
                                  .where((element) =>
                                      element.agent ==
                                      widget.performenceModel.agent)
                                  .toList())
                            ],
                          )),
                    ))
              ],
            ),
          )),
    );
  }

  Widget dataWidget(List<PerformenceNoteModel> performenceNoteList) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    double hospitaliteTotal = 0.0;
    double ponctualiteTotal = 0.0;
    double travailleTotal = 0.0;

    for (var item in performenceNoteList) {
      hospitaliteTotal += double.parse(item.hospitalite);
      ponctualiteTotal += double.parse(item.ponctualite);
      travailleTotal += double.parse(item.travaille);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: Column(
          children: [
            ResponsiveChildWidget(
                flex1: 1,
                flex2: 3,
                child1: Text('Nom :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.performenceModel.nom,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(
              color: mainColor,
            ),
            ResponsiveChildWidget(
                flex1: 1,
                flex2: 3,
                child1: Text('Post-Nom :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.performenceModel.postnom,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(
              color: mainColor,
            ),
            ResponsiveChildWidget(
                flex1: 1,
                flex2: 3,
                child1: Text('Prénom :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.performenceModel.prenom,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(
              color: mainColor,
            ),
            ResponsiveChildWidget(
                flex1: 1,
                flex2: 3,
                child1: Text('Matricule :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.performenceModel.agent,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(
              color: mainColor,
            ),
            ResponsiveChildWidget(
                flex1: 1,
                flex2: 3,
                child1: Text('Département :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.performenceModel.departement,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(
              color: mainColor,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SelectableText("CUMULS",
                  textAlign: TextAlign.center,
                  style: headline6!.copyWith(
                      color: Colors.red.shade700, fontWeight: FontWeight.bold)),
            ]),
            ResponsiveChild3Widget(
              flex1: 3,
              flex2: 3,
              flex3: 3,
              child1: Column(
                children: [
                  Text('Hospitalité :',
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700)),
                  SelectableText("$hospitaliteTotal",
                      textAlign: TextAlign.start, style: headline6),
                ],
              ),
              child2: Column(
                children: [
                  Text('Ponctualité :',
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700)),
                  SelectableText("$ponctualiteTotal",
                      textAlign: TextAlign.start, style: headline6),
                ],
              ),
              child3: Column(
                children: [
                  Text('Travaille :',
                      textAlign: TextAlign.start,
                      style: headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade700)),
                  SelectableText("$travailleTotal",
                      textAlign: TextAlign.start, style: headline6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listRapport(List<PerformenceNoteModel> performenceNoteList) {
    return (performenceNoteList.isEmpty)
        ? const Text("Pas de données. 😑")
        : TablePerformenceNote(
            performenceNoteList: performenceNoteList,
            controllerNote: controllerNote);
  }

  // Widget buildRapport(PerformenceNoteModel rapport, int index) {
  //   final bodySmall = Theme.of(context).textTheme.bodySmall;
  //   final bodyMedium = Theme.of(context).textTheme.bodyMedium;
  //   final color = _lightColors[index % _lightColors.length];
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(p10),
  //       child: Column(
  //         children: [
  //           ListTile(
  //             dense: true,
  //             leading: Icon(Icons.person, color: color),
  //             title: SelectableText(
  //               rapport.signature,
  //               style: bodySmall,
  //             ),
  //             trailing: SelectableText(
  //                 timeago.format(rapport.created, locale: 'fr_short'),
  //                 textAlign: TextAlign.start,
  //                 style: bodySmall!.copyWith(color: color)),
  //           ),
  //           ResponsiveChild3Widget(
  //               flex1: 3,
  //               flex2: 3,
  //               flex3: 3,
  //               child1: Column(
  //                 children: [
  //                   Text('Hospitalité :',
  //                       textAlign: TextAlign.start,
  //                       style: bodyMedium!.copyWith(
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.blue.shade700)),
  //                   SelectableText(rapport.hospitalite,
  //                       textAlign: TextAlign.start, style: bodyMedium),
  //                 ],
  //               ),
  //               child2: Column(
  //                 children: [
  //                   Text('Ponctualité :',
  //                       textAlign: TextAlign.start,
  //                       style: bodyMedium.copyWith(
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.green.shade700)),
  //                   SelectableText(rapport.ponctualite,
  //                       textAlign: TextAlign.start, style: bodyMedium),
  //                 ],
  //               ),
  //               child3: Column(
  //                 children: [
  //                   Text('Travaille :',
  //                       textAlign: TextAlign.start,
  //                       style: bodyMedium.copyWith(
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.purple.shade700)),
  //                   SelectableText(rapport.travaille,
  //                       textAlign: TextAlign.start, style: bodyMedium),
  //                 ],
  //               )),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 child: SelectableText(rapport.note,
  //                     style: bodyMedium, textAlign: TextAlign.justify),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
