import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/constants/style.dart';
import 'package:wm_solution/src/models/rh/presence_model.dart';
import 'package:wm_solution/src/models/rh/presence_personnel_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailPresence extends StatefulWidget {
  const DetailPresence({super.key, required this.presenceModel});
  final PresenceModel presenceModel;

  @override
  State<DetailPresence> createState() => _DetailPresenceState();
}

class _DetailPresenceState extends State<DetailPresence> {
  final PresenceController controller = Get.put(PresenceController());
  final PresencePersonneController controllerPresencePersonne =
      Get.put(PresencePersonneController());
  final PersonnelsController controllerPersonnels = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Présences";

  List<String> suggestionList = [];
  bool isSortie = false;
  String sortieBoolean = 'false';

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Scaffold(
      key: scaffoldKey,
      appBar:
          headerBar(context, scaffoldKey, title, widget.presenceModel.title),
      drawer: const DrawerMenu(),
      floatingActionButton:
          (DateTime.now().day.isEqual(widget.presenceModel.created.day))
              ? speedialWidget(controllerPresencePersonne)
              : Container(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: controllerPresencePersonne.obx(
                  onLoading: loadingPage(context),
                  onEmpty: const Text('Aucune donnée'),
                  onError: (error) => loadingError(context, error!),
                  (state) => SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const ScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: p20, bottom: p8, right: p20, left: p20),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleWidget(
                                                title:
                                                    widget.presenceModel.title),
                                            Row(
                                              children: [
                                                deleteDialog(controller),
                                                Container(
                                                  width: 2,
                                                  height: 22,
                                                  color: lightGrey,
                                                ),
                                                const SizedBox(width: p8),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                        children: [
                                                          const TextSpan(
                                                              text: "Créé à "),
                                                          TextSpan(
                                                              text: DateFormat(
                                                                      "HH:mm")
                                                                  .format(widget
                                                                      .presenceModel
                                                                      .created))
                                                        ]))
                                              ],
                                            )
                                          ],
                                        ),
                                        Divider(color: mainColor),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(p10),
                                                child: Text('Fiche créé par :',
                                                    textAlign: TextAlign.start,
                                                    style: bodyMedium!.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            Expanded(
                                              child: SelectableText(
                                                  widget
                                                      .presenceModel.signature,
                                                  textAlign: TextAlign.start,
                                                  style: bodyMedium),
                                            )
                                          ],
                                        ),
                                        Divider(color: mainColor),
                                        const SizedBox(height: p20),
                                        presencePersonnelWidget(
                                            controllerPresencePersonne,
                                            controllerPersonnels)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))))
        ],
      ),
    );
  }

  Widget deleteDialog(PresenceController controller) {
    return IconButton(
      color: Colors.red,
      icon: const Icon(Icons.delete),
      tooltip: 'Suppression de ${widget.presenceModel.title}',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de vouloir faire ceci ?',
              style: TextStyle(color: Colors.red)),
          content: const Text(
              'Cette action permet de supprimer la liste de presence.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Annuler'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                controller.deleteData(widget.presenceModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  SpeedDial speedialWidget(
      PresencePersonneController controllerPresencePersonne) {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.qr_code),
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade700,
          label: 'QrCode',
          onPressed: () {},
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade700,
          label: 'Presence',
          onPressed: () {
            newPresenceDialog(controllerPresencePersonne);
          },
        )
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  newPresenceDialog(
    PresencePersonneController controllerPresencePersonne,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title:
                  Text('Nouvelle presence', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: 250,
                  width: 300,
                  child: controllerPresencePersonne.isLoading
                      ? loading()
                      : Form(
                          key: controllerPresencePersonne.formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              identifiantWidget(controllerPresencePersonne),
                              const SizedBox(height: 20),
                              motifWidget(controllerPresencePersonne),
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form =
                        controllerPresencePersonne.formKey.currentState!;
                    if (form.validate()) {
                      controllerPresencePersonne.submit(widget.presenceModel);
                      form.reset();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget presencePersonnelWidget(
      PresencePersonneController controllerPresencePersonne,
      PersonnelsController controllerPersonnels) {
    List<PresencePersonnelModel> dataList = controllerPresencePersonne
        .presencePersonneList
        .where((element) => element.reference == widget.presenceModel.id!)
        .toList();

    List<String> presencePersonnelList =
        dataList.map((e) => e.identifiant).toList();

    List<String> agentsFilter =
        controllerPersonnels.personnelsList.map((e) => e.matricule).toList();

    suggestionList =
        agentsFilter.toSet().difference(presencePersonnelList.toSet()).toList();

    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, index) {
              final personne = dataList[index];
              if (personne.sortie == 'true') {
                isSortie = true;
              } else if (personne.sortie == 'false') {
                isSortie = false;
              }
              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 40.0,
                    color: mainColor,
                  ),
                  title: Text(personne.identifiant),
                  subtitle: Text(
                      "Arrivé à ${DateFormat("HH:mm").format(personne.created)}"),
                  trailing: IconButton(
                      tooltip: (personne.sortie == 'true')
                              ?  "Sortie agent."
                              : "Déjà sortie.",
                      onPressed: () {
                        if(personne.sortie == 'false') {
                          sortiePresenceDialog(
                            controllerPresencePersonne, personne);
                        }
                      },
                      icon: Icon(Icons.logout,
                          color: (personne.sortie == 'true')
                              ? Colors.red
                              : Colors.green)),
                  onLongPress: () {
                    detailAgentDialog(personne);
                  },
                ),
              );
            }));
  }

  detailAgentDialog(PresencePersonnelModel personne) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Infos detail', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: 500,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text("identifiant:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text(personne.identifiant)),
                        ],
                      ),
                      Divider(color: mainColor),
                      const Text("Motif:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      AutoSizeText(personne.motif,
                          textAlign: TextAlign.justify, maxLines: 4),
                      Divider(color: mainColor),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text("Statut:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          if (personne.sortie == 'true')
                            const Expanded(
                                flex: 3,
                                child: Text("Déjà sortie",
                                    style: TextStyle(color: Colors.red))),
                          if (personne.sortie == 'false')
                            const Expanded(
                                flex: 3,
                                child: Text("Pas encore sortie",
                                    style: TextStyle(color: Colors.green)))
                        ],
                      ),
                      Divider(color: mainColor),
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Entrer signé par: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(child: Text(personne.signature)),
                        ],
                      ),
                      Divider(color: mainColor),
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Sortie signé par: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(child: Text(personne.signatureFermeture)),
                        ],
                      ),
                      Divider(color: mainColor),
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Entrer le: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Text(DateFormat("dd-MM-yyyy à HH:mm")
                                  .format(personne.created))),
                        ],
                      ),
                      Divider(color: mainColor),
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Sortie le: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              child: (personne.sortie == 'false')
                                  ? const Text("-")
                                  : Text(DateFormat("dd-MM-yyyy à HH:mm")
                                      .format(personne.createdSortie))),
                        ],
                      ),
                      Divider(color: mainColor),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  sortiePresenceDialog(PresencePersonneController controllerPresencePersonne,
      PresencePersonnelModel personne) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Sortie de ${personne.identifiant}',
                  style: const TextStyle(color: Colors.red)),
              content: const SizedBox(
                  height: 100,
                  width: 300,
                  child: Text("Cette action indique que l'individu est sortie.")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    controllerPresencePersonne.submitSortie(personne);
                    Navigator.pop(context, 'ok');
                  },
                  child:
                      const Text('OK', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  Widget identifiantWidget(
      PresencePersonneController controllerPresencePersonne) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          // controller: controllerPresencePersonne.identifiantController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Identifiant de l'individu",
          ),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) => value == null ? "Select Identifiant" : null,
          onChanged: (value) {
            controllerPresencePersonne.identifiantController = value;
          },
        ));
  }

  Widget motifWidget(PresencePersonneController controllerPresencePersonne) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controllerPresencePersonne.motifController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Observation',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }
}
