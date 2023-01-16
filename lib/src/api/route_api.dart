

const String baseUrl = "http://44.212.22.197";
const String mainUrl = "$baseUrl/api";

// Notifications departements
var adminDepartementNotifyUrl = "$mainUrl/counts/departement-admin";
var budgetsDepartementNotifyUrl = "$mainUrl/counts/departement-budgets";
var marketingDepartementNotifyUrl = "$mainUrl/counts/departement-marketing";
var commDepartementNotifyUrl = "$mainUrl/counts/departement-commmercials";
var comptabiliteDepartementNotifyUrl = "$mainUrl/counts/departement-comptabilite";
var exploitationsDepartementNotifyUrl = "$mainUrl/counts/departement-exploitations";
var financesDepartementNotifyUrl = "$mainUrl/counts/departement-finances";
var logistiqueDepartementNotifyUrl = "$mainUrl/counts/departement-logistique";
var rhDepartementNotifyUrl = "$mainUrl/counts/departement-rh";

// Notifications
var budgetNotifyUrl = "$mainUrl/counts/budgets";
var campaignsNotifyUrl = "$mainUrl/counts/campaigns";
var prodModelNotifyUrl = "$mainUrl/counts/prod-models";
var agendasNotifyUrl = "$mainUrl/counts/agendas";
var cartNotifyUrl = "$mainUrl/counts/carts";
var succursalesNotifyUrl = "$mainUrl/counts/succursales"; 
var bilansNotifyUrl = "$mainUrl/counts/bilans";
var compteResultatsNotifyUrl = "$mainUrl/counts/compte-resultats"; 
var devisNotifyUrl = "$mainUrl/counts/devis";
var projetsNotifyUrl = "$mainUrl/counts/projets";
var productionsNotifyUrl = "$mainUrl/counts/productions";
var tachesNotifyUrl = "$mainUrl/counts/taches";
var creancesNotifyUrl = "$mainUrl/counts/creances";
var dettesNotifyUrl = "$mainUrl/counts/dettes";
var carburantsNotifyUrl = "$mainUrl/counts/carburants";
var materielNotifyUrl = "$mainUrl/counts/materiels";
var entretiensNotifyUrl = "$mainUrl/counts/entretiens";
var etatMaterielsNotifyUrl = "$mainUrl/counts/etat-materiels";
var immobiliersNotifyUrl = "$mainUrl/counts/immobiliers";
var mobiliersNotifyUrl = "$mainUrl/counts/mobiliers";
var trajetNotifyUrl = "$mainUrl/counts/trajets";
var salairesNotifyUrl = "$mainUrl/counts/salaires";
var transRestNotifyUrl = "$mainUrl/counts/trans-rests";
var mailsNotifyUrl = "$mainUrl/counts/mails";

// AUTH
var refreshTokenUrl = Uri.parse("$mainUrl/auth/reloadToken");
var loginUrl = Uri.parse("$mainUrl/auth/login");
var logoutUrl = Uri.parse("$mainUrl/auth/logout");

var registerUrl = Uri.parse("$mainUrl/user/insert-new-user");
var userAllUrl = Uri.parse("$mainUrl/user/users/");
var userUrl = Uri.parse("$mainUrl/user/");

// Actionnaire
var actionnaireListUrl = Uri.parse("$mainUrl/admin/actionnaires/");
var actionnaireLimitUrl = Uri.parse("$mainUrl/admin/actionnaires/get-data-limit/");
var actionnaireAddUrl =
    Uri.parse("$mainUrl/admin/actionnaires/insert-new-actionnaire");
var actionnaireCotisationListUrl =
    Uri.parse("$mainUrl/admin/actionnaire-cotisations/");
var actionnaireCotisationAddUrl = Uri.parse(
    "$mainUrl/admin/actionnaire-cotisations/insert-new-actionnaire-cotisation");
var actionnaireTransferttUrl =
    Uri.parse("$mainUrl/admin/actionnaire-transferts/");
var actionnaireTransfertAddUrl = Uri.parse(
  "$mainUrl/admin/actionnaire-transferts/insert-new-actionnaire-tranfert");

// RH
var listAgentsUrl = Uri.parse("$mainUrl/rh/agents/");
var addAgentsUrl = Uri.parse("$mainUrl/rh/agents/insert-new-agent");
var agentCountUrl = Uri.parse("$mainUrl/rh/agents/get-count/");
var agentChartPieSexeUrl = Uri.parse("$mainUrl/rh/agents/chart-pie-sexe/");

var listPaiementSalaireUrl = Uri.parse("$mainUrl/rh/paiement-salaires/");
var addPaiementSalaireUrl =
    Uri.parse("$mainUrl/rh/paiement-salaires/insert-new-paiement");

var listPresenceUrl = Uri.parse("$mainUrl/rh/presences/");
var addPresenceUrl = Uri.parse("$mainUrl/rh/presences/insert-new-presence");
var listPresencePersonnelUrl = Uri.parse("$mainUrl/rh/presence-personnels/");
var addPresencePersonnelUrl =
    Uri.parse("$mainUrl/rh/presence-personnels/insert-new-presence-personnel"); 

var listPerformenceUrl = Uri.parse("$mainUrl/rh/performences/");
var addPerformenceUrl =
    Uri.parse("$mainUrl/rh/performences/insert-new-performence");
var listPerformenceNoteUrl = Uri.parse("$mainUrl/rh/performences-note/");
var addPerformenceNoteUrl =
    Uri.parse("$mainUrl/rh/performences-note/insert-new-performence-note");

var transportRestaurationUrl =
    Uri.parse("$mainUrl/rh/transport-restaurations/");
var addTransportRestaurationUrl = Uri.parse(
    "$mainUrl/rh/transport-restaurations/insert-new-transport-restauration");
var transRestAgentsUrl = Uri.parse("$mainUrl/rh/trans-rest-agents/");
var addTransRestAgentsUrl =
    Uri.parse("$mainUrl/rh/trans-rest-agents/insert-new-trans-rest-agent");

// Finances
var banqueNameUrl = Uri.parse("$mainUrl/finances/transactions/banques-name/");
var addBanqueNameUrl = Uri.parse(
    "$mainUrl/finances/transactions/banques-name/insert-new-transaction-banque");
var caisseNameUrl = Uri.parse("$mainUrl/finances/transactions/caisses-name/");
var addCaisseNameUrl = Uri.parse(
    "$mainUrl/finances/transactions/caisses-name/insert-new-transaction-caisse");
var finExterieurNameUrl = Uri.parse("$mainUrl/finances/transactions/fin-exterieur-name/");
var addFinExterieurNameUrl = Uri.parse(
    "$mainUrl/finances/transactions/fin-exterieur-name/insert-new-transaction-fin-exterieur");


var banqueUrl = Uri.parse("$mainUrl/finances/transactions/banques/");
var addBanqueUrl = Uri.parse(
    "$mainUrl/finances/transactions/banques/insert-new-transaction-banque");
var banqueChartUrl =
    Uri.parse("$mainUrl/finances/transactions/banques/chart/");
 
var banqueRetraitYeartUrl =
    Uri.parse("$mainUrl/finances/transactions/banques/chart-year-retrait/");
var coupureBilletUrl = Uri.parse("$mainUrl/finances/coupure-billets/");
var addCoupureBilleUrl =
    Uri.parse("$mainUrl/finances/coupure-billets/insert-new-coupure-billet");

var caisseUrl = Uri.parse("$mainUrl/finances/transactions/caisses/");
var addCaisseUrl = Uri.parse(
    "$mainUrl/finances/transactions/caisses/insert-new-transaction-caisse");
var caisseChartUrl = Uri.parse("$mainUrl/finances/transactions/caisses/chart/"); 

var creancesUrl = Uri.parse("$mainUrl/finances/transactions/creances/");
var addCreancesUrl = Uri.parse(
    "$mainUrl/finances/transactions/creances/insert-new-transaction-creance");

var dettesUrl = Uri.parse("$mainUrl/finances/transactions/dettes/");
var adddettesUrl = Uri.parse(
    "$mainUrl/finances/transactions/dettes/insert-new-transaction-dette");

var finExterieurUrl =
    Uri.parse("$mainUrl/finances/transactions/financements-exterieur/");
var addfinExterieurUrl = Uri.parse(
    "$mainUrl/finances/transactions/financements-exterieur/insert-new-transaction-finExterieur");
var finExterieurChartUrl = Uri.parse("$mainUrl/finances/transactions/financements-exterieur/chart/");

var creacneDetteUrl = Uri.parse("$mainUrl/finances/creance-dettes/");
var creacneDetteAddUrl =
    Uri.parse("$mainUrl/finances/creance-dettes/insert-new-creance-dette");

var depensesMonthUrl = Uri.parse("$mainUrl/finances/depenses/chart-pie-dep-mounth/");
var depensesYearUrl = Uri.parse("$mainUrl/finances/depenses/chart-pie-dep-year/");

// Comptabilité
var bilansUrl = Uri.parse("$mainUrl/comptabilite/bilans/");
var addbilansUrl = Uri.parse("$mainUrl/comptabilite/bilans/insert-new-bilan");

var compteBilanRefUrl = Uri.parse("$mainUrl/comptabilite/comptes-bilans-ref/");
var addCompteBilanRefUrl =
    Uri.parse("$mainUrl/comptabilite/comptes-bilans-ref/insert-new-compte-bilan-ref"); 
 
var journalsUrl = Uri.parse("$mainUrl/comptabilite/journals/");
var addjournalsUrl =
    Uri.parse("$mainUrl/comptabilite/journals/insert-new-journal");
// var journalsChartMounthUrl =
//     Uri.parse("$mainUrl/comptabilite/journals/journal-chart-month/");
// var journalsChartYearUrl =
//     Uri.parse("$mainUrl/comptabilite/journals/journal-chart-year/");

var comptesResultatUrl = Uri.parse("$mainUrl/comptabilite/comptes_resultat/");
var addComptesResultatUrl = Uri.parse(
    "$mainUrl/comptabilite/comptes_resultat/insert-new-compte-resultat");


var balanceCompteUrl = Uri.parse("$mainUrl/comptabilite/balances/");
var balanceSumUrl = Uri.parse("$mainUrl/comptabilite/balances/balance-sum/");
var balanceChartUrl = Uri.parse("$mainUrl/comptabilite/balances/balance-chart/");
var balanceChartPieUrl =
    Uri.parse("$mainUrl/comptabilite/balances/balance-chart-pie/");
var addBalanceUrl = Uri.parse("$mainUrl/comptabilite/balances/insert-new-balance");

// DEVIS
var devisUrl = Uri.parse("$mainUrl/devis/");
var addDevissUrl = Uri.parse("$mainUrl/devis/insert-new-devis"); 

var devisListObjetUrl = Uri.parse("$mainUrl/devis-list-objets/");
var adddevisListObjetUrl =
    Uri.parse("$mainUrl/devis-list-objets/insert-new-devis-list-objet");

// Budget
var budgetDepartementsUrl = Uri.parse("$mainUrl/budgets/departements/");
var addBudgetDepartementsUrl =
    Uri.parse("$mainUrl/budgets/departements/insert-new-departement-budget");

var ligneBudgetairesUrl = Uri.parse("$mainUrl/budgets/ligne-budgetaires/");
var addbudgetLigneBudgetairesUrl =
    Uri.parse("$mainUrl/budgets/ligne-budgetaires/insert-new-ligne-budgetaire");

// Logistiques
var materielsUrl = Uri.parse("$mainUrl/materiels/");
var aaddMaterielsUrl = Uri.parse("$mainUrl/materiels/insert-new-materiel");
var materielsChartPieUrl = Uri.parse("$mainUrl/materiels/chart-pie-genre/");

var carburantsUrl = Uri.parse("$mainUrl/carburants/");
var addCarburantsUrl = Uri.parse("$mainUrl/carburants/insert-new-carburant");

var entretiensUrl = Uri.parse("$mainUrl/entretiens/");
var addEntretiensUrl = Uri.parse("$mainUrl/entretiens/insert-new-entretien");

var etatMaterielUrl = Uri.parse("$mainUrl/etat_materiels/");
var addEtatMaterielUrl =
    Uri.parse("$mainUrl/etat_materiels/insert-new-etat-materiel");
var etatMaterieChartPielUrl =
    Uri.parse("$mainUrl/etat_materiels/chart-pie-statut/");

var immobiliersUrl = Uri.parse("$mainUrl/immobiliers/");
var addImmobiliersUrl = Uri.parse("$mainUrl/immobiliers/insert-new-immobilier");

var mobiliersUrl = Uri.parse("$mainUrl/mobiliers/");
var addMobiliersUrl = Uri.parse("$mainUrl/mobiliers/insert-new-mobilier");

var trajetsUrl = Uri.parse("$mainUrl/trajets/");
var addTrajetssUrl = Uri.parse("$mainUrl/trajets/insert-new-trajet");

var objetsRemplaceUrl = Uri.parse("$mainUrl/objets-remplaces/");
var addobjetsRemplaceUrl =
    Uri.parse("$mainUrl/objets-remplaces/insert-new-objet-remplace");

var approvisionnementsUrl = Uri.parse("$mainUrl/approvisionnements/");
var addapprovisionnementsUrl =
    Uri.parse("$mainUrl/approvisionnements/insert-new-approvisionnement");

var approvisionReceptionsUrl = Uri.parse("$mainUrl/approvision-receptions/");
var addApprovisionReceptionsUrl =
    Uri.parse("$mainUrl/approvision-receptions/insert-new-approvision-reception");





// Exploitations
var projetsUrl = Uri.parse("$mainUrl/projets/");
var projetChartPieUrl = Uri.parse("$mainUrl/projets/chart-pie/");
var addProjetssUrl = Uri.parse("$mainUrl/projets/insert-new-projet");
var sectionProjetsUrl = Uri.parse("$mainUrl/section-projets/");
var addSectionProjetssUrl = Uri.parse("$mainUrl/section-projets/insert-new-section-projet");

var tachesUrl = Uri.parse("$mainUrl/taches/");
var addTachessUrl = Uri.parse("$mainUrl/taches/insert-new-tache");

var versementProjetsUrl = Uri.parse("$mainUrl/versements-projets/");
var addVersementProjetsUrl =
    Uri.parse("$mainUrl/versements-projets/insert-new-versement-projet");

var rapporsUrl = Uri.parse("$mainUrl/rapports/");
var addRapportsUrl = Uri.parse("$mainUrl/rapports/insert-new-rapport");

var agentsRolesUrl = Uri.parse("$mainUrl/agents-roles/");
var addagentsRolesUrl =
    Uri.parse("$mainUrl/agents-roles/insert-new-agent-role");

var productionUrl = Uri.parse("$mainUrl/productions/");
var productionChartUrl = Uri.parse("$mainUrl/productions/chart/");
var addProductionUrl =
    Uri.parse("$mainUrl/productions/insert-new-production");

var fournisseursUrl = Uri.parse("$mainUrl/fournisseurs/");
var addFournisseursUrl =
    Uri.parse("$mainUrl/fournisseurs/insert-new-fournisseur");

// COMMERCIAL
var prodModelsUrl = Uri.parse("$mainUrl/produit-models/");
var addProdModelsUrl =
    Uri.parse("$mainUrl/produit-models/insert-new-produit-model");

var stockGlobalUrl = Uri.parse("$mainUrl/stocks-global/");
var addStockGlobalUrl =
    Uri.parse("$mainUrl/stocks-global/insert-new-stocks-global");

var succursalesUrl = Uri.parse("$mainUrl/succursales/");
var addSuccursalesUrl = Uri.parse("$mainUrl/succursales/insert-new-succursale");

var bonLivraisonsUrl = Uri.parse("$mainUrl/bon-livraisons/");
var addBonLivraisonsUrl =
    Uri.parse("$mainUrl/bon-livraisons/insert-new-bon-livraison");

var achatsUrl = Uri.parse("$mainUrl/achats/");
var addAchatsUrl = Uri.parse("$mainUrl/achats/insert-new-achat");

// var cartsUrl = Uri.parse("$mainUrl/carts/");
var addCartsUrl = Uri.parse("$mainUrl/carts/insert-new-cart");

var facturesUrl = Uri.parse("$mainUrl/factures/");
var addFacturesUrl = Uri.parse("$mainUrl/factures/insert-new-facture");

var factureCreancesUrl = Uri.parse("$mainUrl/facture-creances/");
var addFactureCreancesUrl =
    Uri.parse("$mainUrl/facture-creances/insert-new-facture-creance");

var ventesUrl = Uri.parse("$mainUrl/ventes/");
var addVentesUrl = Uri.parse("$mainUrl/ventes/insert-new-vente");

// Chart Commercial
var venteChartsUrl = Uri.parse("$mainUrl/ventes/vente-chart/");
var venteChartDayUrl = Uri.parse("$mainUrl/ventes/vente-chart-day/");
var venteChartMonthsUrl = Uri.parse("$mainUrl/ventes/vente-chart-month/");
var venteChartYearsUrl = Uri.parse("$mainUrl/ventes/vente-chart-year/");
var gainChartDayUrl = Uri.parse("$mainUrl/gains/gain-chart-day/");
var gainChartMonthsUrl = Uri.parse("$mainUrl/gains/gain-chart-month/");
var gainChartYearsUrl = Uri.parse("$mainUrl/gains/gain-chart-year/");

var gainsUrl = Uri.parse("$mainUrl/gains/");
var addGainsUrl = Uri.parse("$mainUrl/gains/insert-new-gain");

var restitutionsUrl = Uri.parse("$mainUrl/restitutions/");
var addRestitutionsUrl =
    Uri.parse("$mainUrl/restitutions/insert-new-restitution");

var numberFactsUrl = Uri.parse("$mainUrl/number-facts/");
var addNumberFactsUrl =
    Uri.parse("$mainUrl/number-facts/insert-new-number-fact");

var historyRavitaillementsUrl = Uri.parse("$mainUrl/history-ravitaillements/");
var addHistoryRavitaillementsUrl = Uri.parse(
    "$mainUrl/history-ravitaillements/insert-new-history-ravitaillement");

var historyLivraisonUrl = Uri.parse("$mainUrl/history-livraisons/");
var addHistoryLivraisonUrl =
    Uri.parse("$mainUrl/history-livraisons/insert-new-history_livraison");

// Marketing
var agendasUrl = Uri.parse("$mainUrl/agendas/");
var addAgendasUrl = Uri.parse("$mainUrl/agendas/insert-new-agenda");

var annuairesUrl = Uri.parse("$mainUrl/annuaires/");
var addAnnuairesUrl = Uri.parse("$mainUrl/annuaires/insert-new-annuaire");
var annuairesPieUrl = Uri.parse("$mainUrl/annuaires/chart/");

var campaignsUrl = Uri.parse("$mainUrl/campaigns/");
var addCampaignsUrl = Uri.parse("$mainUrl/campaigns/insert-new-campaign");

// ARCHIVES
var archvesUrl = Uri.parse("$mainUrl/archives/");
var addArchvesUrl = Uri.parse("$mainUrl/archives/insert-new-archive");

var archveFoldersUrl = Uri.parse("$mainUrl/archives-folders/");
var addArchveFolderUrl =
    Uri.parse("$mainUrl/archives-folders/insert-new-archive-folder");

// MAILS
var mailsUrl = Uri.parse("$mainUrl/mails/");
var addMailUrl = Uri.parse("$mainUrl/mails/insert-new-mail");

// Update Software
var updateVerionUrl = Uri.parse("$mainUrl/update-versions/");
var addUpdateVerionrUrl =
    Uri.parse("$mainUrl/update-versions/insert-new-update-verion");

 
// Suivis & controlles
var abonnementClientUrl = Uri.parse("$mainUrl/abonnement-clients/");
var addAbonnementClientUrl =
    Uri.parse("$mainUrl/abonnement-clients/insert-new-abonnement-client");

var entrepriseInfoUrl = Uri.parse("$mainUrl/entreprise-infos/");
var addEntrepriseInfoUrl =
    Uri.parse("$mainUrl/entreprise-infos/insert-new-entreprise-info");

var suivisUrl = Uri.parse("$mainUrl/suivis/");
var addSuivisUrl =
    Uri.parse("$mainUrl/suivis/insert-new-suivi");
 

// Settings
var monnaieUrl = Uri.parse("$mainUrl/settings/monnaies/");
var addMonnaieUrl = Uri.parse("$mainUrl/settings/monnaies/insert-new-monnaie");
