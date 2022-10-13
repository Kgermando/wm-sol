import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/approbation_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/detail_departement_budget_desktop.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/budgets/view/ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/compaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailBudgetPrevisionnel extends StatefulWidget {
  const DetailBudgetPrevisionnel(
      {super.key, required this.departementBudgetModel});
  final DepartementBudgetModel departementBudgetModel;

  @override
  State<DetailBudgetPrevisionnel> createState() =>
      _DetailBudgetPrevisionnelState();
}

class _DetailBudgetPrevisionnelState extends State<DetailBudgetPrevisionnel> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";

  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.find();
    final BudgetPrevisionnelController controller =
        Get.put(BudgetPrevisionnelController());
    final LignBudgetaireController lignBudgetaireController =
        Get.put(LignBudgetaireController());
    final SalaireController salaireController = Get.put(SalaireController());
    final TransportRestController transportRestController =
        Get.put(TransportRestController());
    final TransportRestPersonnelsController transportRestPersonnelsController =
        Get.put(TransportRestPersonnelsController());
    final ProjetController projetController = Get.put(ProjetController());
    final CampaignController campaignController = Get.put(CampaignController());
    final DevisController devisController = Get.put(DevisController());
    final DevisListObjetController devisListObjetController =
        Get.put(DevisListObjetController());

    final now = DateTime.now();
    final debut = widget.departementBudgetModel.periodeDebut;
    final fin = widget.departementBudgetModel.periodeFin;

    final panding = now.compareTo(debut) < 0;
    final biginLigneBudget = now.isAfter(debut); // now.compareTo(debut) > 0;
    final expiredLigneBudget = now.isAfter(fin); //now.compareTo(fin) > 0;

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.departementBudgetModel.title),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Ajouter ligne budgetaire"),
                tooltip: "Ajout une nouvelle ligne budgetaire",
                icon: const Icon(Icons.add),
                onPressed: () {
                  Get.toNamed(BudgetRoutes.budgetLignebudgetaireAdd,
                      arguments: widget.departementBudgetModel);
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
                            title: widget
                                .departementBudgetModel
                                .title),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    tooltip: 'Rafraichir',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context,
                                          BudgetRoutes
                                              .budgetBudgetPrevisionel);
                                    },
                                    icon: Icon(
                                        Icons.refresh,
                                        color: Colors.green
                                            .shade700)),
                                if (widget
                                        .departementBudgetModel
                                        .isSubmit ==
                                    'false')
                                  IconButton(
                                      tooltip:
                                          'Soumettre chez le directeur du budget',
                                      onPressed: () {
                                        alertDialog(
                                            controller);
                                      },
                                      icon: const Icon(
                                          Icons.send),
                                      color: Colors
                                          .green.shade700),
                                if (widget
                                        .departementBudgetModel
                                        .isSubmit ==
                                    'false')
                                  IconButton(
                                      tooltip: 'Supprimer',
                                      onPressed: () async {
                                        alertDeleteDialog(
                                            controller);
                                      },
                                      icon: const Icon(
                                          Icons.delete),
                                      color: Colors
                                          .red.shade700),
                              ],
                            ),
                            SelectableText(
                                DateFormat(
                                        "dd-MM-yyyy HH:mm")
                                    .format(widget
                                        .departementBudgetModel
                                        .created),
                                textAlign: TextAlign.start),
                            if (widget
                                    .departementBudgetModel
                                    .isSubmit ==
                                'true')
                              Column(
                                children: [
                                  if (panding)
                                    Padding(
                                      padding:
                                          const EdgeInsets
                                              .all(p10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration:
                                                BoxDecoration(
                                              color: Colors
                                                  .orange
                                                  .shade700,
                                              shape: BoxShape
                                                  .circle,
                                            ),
                                          ),
                                          const SizedBox(
                                              width: p10),
                                          Text(
                                              "En attente...",
                                              style: TextStyle(
                                                  color: Colors
                                                      .orange
                                                      .shade700))
                                        ],
                                      ),
                                    ),
                                  if (biginLigneBudget)
                                    Padding(
                                      padding:
                                          const EdgeInsets
                                              .all(p10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration:
                                                BoxDecoration(
                                              color: Colors
                                                  .green
                                                  .shade700,
                                              shape: BoxShape
                                                  .circle,
                                            ),
                                          ),
                                          const SizedBox(
                                              width: p10),
                                          Text(
                                              "En cours...",
                                              style: TextStyle(
                                                  color: Colors
                                                      .green
                                                      .shade700))
                                        ],
                                      ),
                                    ),
                                  if (expiredLigneBudget)
                                    Padding(
                                      padding:
                                          const EdgeInsets
                                              .all(p10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration:
                                                BoxDecoration(
                                              color: Colors
                                                  .red
                                                  .shade700,
                                              shape: BoxShape
                                                  .circle,
                                            ),
                                          ),
                                          const SizedBox(
                                              width: p10),
                                          Text("Obsolète!",
                                              style: TextStyle(
                                                  color: Colors
                                                      .red
                                                      .shade700))
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            if (widget
                                    .departementBudgetModel
                                    .isSubmit ==
                                'false')
                              Padding(
                                padding:
                                    const EdgeInsets.all(
                                        p10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration:
                                          BoxDecoration(
                                        color: Colors.purple
                                            .shade700,
                                        shape:
                                            BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                        width: p10),
                                    Text(
                                        "En constitution...",
                                        style: TextStyle(
                                            color: Colors
                                                .purple
                                                .shade700))
                                  ],
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                    dataWidget(),
                    Divider(color: Colors.red.shade700),
                    soldeBudgets(
                        lignBudgetaireController,
                        salaireController,
                        transportRestController,
                        transportRestPersonnelsController,
                        projetController,
                        campaignController,
                        devisController,
                        devisListObjetController),
                    Divider(color: Colors.red.shade700),
                    const SizedBox(height: p20),
                    LigneBudgetaire(
                        departementBudgetModel:
                            widget.departementBudgetModel,
                        controller: controller,
                        lignBudgetaireController:
                            lignBudgetaireController),
                    ApprobationBudgetPrevisionnel(
                      data: widget.departementBudgetModel,
                      controller: controller,
                      profilController: profilController
                    ),
                    const SizedBox(
                      height: p20,
                    ),
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
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            child1: Text('Département :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.departementBudgetModel.departement,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Date de début :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                DateFormat("dd-MM-yyyy")
                    .format(widget.departementBudgetModel.periodeDebut),
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Date de Fin :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                DateFormat("dd-MM-yyyy")
                    .format(widget.departementBudgetModel.periodeFin),
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget soldeBudgets(
      LignBudgetaireController lignBudgetaireController,
      SalaireController salaireController,
      TransportRestController transportRestController,
      TransportRestPersonnelsController transportRestPersonnelsController,
      ProjetController projetController,
      CampaignController campaignController,
      DevisController devisController,
      DevisListObjetController devisListObjetController) {
    // Total des lignes budgetaires
    double coutTotal = 0.0;
    double caisseLigneBud = 0.0;
    double banqueLigneBud = 0.0;
    double finExterieurLigneBud = 0.0;

    // Total depenses
    double caisse = 0.0;
    double banque = 0.0;
    double finExterieur = 0.0;

    // Campaigns
    double caisseCampaign = 0.0;
    double banqueCampaign = 0.0;
    double finExterieurCampaign = 0.0;
    // Etat de besoins
    double caisseEtatBesion = 0.0;
    double banqueEtatBesion = 0.0;
    double finExterieurEtatBesion = 0.0;
    // Exploitations
    double caisseProjet = 0.0;
    double banqueProjet = 0.0;
    double finExterieurProjet = 0.0;
    // Salaires
    double caisseSalaire = 0.0;
    double banqueSalaire = 0.0;
    double finExterieursalaire = 0.0;
    // Transports & Restaurations
    double caisseTransRest = 0.0;
    double banqueTransRest = 0.0;
    double finExterieurTransRest = 0.0;

    // Ligne budgetaires
    List<LigneBudgetaireModel> ligneBudgetaireCoutTotalList = [];

    // Campaigns
    List<CampaignModel> campaignCaisseList = [];
    List<CampaignModel> campaignBanqueList = [];
    List<CampaignModel> campaignfinExterieurList = [];

    // Etat de besoins
    List<DevisListObjetsModel> devisCaisseList = [];
    List<DevisListObjetsModel> devisBanqueList = [];
    List<DevisListObjetsModel> devisfinExterieurList = [];

    // Exploitations
    List<ProjetModel> projetCaisseList = [];
    List<ProjetModel> projetBanqueList = [];
    List<ProjetModel> projetfinExterieurList = [];

    // Salaires
    List<PaiementSalaireModel> salaireCaisseList = [];
    List<PaiementSalaireModel> salaireBanqueList = [];
    List<PaiementSalaireModel> salairefinExterieurList = [];

    // Transports & Restaurations
    List<TransRestAgentsModel> transRestCaisseList = [];
    List<TransRestAgentsModel> transRestBanqueList = [];
    List<TransRestAgentsModel> transRestFinExterieurList = [];

    // Cout total ligne budgetaires
    ligneBudgetaireCoutTotalList = lignBudgetaireController.ligneBudgetaireList
        .where((element) =>
            element.departement == widget.departementBudgetModel.departement &&
            element.periodeBudgetDebut.microsecondsSinceEpoch ==
                widget
                    .departementBudgetModel.periodeDebut.microsecondsSinceEpoch)
        .toList();

    // Filtre ligne budgetaire pour ce budgets
    // Recuperer les données qui sont identique aux lignes budgetaires
    List<CampaignModel> campaignList = [];
    List<DevisModel> devisList = [];
    List<ProjetModel> projetList = [];
    List<PaiementSalaireModel> salaireList = [];
    List<TransportRestaurationModel> transRestList = [];

    for (var item in ligneBudgetaireCoutTotalList) {
      campaignList = campaignController.campaignList
          .where(
              (element) => element.ligneBudgetaire == item.nomLigneBudgetaire)
          .toSet()
          .toList();
      devisList = devisController.devisList
          .where(
              (element) => element.ligneBudgetaire == item.nomLigneBudgetaire)
          .toSet()
          .toList();
      projetList = projetController.projetList
          .where(
              (element) => element.ligneBudgetaire == item.nomLigneBudgetaire)
          .toSet()
          .toList();
      salaireList = salaireController.paiementSalaireList
          .where(
              (element) => element.ligneBudgetaire == item.nomLigneBudgetaire)
          .toSet()
          .toList();
      transRestList = transportRestController.transportRestaurationList
          .where(
              (element) => element.ligneBudgetaire == item.nomLigneBudgetaire)
          .toSet()
          .toList();
    }

    // Campaigns
    campaignCaisseList = campaignList
        .where((element) =>
            widget.departementBudgetModel.departement ==
                "Commercial et Marketing" &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "caisse")
        .toList();
    campaignBanqueList = campaignList
        .where((element) =>
            widget.departementBudgetModel.departement ==
                "Commercial et Marketing" &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "banque")
        .toList();
    campaignfinExterieurList = campaignList
        .where((element) =>
            widget.departementBudgetModel.departement ==
                "Commercial et Marketing" &&
            "Commercial et Marketing" ==
                widget.departementBudgetModel.departement &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Etat de Besoins
    for (var item in devisList) {
      devisCaisseList = devisListObjetController.devisListObjetList
          .where((element) =>
              widget.departementBudgetModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "caisse")
          .toList();
      devisBanqueList = devisListObjetController.devisListObjetList
          .where((element) =>
              widget.departementBudgetModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "banque")
          .toList();
      devisfinExterieurList = devisListObjetController.devisListObjetList
          .where((element) =>
              widget.departementBudgetModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "finExterieur")
          .toList();
    }

    // Exploitations
    projetCaisseList = projetList
        .where((element) =>
            widget.departementBudgetModel.departement == "Exploitations" &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "caisse")
        .toList();
    projetBanqueList = projetList
        .where((element) =>
            widget.departementBudgetModel.departement == "Exploitations" &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "banque")
        .toList();
    projetfinExterieurList = projetList
        .where((element) =>
            widget.departementBudgetModel.departement == "Exploitations" &&
            element.created
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Salaires
    salaireCaisseList = salaireList
        .where((element) =>
            widget.departementBudgetModel.departement == element.departement &&
            element.createdAt
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "caisse")
        .toList();
    salaireBanqueList = salaireList
        .where((element) =>
            widget.departementBudgetModel.departement == element.departement &&
            element.createdAt
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "banque")
        .toList();
    salairefinExterieurList = salaireList
        .where((element) =>
            widget.departementBudgetModel.departement == element.departement &&
            element.createdAt
                .isBefore(widget.departementBudgetModel.periodeFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Transports & Restaurations
    for (var item in transRestList) {
      transRestCaisseList = transportRestPersonnelsController.transRestAgentList
          .where((element) =>
              widget.departementBudgetModel.departement ==
                  "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "caisse")
          .toList();
      transRestBanqueList = transportRestPersonnelsController.transRestAgentList
          .where((element) =>
              widget.departementBudgetModel.departement ==
                  "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "banque")
          .toList();
      transRestFinExterieurList = transportRestPersonnelsController
          .transRestAgentList
          .where((element) =>
              widget.departementBudgetModel.departement ==
                  "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.created.isBefore(widget.departementBudgetModel.periodeFin) &&
              item.ressource == "finExterieur")
          .toList();
    }

    // Sommes des Lignes Budgetaires
    for (var item in ligneBudgetaireCoutTotalList) {
      coutTotal += double.parse(item.coutTotal);
    }
    for (var item in ligneBudgetaireCoutTotalList) {
      caisseLigneBud += double.parse(item.caisse);
    }
    for (var item in ligneBudgetaireCoutTotalList) {
      banqueLigneBud += double.parse(item.banque);
    }
    for (var item in ligneBudgetaireCoutTotalList) {
      finExterieurLigneBud += double.parse(item.finExterieur);
    }

    // Somme des Salaires
    for (var item in salaireCaisseList) {
      caisseSalaire += double.parse(item.salaire);
    }
    for (var item in salaireBanqueList) {
      banqueSalaire += double.parse(item.salaire);
    }
    for (var item in salairefinExterieurList) {
      finExterieursalaire += double.parse(item.salaire);
    }

    // Somme Campaigns
    for (var item in campaignCaisseList) {
      caisseCampaign += double.parse(item.coutCampaign);
    }
    for (var item in campaignBanqueList) {
      banqueCampaign += double.parse(item.coutCampaign);
    }
    for (var item in campaignfinExterieurList) {
      finExterieurCampaign += double.parse(item.coutCampaign);
    }

    // Somme Exploitations
    for (var item in projetCaisseList) {
      caisseProjet += double.parse(item.coutProjet);
    }
    for (var item in projetBanqueList) {
      banqueProjet += double.parse(item.coutProjet);
    }
    for (var item in projetfinExterieurList) {
      finExterieurProjet += double.parse(item.coutProjet);
    }

    // Somme Etat de Besoins
    for (var item in devisCaisseList) {
      caisseEtatBesion += double.parse(item.montantGlobal);
    }
    for (var item in devisBanqueList) {
      banqueEtatBesion += double.parse(item.montantGlobal);
    }
    for (var item in devisfinExterieurList) {
      finExterieurEtatBesion += double.parse(item.montantGlobal);
    }

    // Somme Transports & Restaurations
    for (var item in transRestCaisseList) {
      caisseTransRest += double.parse(item.montant);
    }
    for (var item in transRestBanqueList) {
      banqueTransRest += double.parse(item.montant);
    }
    for (var item in transRestFinExterieurList) {
      finExterieurTransRest += double.parse(item.montant);
    }

    // Total par ressources
    caisse = caisseEtatBesion +
        caisseSalaire +
        caisseCampaign +
        caisseProjet +
        caisseTransRest;

    banque = banqueEtatBesion +
        banqueSalaire +
        banqueCampaign +
        banqueProjet +
        banqueTransRest;
    finExterieur = finExterieurEtatBesion +
        finExterieursalaire +
        finExterieurCampaign +
        finExterieurProjet +
        finExterieurTransRest;

    // Differences entre les couts initial et les depenses
    double caisseSolde = caisseLigneBud - caisse;
    double banqueSolde = banqueLigneBud - banque;
    double finExterieurSolde = finExterieurLigneBud - finExterieur;

    double touxExecutions =
        (caisseSolde + banqueSolde + finExterieurSolde) * 100 / coutTotal;

    return DetailDepartementSoldeBudgets(
        coutTotal: coutTotal,
        caisseSolde: caisseSolde,
        banqueSolde: banqueSolde,
        finExterieurSolde: finExterieurSolde,
        touxExecutions: touxExecutions);
  }

  alertDialog(BudgetPrevisionnelController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: mainColor)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text(
                      "Cette action permet de soumettre le document chez du direteur du budget")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('Annuler', style: TextStyle(color: mainColor)),
                ),
                TextButton(
                  onPressed: () {
                    controller.submitToDD(widget.departementBudgetModel);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  alertDeleteDialog(BudgetPrevisionnelController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: mainColor)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le budget")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('Annuler', style: TextStyle(color: mainColor)),
                ),
                TextButton(
                  onPressed: () {
                    controller
                        .deleteData(widget.departementBudgetModel.id!)
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: Text('OK', style: TextStyle(color: mainColor)),
                ),
              ],
            );
          });
        });
  }
}
