import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final ProfilController profilController = Get.find();
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
      appBar:
          headerBar(context, scaffoldKey, title, widget.tacheModel.nom),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ecrire votre rapport"),
        tooltip: "Ajouter le rapport",
        icon: const Icon(Icons.edit_note),
        onPressed: () {
          Get.toNamed(TacheRoutes.rapportAdd,
              arguments: widget.tacheModel);
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
              child: controller.obx(
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
                                            const TitleWidget(
                                                title: 'Votre tache'),
                                            Column(
                                              children: [
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .tacheModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                                if (widget.tacheModel.readResponsable == 'Fermer')
                                                Text("✅ Tâche Fermer !",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .green.shade700)),
                                              if (widget.tacheModel.signatureResp ==
                                                      profilController
                                                          .user.matricule &&
                                                  widget.tacheModel.readResponsable == 'Ouvert')
                                                checkboxRead(controller), 
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
                                ),
                              ],
                            ),
                          ))) )
                ],
              ) 
            )
    
    
    ;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.green;
  }

  checkboxRead(TachesController controller) {
    bool read = false;
    if (widget.tacheModel.readResponsable == 'Ouvert') {
      read = true;
    } else if (widget.tacheModel.readResponsable == 'Fermer') {
      read = false;
    }
    return Obx(() => ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: read,
        onChanged: (bool? value) {
          setState(() {
            read = value!;
            controller.submitRead(widget.tacheModel);
             refresh().then((value) => Navigator.pushNamed(
                context, ExploitationRoutes.expProjetDetail,
                arguments: value));
            // confirmeLecture(data);
          });
        },
      ),
      title: const Text("Cloturer cette tâche."),
    )) ;
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
              child1: Text('Tâche :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.tacheModel.tache,
                  textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }
}
