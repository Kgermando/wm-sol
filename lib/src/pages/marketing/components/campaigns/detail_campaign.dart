import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/stats_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/view_campaign.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DetailCampaign extends StatefulWidget {
  const DetailCampaign({super.key, required this.campaignModel});
  final CampaignModel campaignModel;

  @override
  State<DetailCampaign> createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final CampaignController controller = Get.put(CampaignController());
  final ProfilController profilController = Get.find();
  final PersonnelsRolesController personnelsRolesController = Get.find();
  final PersonnelsController personnelsController = Get.find();
  final TachesController tachesController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Marketing";

  Future<CampaignModel> refresh() async {
    final CampaignModel dataItem =
        await controller.detailView(widget.campaignModel.id!);
    return dataItem;
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, widget.campaignModel.typeProduit),
        drawer: const DrawerMenu(),
        floatingActionButton: (widget.campaignModel.isSubmit == "true" && 
            widget.campaignModel.approbationDG =="Approved" &&
            widget.campaignModel.approbationDD == "Approved" &&
                widget.campaignModel.approbationBudget == "Approved" &&
                widget.campaignModel.approbationFin == "Approved")
            ? FloatingActionButton.extended(
          label: const Text("Nouvelle tâche"),
          tooltip: "Ajouter une tâche pour les personnels.",
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
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
                        quillControllerWidget(),
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
        ) : Container(),
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
                    (state) => DefaultTabController(
                        length: 2,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(
                              height: 30,
                              child: TabBar(
                                physics: ScrollPhysics(),
                                tabs: [Tab(text: "View"), Tab(text: "Stats")],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: p20, bottom: p8, right: p20, left: p20),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height),
                              child: TabBarView(
                                physics: const ScrollPhysics(),
                                children: [
                                  SingleChildScrollView(
                                      child: ViewCampaign(
                                          campaignModel: widget.campaignModel,
                                          monnaieStorage: monnaieStorage,
                                          controller: controller,
                                          profilController: profilController,
                                          personnelsRolesController:
                                              personnelsRolesController,
                                          personnelsController:
                                              personnelsController,
                                          tachesController: tachesController)),
                                  SingleChildScrollView(
                                      child: StatsCampaign(
                                          campaignModel: widget.campaignModel,
                                          monnaieStorage: monnaieStorage,
                                          controller: controller,
                                          profilController: profilController,
                                          personnelsRolesController:
                                              personnelsRolesController,
                                          personnelsController:
                                              personnelsController,
                                          tachesController: tachesController))
                                ],
                              ),
                            )
                          ],
                        ))))
          ],
        ));
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

  // Widget tacheControllerWidget(TachesController tachesController) {
  //   return Container(
  //       margin: const EdgeInsets.only(bottom: p20),
  //       child: TextFormField(
  //         controller: tachesController.tacheController,
  //         keyboardType: TextInputType.multiline,
  //         minLines: 5,
  //         maxLines: 10,
  //         decoration: InputDecoration(
  //           border:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  //           labelText: 'Tâches',
  //         ),
  //         style: const TextStyle(),
  //         validator: (value) {
  //           if (value != null && value.isEmpty) {
  //             return 'Ce champs est obligatoire';
  //           } else {
  //             return null;
  //           }
  //         },
  //       ));
  // }

  Widget quillControllerWidget() {
    return Column(
      children: [
        flutter_quill.QuillToolbar.basic(controller: tachesController.quillController),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Row(
            children: [
              Expanded(
                child: flutter_quill.QuillEditor(
                  controller: tachesController.quillController,
                  readOnly: false, // true for view only mode
                  scrollController: ScrollController(),
                  locale: const Locale('fr'),
                  scrollable: true,
                  focusNode: _focusNode,
                  autoFocus: false,
                  placeholder: 'Ecrire votre Tâche ici...',
                  expands: true,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
