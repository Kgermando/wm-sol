import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines"; 

  @override
  Widget build(BuildContext context) {
    final PerformenceNoteController controllerNote = Get.put(PerformenceNoteController());
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
                    child: Column(
                      children: [
                        dataWidget(controllerNote),
                        const SizedBox(height: p30),
                        listRapport(controllerNote)
                      ],
                    )),
                ))
          ],
        ),
      ),
    );
  }

  Widget dataWidget(PerformenceNoteController controllerNote) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
 
    double hospitaliteTotal = 0.0;
    double ponctualiteTotal = 0.0;
    double travailleTotal = 0.0;

    for (var item in controllerNote.performenceNoteList
        .where((element) => element.agent == widget.performenceModel.agent)) {
      hospitaliteTotal += double.parse(item.hospitalite);
      ponctualiteTotal += double.parse(item.ponctualite);
      travailleTotal += double.parse(item.travaille);
    }

    return Padding(
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
                    textAlign: TextAlign.start, style: bodyMedium)
          ), 
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
    );
  }

  Widget listRapport(PerformenceNoteController controllerNote) {
    return (controllerNote.performenceNoteList.isEmpty)
      ? const Text("Pas de données. 😑")
      : ListView.builder(
          itemCount: controllerNote.performenceNoteList.length,
          itemBuilder: (context, index) {
            final rapport = controllerNote.performenceNoteList[index];
            return buildRapport(rapport, index);
          }); 
  }

  Widget buildRapport(PerformenceNoteModel rapport, int index) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final color = _lightColors[index % _lightColors.length];
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: Column(
          children: [
            ListTile(
              dense: true,
              leading: Icon(Icons.person, color: color),
              title: SelectableText(
                rapport.signature,
                style: bodySmall,
              ),
              // subtitle: SelectableText(
              //   rapport.departement,
              //   style: bodySmall,
              // ),
              trailing: SelectableText(
                  timeago.format(rapport.created, locale: 'fr_short'),
                  textAlign: TextAlign.start,
                  style: bodySmall!.copyWith(color: color)),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text('Hospitalité :',
                          textAlign: TextAlign.start,
                          style: bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700)),
                      SelectableText(rapport.hospitalite,
                          textAlign: TextAlign.start, style: bodyMedium),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text('Ponctualité :',
                          textAlign: TextAlign.start,
                          style: bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700)),
                      SelectableText(rapport.ponctualite,
                          textAlign: TextAlign.start, style: bodyMedium),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text('Travaille :',
                          textAlign: TextAlign.start,
                          style: bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade700)),
                      SelectableText(rapport.travaille,
                          textAlign: TextAlign.start, style: bodyMedium),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SelectableText(rapport.note,
                      style: bodyMedium, textAlign: TextAlign.justify),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
