import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/succursale_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/succursale/approbation_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/succursale/stats_succusale.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailSuccursale extends StatefulWidget {
  const DetailSuccursale({super.key, required this.succursaleModel});
  final SuccursaleModel succursaleModel;

  @override
  State<DetailSuccursale> createState() => _DetailSuccursaleState();
}

class _DetailSuccursaleState extends State<DetailSuccursale> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";

  @override
  Widget build(BuildContext context) {
    final SuccursaleController controller = Get.find();
    final AchatController achatController = Get.find();
    final ProfilController profilController = Get.find();

    int userRole = int.parse(profilController.user.role);

    return Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.succursaleModel.name),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TitleWidget(
                                                title: "Succursale"),
                                            Row(
                                              children: [
                                                IconButton(
                                                    color: Colors.purple,
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          ComRoutes
                                                              .comSuccursaleUpdate,
                                                          arguments: widget
                                                              .succursaleModel);
                                                    },
                                                    icon:
                                                        const Icon(Icons.edit)),
                                                if (userRole <= 2)
                                                  deleteButton(controller),
                                                const SizedBox(width: p10),
                                                SelectableText(
                                                    DateFormat("dd-MM-yy HH:mm")
                                                        .format(widget
                                                            .succursaleModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        headerTitle(achatController),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: p20),
                                StatsSuccursale(
                                    succursaleModel: widget.succursaleModel),
                                const SizedBox(height: p20),
                                ApprobationSuccursale(
                                    data: widget.succursaleModel,
                                    controller: controller,
                                    profilController: profilController)
                              ],
                            ),
                          )))
                ],
              ),
            );
  }

  Widget deleteButton(SuccursaleController controller) {
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
                controller.succursaleApi.deleteData(widget.succursaleModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerTitle(AchatController achatController) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    var dataAchatList = achatController.achatList
        .where((element) => element.succursale == widget.succursaleModel.name)
        .toList();
    // var dataCreanceList = creanceList.where((element) => element.succursale == widget.succursaleModel.name).toList();
    // var dataVenteList = venteList.where((element) => element.succursale == widget.succursaleModel.name).toList();
    // var dataGainList = gainList.where((element) => element.succursale == widget.succursaleModel.name).toList();

    // Achat global
    double sumAchat = 0.0;
    var dataAchat = dataAchatList
        .map((e) => double.parse(e.priceAchatUnit) * double.parse(e.quantity))
        .toList();
    for (var data in dataAchat) {
      sumAchat += data;
    }

    // Revenues
    double sumAchatRevenue = 0.0;
    var dataAchatRevenue = dataAchatList
        .map((e) => double.parse(e.prixVenteUnit) * double.parse(e.quantity))
        .toList();

    for (var data in dataAchatRevenue) {
      sumAchatRevenue += data;
    }

    // Marge beneficaires
    double sumAchatMarge = 0.0;
    var dataAchatMarge = dataAchatList
        .map((e) =>
            (double.parse(e.prixVenteUnit) - double.parse(e.priceAchatUnit)) *
            double.parse(e.quantity))
        .toList();
    for (var data in dataAchatMarge) {
      sumAchatMarge += data;
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ResponsiveChildWidget(
                child1: Text('Nom :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.succursaleModel.name,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(color: mainColor),
            ResponsiveChildWidget(
                child1: Text('Province :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(widget.succursaleModel.province,
                    textAlign: TextAlign.start, style: bodyMedium)),
            Divider(color: mainColor),
            ResponsiveChildWidget(
              child1: Text('Adresse :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.succursaleModel.adresse,
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Divider(color: mainColor),
            ResponsiveChildWidget(
              child1: Text('Investissement :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(sumAchat)} \$",
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(color: Colors.purple)),
            ),
            Divider(color: mainColor),
            ResponsiveChildWidget(
                child1: Text('Revenus attendus :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                child2: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(sumAchatRevenue)} \$",
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.blue))),
            Divider(color: mainColor),
            ResponsiveChildWidget(
              child1: Text('Marge bénéficiaires :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(sumAchatMarge)} \$",
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(color: Colors.green)),
            ),
          ],
        ),
      )),
    );
  }
}
