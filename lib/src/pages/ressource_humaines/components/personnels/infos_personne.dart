import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/presence_personnel_model.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/table_salaire_user.dart'; 
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart'; 
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class InfosPersonne extends StatelessWidget {
  const InfosPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  Widget build(BuildContext context) {
    final PerformenceNoteController controllerNote = Get.find();
    final PresencePersonneController presencePersonneController = Get.find();
    final SalaireController salaireController = Get.find(); 
    return Column(
      children: [
        performenceWideget(context, controllerNote),
        Card(
          child: Column(
            children: [
              const TitleWidget(title: "Cumuls générale"),
              tableCumuls(presencePersonneController),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              const TitleWidget(title: "Ce mois-ci"),
              tableTotal(presencePersonneController),
              tableListAgents(presencePersonneController),
            ],
          ),
        ),  
        const SizedBox(height: p20),
        TableSalaireUser(
          personne: personne,
          salaireController: salaireController,
          salaireList: salaireController.paiementSalaireList
              .where((e) =>
                  e.matricule == personne.matricule &&
                  e.prenom == personne.prenom &&
                  e.nom == personne.nom)
              .toList())
      ],
    );
  }

  Widget performenceWideget(
      BuildContext context, PerformenceNoteController controllerNote) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    double hospitaliteTotal = 0.0;
    double ponctualiteTotal = 0.0;
    double travailleTotal = 0.0;

    for (var item in controllerNote.performenceNoteList
        .where((element) => element.agent == personne.matricule)) {
      hospitaliteTotal += double.parse(item.hospitalite);
      ponctualiteTotal += double.parse(item.ponctualite);
      travailleTotal += double.parse(item.travaille);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: p20),
      child: Card(
        child: ResponsiveChild3Widget(
          flex1: 3,
          flex2: 3,
          flex3: 3,
          child1: Column(
            children: [
              Text('Hospitalité :',
                  textAlign: TextAlign.start,
                  style: headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
              SelectableText("$hospitaliteTotal",
                  textAlign: TextAlign.start, style: headlineSmall),
            ],
          ),
          child2: Column(
            children: [
              Text('Ponctualité :',
                  textAlign: TextAlign.start,
                  style: headlineSmall.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.green.shade700)),
              SelectableText("$ponctualiteTotal",
                  textAlign: TextAlign.start, style: headlineSmall),
            ],
          ),
          child3: Column(
            children: [
              Text('Travaille :',
                  textAlign: TextAlign.start,
                  style: headlineSmall.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.purple.shade700)),
              SelectableText("$travailleTotal",
                  textAlign: TextAlign.start, style: headlineSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableCumuls(PresencePersonneController presencePersonneController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: p20),
      child: Table(
        border: TableBorder.all(color: Colors.red),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
        },
        children: [
          tableRowCumuls(presencePersonneController),
        ],
      ),
    );
  }

  TableRow tableRowCumuls(
      PresencePersonneController presencePersonneController) {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child: const AutoSizeText("Cumuls d'Heures"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: AutoSizeText(
            "${presencePersonneController.isHoursCumulsWork} Heures"),
      ),
    ]);
  }

  Widget tableTotal(PresencePersonneController presencePersonneController) {
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Table(
        border: TableBorder.all(color: Colors.purple),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
        },
        children: [
          tableRowHeaderTotal(),
          tableRowTotal(presencePersonneController)
        ],
      ),
    );
  }

  TableRow tableRowHeaderTotal() {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child: const AutoSizeText("Total des jours"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: const AutoSizeText("Total d'heures de travail"),
      ),
    ]);
  }

  TableRow tableRowTotal(
      PresencePersonneController presencePersonneController) {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child: AutoSizeText("${presencePersonneController.isJoursWork} jours"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: AutoSizeText("${presencePersonneController.isHoursWork} heures"),
      ),
    ]);
  }

  Widget tableListAgents(
      PresencePersonneController presencePersonneController) {
    var dataList = presencePersonneController.presencePersonneList
        .where((e) => e.identifiant == personne.matricule)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
        },
        children: [tableRowHeader(), for (var item in dataList) tableRow(item)],
      ),
    );
  }

  TableRow tableRowHeader() {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child: const AutoSizeText("Date"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: const AutoSizeText("Nombre d'heures de travail"),
      ),
    ]);
  }

  TableRow tableRow(PresencePersonnelModel item) {
    int isHoursWork = 0;
    isHoursWork = item.createdSortie.hour - item.created.hour;
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child: AutoSizeText(DateFormat("dd-MM-yyyy").format(item.created)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: AutoSizeText("$isHoursWork heures"),
      ),
    ]);
  }
}
