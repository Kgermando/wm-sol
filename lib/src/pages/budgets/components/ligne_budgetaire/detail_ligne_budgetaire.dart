import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child4_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailLigneBudgetaire extends StatefulWidget {
  const DetailLigneBudgetaire({super.key, required this.ligneBudgetaireModel});
  final LigneBudgetaireModel ligneBudgetaireModel;

  @override
  State<DetailLigneBudgetaire> createState() => _DetailLigneBudgetaireState();
}

class _DetailLigneBudgetaireState extends State<DetailLigneBudgetaire> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";

  @override
  Widget build(BuildContext context) {
    final LignBudgetaireController controller =
        Get.put(LignBudgetaireController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.ligneBudgetaireModel.nomLigneBudgetaire),
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
                                              (Responsive.isDesktop(context))
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.end,
                                          children: [
                                            if (Responsive.isDesktop(context))
                                              TitleWidget(
                                                  title: widget
                                                      .ligneBudgetaireModel
                                                      .nomLigneBudgetaire),
                                            Column(
                                              children: [
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget.ligneBudgetaireModel.created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: p30,
                                        ),
                                        dataWidget(),
                                        soldeBudgets(controller),
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
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Ligne Budgetaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.nomLigneBudgetaire,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Département :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.departement,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Fin Budgetaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    DateFormat("dd-MM-yyyy").format(widget.ligneBudgetaireModel.periodeBudgetFin),
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Unité Choisie :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.uniteChoisie,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Nombre d\'unité :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.nombreUnite,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Coût Unitaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.coutUnitaire))} \$",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          const SizedBox(height: p20),
          Row(
            children: [
              Expanded(
                child: Text('Coût Total :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.coutTotal))} \$",
                    textAlign: TextAlign.start,
                    style: headline6!.copyWith(color: Colors.red.shade700)),
              )
            ],
          ),
          const SizedBox(height: p20),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Caisse :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.caisse))} \$",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Banque :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.banque))} \$",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Reste à trouver :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.finExterieur))} \$",
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.orange.shade700)),
              )
            ],
          ),
          Divider(color: mainColor),
        ],
      ),
    );
  }

  Widget soldeBudgets(LignBudgetaireController controller) {
    // Total des lignes budgetaires
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

    // Campaigns
    campaignCaisseList = controller.dataCampaignList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Commercial et Marketing" &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "caisse")
        .toList();
    campaignBanqueList = controller.dataCampaignList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Commercial et Marketing" &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "banque")
        .toList();
    campaignfinExterieurList = controller.dataCampaignList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Commercial et Marketing" &&
            "Commercial et Marketing" == widget.ligneBudgetaireModel.departement &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Etat de Besoins
    for (var item in controller.dataDevisList) {
      devisCaisseList = controller.devisListObjetsList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "caisse")
          .toList();
      devisBanqueList = controller.devisListObjetsList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "banque")
          .toList();
      devisfinExterieurList = controller.devisListObjetsList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == item.departement &&
              element.referenceDate.microsecondsSinceEpoch ==
                  item.createdRef.microsecondsSinceEpoch &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "finExterieur")
          .toList();
    }

    // Exploitations
    projetCaisseList = controller.dataProjetList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Exploitations" &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "caisse")
        .toList();
    projetBanqueList = controller.dataProjetList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Exploitations" &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "banque")
        .toList();
    projetfinExterieurList = controller.dataProjetList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == "Exploitations" &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Salaires
    salaireCaisseList = controller.dataSalaireList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == element.departement &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.createdAt.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "caisse")
        .toList();
    salaireBanqueList = controller.dataSalaireList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == element.departement &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.createdAt.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "banque")
        .toList();
    salairefinExterieurList = controller.dataSalaireList
        .where((element) =>
            widget.ligneBudgetaireModel.departement == element.departement &&
            element.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
            element.createdAt.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
            element.ressource == "finExterieur")
        .toList();

    // Transports & Restaurations
    for (var item in controller.dataTransRestList) {
      transRestCaisseList = controller.tansRestList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "caisse")
          .toList();
      transRestBanqueList = controller.tansRestList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "banque")
          .toList();
      transRestFinExterieurList = controller.tansRestList
          .where((element) =>
              widget.ligneBudgetaireModel.departement == "'Ressources Humaines'" &&
              element.reference == item.id &&
              item.ligneBudgetaire == widget.ligneBudgetaireModel.nomLigneBudgetaire &&
              item.created.isBefore(widget.ligneBudgetaireModel.periodeBudgetFin) &&
              item.ressource == "finExterieur")
          .toList();
    }

    // Salaires
    for (var item in salaireCaisseList) {
      caisseSalaire += double.parse(item.salaire);
    }
    for (var item in salaireBanqueList) {
      banqueSalaire += double.parse(item.salaire);
    }
    for (var item in salairefinExterieurList) {
      finExterieursalaire += double.parse(item.salaire);
    }

    // Campaigns
    for (var item in campaignCaisseList) {
      caisseCampaign += double.parse(item.coutCampaign);
    }
    for (var item in campaignBanqueList) {
      banqueCampaign += double.parse(item.coutCampaign);
    }
    for (var item in campaignfinExterieurList) {
      finExterieurCampaign += double.parse(item.coutCampaign);
    }

    // Exploitations
    for (var item in projetCaisseList) {
      caisseProjet += double.parse(item.coutProjet);
    }
    for (var item in projetBanqueList) {
      banqueProjet += double.parse(item.coutProjet);
    }
    for (var item in projetfinExterieurList) {
      finExterieurProjet += double.parse(item.coutProjet);
    }

    // Etat de Besoins
    for (var item in devisCaisseList) {
      caisseEtatBesion += double.parse(item.montantGlobal);
    }
    for (var item in devisBanqueList) {
      banqueEtatBesion += double.parse(item.montantGlobal);
    }
    for (var item in devisfinExterieurList) {
      finExterieurEtatBesion += double.parse(item.montantGlobal);
    }

    // Transports & Restaurations
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
    double caisseSolde = double.parse(widget.ligneBudgetaireModel.caisse) - caisse;
    double banqueSolde = double.parse(widget.ligneBudgetaireModel.banque) - banque;
    double finExterieurSolde = double.parse(widget.ligneBudgetaireModel.finExterieur) - finExterieur;
    double touxExecutions = (caisseSolde + banqueSolde + finExterieurSolde) *
        100 /
        double.parse(widget.ligneBudgetaireModel.coutTotal);

    final headline6 = Theme.of(context).textTheme.headline6;
    return ResponsiveChild4Widget(
        child1: Column(
          children: [
            const Text("Solde Caisse",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(caisseSolde)} \$",
                textAlign: TextAlign.center,
                style: headline6),
          ],
        ),
        child2: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Solde Banque",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(banqueSolde)} \$",
                  textAlign: TextAlign.center,
                  style: headline6),
            ],
          ),
        ),
        child3: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Solde Reste à trouver",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(finExterieurSolde)} \$",
                  textAlign: TextAlign.center,
                  style: headline6!.copyWith(color: Colors.orange.shade700)),
            ],
          ),
        ),
        child4: Column(
          children: [
            const Text("Taux d'executions",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(touxExecutions.toStringAsFixed(0)))} %",
                textAlign: TextAlign.center,
                style: headline6.copyWith(
                    color: (touxExecutions >= 50)
                        ? Colors.green.shade700
                        : Colors.red.shade700)),
          ],
        ));
  }
}
