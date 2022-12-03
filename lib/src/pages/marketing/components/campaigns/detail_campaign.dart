import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/approbation_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/table_personnels_roles_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/table_taches_campaign_detail.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailCampaign extends StatefulWidget {
  const DetailCampaign({super.key, required this.campaignModel});
  final CampaignModel campaignModel;

  @override
  State<DetailCampaign> createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final CampaignController controller = Get.find();
  final ProfilController profilController = Get.find();
  final PersonnelsRolesController personnelsRolesController = Get.find();
  final PersonnelsController personnelsController = Get.find();
  final TachesController tachesController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Marketing";

  @override
  Widget build(BuildContext context) {
    int userRole = int.parse(profilController.user.role);
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, widget.campaignModel.typeProduit),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Nouvelle tâche"),
          tooltip: "Ajouter une tâche pour les personnels.",
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.amber.shade100,
                  padding: const EdgeInsets.all(p20),
                  child: Form(
                    key: tachesController.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                                child: Text("Ecrire votre tâche ici.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall)),
                          ],
                        ),
                        const SizedBox(
                          height: p20,
                        ),
                        agentWidget(
                            tachesController, personnelsRolesController),
                        jalonControllerWidget(tachesController),
                        tacheControllerWidget(tachesController),
                        const SizedBox(
                          height: p20,
                        ),
                        BtnWidget(
                            title: 'Soumettre',
                            press: () {
                              final form =
                                  tachesController.formKey.currentState!;
                              if (form.validate()) {
                                tachesController.submit(
                                    widget.campaignModel.typeProduit,
                                    tachesController.tachesList.length,
                                    widget.campaignModel.id!,
                                    'Marketing');
                                form.reset();
                              }
                            },
                            isLoading: tachesController.isLoading)
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        body: controller.obx(
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
                                                  title: widget.campaignModel
                                                      .typeProduit),
                                              Column(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          if (userRole <= 3)
                                                            IconButton(
                                                                tooltip:
                                                                    "Modification du document",
                                                                color: Colors
                                                                    .purple,
                                                                onPressed: () {
                                                                  Get.toNamed(
                                                                      MarketingRoutes
                                                                          .marketingCampaignUpdate,
                                                                      arguments:
                                                                          widget
                                                                              .campaignModel);
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .edit)),
                                                          if (userRole <= 3 &&
                                                              widget.campaignModel
                                                                      .approbationDD ==
                                                                  "-")
                                                            deleteButton(
                                                                controller),
                                                        ],
                                                      ),
                                                      SelectableText(
                                                          DateFormat(
                                                                  "dd-MM-yyyy HH:mm")
                                                              .format(widget
                                                                  .campaignModel
                                                                  .created),
                                                          textAlign:
                                                              TextAlign.start),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          dataWidget(
                                              controller, profilController),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: p20),
                                  TablePersonnelsRolesCampaign(
                                    personnelsRolesController:
                                        personnelsRolesController,
                                    personnelsController: personnelsController,
                                    approuvedDD:
                                        widget.campaignModel.approbationDD,
                                    id: widget.campaignModel.id!,
                                    departement: 'Marketing',
                                    campaignModel: widget.campaignModel,
                                  ),
                                  const SizedBox(height: p20),
                                  TableTachesCampaignDetail(
                                    tachesController: tachesController,
                                    id: widget.campaignModel.id!,
                                    departement: 'Marketing',
                                    campaignModel: widget.campaignModel,
                                  ),
                                  const SizedBox(height: p20),
                                  ApprobationCampaign(
                                      campaignModel: widget.campaignModel,
                                      controller: controller,
                                      profilController: profilController)
                                ],
                              ),
                            )))
                  ],
                )));
  }

  Widget deleteButton(CampaignController controller) {
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
                controller.campaignApi.deleteData(widget.campaignModel.id!);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataWidget(
      CampaignController controller, ProfilController profilController) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          const SizedBox(
            height: p20,
          ),
          ResponsiveChildWidget(
              child1: Text('Produit :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.campaignModel.typeProduit,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Date Debut Et Fin :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.campaignModel.dateDebutEtFin,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Coût de la Campagne :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(double.parse(widget.campaignModel.coutCampaign))} ${monnaieStorage.monney}",
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Lieu Cible :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.campaignModel.lieuCible,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Objet de la Promotion :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.campaignModel.promotion,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Objectifs :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.campaignModel.objectifs,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChild3Widget(
            child1: Text('Observation :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: (widget.campaignModel.observation == 'false' &&
                    profilController.user.departement == "Finances")
                ? checkboxRead(controller)
                : Container(),
            child3: (widget.campaignModel.observation == 'true')
                ? SelectableText(
                    'Payé',
                    style:
                        bodyMedium.copyWith(color: Colors.greenAccent.shade700),
                  )
                : SelectableText(
                    'Non payé',
                    style:
                        bodyMedium.copyWith(color: Colors.redAccent.shade700),
                  ),
          ),
          Divider(color: mainColor),
        ],
      ),
    );
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

  checkboxRead(CampaignController controller) {
    bool isChecked = false;
    if (widget.campaignModel.observation == 'true') {
      isChecked = true;
    } else if (widget.campaignModel.observation == 'false') {
      isChecked = false;
    }
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            controller.submitObservation(widget.campaignModel);
          });
        },
      ),
      title: const Text("Confirmation de payement"),
    );
  }

  Widget agentWidget(TachesController tachesController,
      PersonnelsRolesController personnelsRolesController) {
    var agentList = personnelsRolesController.personnelsRoleList
        .map((e) => e.agent)
        .toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Personnel',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: tachesController.agent,
        isExpanded: true,
        items: agentList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select personnel" : null,
        onChanged: (value) {
          setState(() {
            tachesController.agent = value!;
          });
        },
      ),
    );
  }

  Widget jalonControllerWidget(TachesController tachesController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: tachesController.jalonController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Jalon',
          ),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 3,
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

  Widget tacheControllerWidget(TachesController tachesController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: tachesController.tacheController,
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Tâches',
          ),
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
