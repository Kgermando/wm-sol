import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/exploitations/agent_role_model.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/approbation_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/table_taches_campaign_detail.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/view/table_personnels_roles_filter.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ViewCampaign extends StatefulWidget {
  const ViewCampaign(
      {super.key,
      required this.campaignModel,
      required this.monnaieStorage,
      required this.controller,
      required this.profilController,
      required this.personnelsRolesController,
      required this.personnelsController,
      required this.tachesController});
  final CampaignModel campaignModel;
  final MonnaieStorage monnaieStorage;
  final CampaignController controller;
  final ProfilController profilController;
  final PersonnelsRolesController personnelsRolesController;
  final PersonnelsController personnelsController;
  final TachesController tachesController;

  @override
  State<ViewCampaign> createState() => _ViewCampaignState();
}

class _ViewCampaignState extends State<ViewCampaign> {
  Future<CampaignModel> refresh() async {
    final CampaignModel dataItem =
        await widget.controller.detailView(widget.campaignModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    int userRole = int.parse(widget.profilController.user.role);
    return Column(
      children: [
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleWidget(title: "Campagne"),
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                if (widget.campaignModel.isSubmit == 'false')
                                  IconButton(
                                      tooltip: 'Soumettre chez le DD',
                                      onPressed: () async {
                                        widget.controller
                                            .submitToDD(widget.campaignModel);
                                        refresh().then((value) =>
                                            Navigator.pushNamed(
                                                context,
                                                ExploitationRoutes
                                                    .expProjetDetail,
                                                arguments: value));
                                      },
                                      icon: Icon(Icons.send,
                                          color: Colors.teal.shade700)),
                                IconButton(
                                    tooltip: 'Actualiser',
                                    onPressed: () async {
                                      refresh().then((value) =>
                                          Navigator.pushNamed(
                                              context,
                                              MarketingRoutes
                                                  .marketingCampaignDetail,
                                              arguments: value));
                                    },
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.green)),
                                if (widget.campaignModel.approbationDG == "Unapproved" ||
                                    widget.campaignModel.approbationDD ==
                                        "Unapproved" ||
                                    widget.campaignModel.approbationBudget ==
                                        "Unapproved" ||
                                    widget.campaignModel.approbationFin ==
                                        "Unapproved" ||
                                    widget.campaignModel.isSubmit == 'false')
                                  IconButton(
                                      tooltip: "Modification du document",
                                      color: Colors.purple,
                                      onPressed: () {
                                        Get.toNamed(
                                            MarketingRoutes
                                                .marketingCampaignUpdate,
                                            arguments: widget.campaignModel);
                                      },
                                      icon: const Icon(Icons.edit)),
                                if (userRole <= 3 &&
                                    widget.campaignModel.approbationDD == "-")
                                  deleteButton(widget.controller),
                              ],
                            ),
                            SelectableText(
                                DateFormat("dd-MM-yyyy HH:mm")
                                    .format(widget.campaignModel.created),
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                dataWidget(widget.controller, widget.profilController),
              ],
            ),
          ),
        ),
        const SizedBox(height: p20),
        widget.personnelsRolesController.obx(onLoading: loadingPage(context),
            (data) {
          List<AgentRoleModel> dataList = data!
              .where((element) =>
                  element.departement == 'Marketing' &&
                  element.reference == widget.campaignModel.id)
              .toList();
          return TablePersonnelsRolesFilter(
            state: dataList,
            personnelsController: widget.personnelsController,
            personnelsRolesController: widget.personnelsRolesController,
            departement: 'Marketing',
            id: widget.campaignModel.id!,
            route: MarketingRoutes.marketingCampaignDetail,
            argument2: widget.campaignModel,
          );
        }),
        const SizedBox(height: p20),
        widget.tachesController.obx(
            onLoading: loadingPage(context),
            (state) => TableTachesCampaignDetail(
                  tachesController: widget.tachesController,
                  id: widget.campaignModel.id!,
                  departement: 'Marketing',
                  campaignModel: widget.campaignModel,
                )),
        const SizedBox(height: p20),
        if (widget.campaignModel.isSubmit == 'true')
          ApprobationCampaign(
              campaignModel: widget.campaignModel,
              controller: widget.controller,
              profilController: widget.profilController)
      ],
    );
  }

  Widget deleteButton(CampaignController controller) {
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
                controller.deleteData(widget.campaignModel.id!);
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
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
                  "${NumberFormat.decimalPattern('fr').format(double.parse(widget.campaignModel.coutCampaign))} ${widget.monnaieStorage.monney}",
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              child1: Text('Lieu ou region Ciblé :',
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
}
