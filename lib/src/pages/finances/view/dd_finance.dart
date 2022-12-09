import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/notify/marketing_notify.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart';
import 'package:wm_solution/src/pages/exploitations/controller/notify/notify_exp.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_campaigns_fin.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_creance_dd.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_dette_dd.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_devis_finance.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_projet_fin.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_salaire_finance.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_transport_rest_finance.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/finance_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DDFinance extends StatefulWidget {
  const DDFinance({super.key});

  @override
  State<DDFinance> createState() => _DDFinanceState();
}

class _DDFinanceState extends State<DDFinance> {
  final BanqueNameController banqueNameController = Get.find();
  final CaisseNameController caisseNameController = Get.find();
  final FinExterieurNameController finExterieurNameController = Get.find();
  final ProfilController profilController = Get.find();
  final FinanceNotifyController financeNotifyController = Get.find();
  final RHNotifyController rhNotifyController = Get.find();
  final MarketingNotifyController marketingNotifyController =Get.find();
  final SalaireController salaireController = Get.find();
  final TransportRestController transportRestController = Get.find();
  final DevisNotifyController devisNotifyController = Get.find();
  final DevisController devisController = Get.find();
  final CreanceController creanceController = Get.find();
  final DetteController detteController = Get.find();
  final CampaignController campaignController = Get.find();
  final ProjetController projetController = Get.find();
  final NotifyExpController expController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finance";
  String subTitle = "Direteur de département";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;
  bool isOpen6 = false;
  bool isOpen7 = false;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    int userRole = int.parse(profilController.user.role);
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          floatingActionButton: (userRole <= 2) ? speedialWidget() : Container(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: Colors.purple.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Salaires',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${rhNotifyController.itemCountSalaireFin} dossiers necessitent votre approbation",
                                      style: bodyMedium!
                                          .copyWith(color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen1 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableSalaireFinance(
                                        salaireController: salaireController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.blue.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text(
                                      'Dossier Transports & Restaurations',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${rhNotifyController.itemCountTransRestFin} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen5 = !val;
                                    });
                                  },
                                  trailing: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  children: [
                                    TableTransportRestFinance(
                                        transportRestController:
                                            transportRestController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.green.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Campaigns',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${marketingNotifyController.campaignCountFin} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen2 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableCampaignFin(
                                        campaignController: campaignController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.grey.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Projets',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${expController.itemCountProjetFin} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen4 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableProjetFin(
                                        projetController: projetController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.grey.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Etat de besoins',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${devisNotifyController.itemCountDevisFin} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen3 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableDevisFinance(
                                        devisController: devisController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.red.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Dette',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${financeNotifyController.detteCountDD} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen6 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableDetteDD(
                                        detteController: detteController)
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.orange.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Créances',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6!
                                              .copyWith(color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${financeNotifyController.creanceCountDD} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen7 = !val;
                                    });
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TableCreanceDD(
                                        creanceController: creanceController)
                                  ],
                                ),
                              ),
                            ])),
                  ))
            ],
          )),
    );
  }

  SpeedDial speedialWidget() {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.account_balance),
          foregroundColor: Colors.white,
          backgroundColor: Colors.amberAccent.shade700,
          label: 'Créer une banque',
          onPressed: () {
            banqueDialog();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.savings),
          foregroundColor: Colors.white,
          backgroundColor: Colors.tealAccent.shade700,
          label: 'Créer une caisse',
          onPressed: () {
            caisseDialog();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.account_balance_wallet),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent.shade700,
          label: 'Créer compte pour fin. externes',
          onPressed: () {
            finExterieurDialog();
          },
        ),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  banqueDialog() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(p8),
                ),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  // height: 400,
                  child: Form(
                    key: banqueNameController.formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(p16),
                        child: SizedBox(
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              const TitleWidget(title: "Création d'une Banque"),
                              const SizedBox(
                                height: p20,
                              ),
                              nomCompletBanqueWidget(),
                              Row(
                                children: [
                                  Expanded(child: idNatBanqueWidget()),
                                  const SizedBox(
                                    width: p10,
                                  ),
                                  Expanded(child: rccmBanqueWidget())
                                ],
                              ),
                              addresseBanqueWidget(),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: banqueNameController.isLoading,
                                  press: () {
                                    final form = banqueNameController
                                        .formKey.currentState!;
                                    if (form.validate()) {
                                      banqueNameController.submit();
                                      form.reset();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          });
        });
  }

  caisseDialog() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(p8),
                ),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  // height: 400,
                  child: Form(
                    key: caisseNameController.formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(p16),
                        child: SizedBox(
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              const TitleWidget(title: "Création d'une Caisse"),
                              const SizedBox(
                                height: p20,
                              ),
                              nomCompletCaisseWidget(),
                              Row(
                                children: [
                                  Expanded(child: idNatCaisseWidget()),
                                  const SizedBox(
                                    width: p10,
                                  ),
                                  Expanded(child: rccmCaisseWidget())
                                ],
                              ),
                              addresseCaisseWidget(),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: caisseNameController.isLoading,
                                  press: () {
                                    final form = caisseNameController
                                        .formKey.currentState!;
                                    if (form.validate()) {
                                      caisseNameController.submit();
                                      form.reset();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          });
        });
  }

  finExterieurDialog() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(p8),
                ),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  // height: 400,
                  child: Form(
                    key: finExterieurNameController.formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(p16),
                        child: SizedBox(
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              const TitleWidget(
                                  title:
                                      "Création d'une banque pour Fin. Exterieur"),
                              const SizedBox(
                                height: p20,
                              ),
                              nomCompletFinExterieurWidget(),
                              Row(
                                children: [
                                  Expanded(child: idNatFinExterieurWidget()),
                                  const SizedBox(
                                    width: p10,
                                  ),
                                  Expanded(child: rccmFinExterieurWidget())
                                ],
                              ),
                              addresseFinExterieurWidget(),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading:
                                      finExterieurNameController.isLoading,
                                  press: () {
                                    final form = finExterieurNameController
                                        .formKey.currentState!;
                                    if (form.validate()) {
                                      finExterieurNameController.submit();
                                      form.reset();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          });
        });
  }

  Widget nomCompletBanqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: banqueNameController.nomCompletController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget rccmBanqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: banqueNameController.rccmController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget idNatBanqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: banqueNameController.idNatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Id. Nat.',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget addresseBanqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: banqueNameController.addresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget nomCompletCaisseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: caisseNameController.nomCompletController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget rccmCaisseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: caisseNameController.rccmController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'RCCM',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget idNatCaisseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: caisseNameController.idNatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Id. Nat.',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget addresseCaisseWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: caisseNameController.addresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget nomCompletFinExterieurWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: finExterieurNameController.nomCompletController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget rccmFinExterieurWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: finExterieurNameController.rccmController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'RCCM',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget idNatFinExterieurWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: finExterieurNameController.idNatController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Id. Nat',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }

  Widget addresseFinExterieurWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: finExterieurNameController.addresseController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
          ),
          keyboardType: TextInputType.text,
          // validator: (value) => value != null && value.isEmpty
          //     ? 'Ce champs est obligatoire.'
          //     : null,
          style: const TextStyle(),
        ));
  }
}
