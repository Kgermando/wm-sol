import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/comm_maketing/achat_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/achats/achat_pdf.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailAchat extends StatefulWidget {
  const DetailAchat({super.key, required this.achatModel});
  final AchatModel achatModel;

  @override
  State<DetailAchat> createState() => _DetailAchatState();
}

class _DetailAchatState extends State<DetailAchat> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";

  @override
  Widget build(BuildContext context) {
    final AchatController controller = Get.find();
    final ProfilController profilController = Get.find();
    final VenteCartController venteCartController = Get.find();

    var roleAgent = int.parse(profilController.user.role) <= 3;
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.achatModel.idProduct),
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
                                Row(
                                  mainAxisAlignment:
                                      (!Responsive.isMobile(context))
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.end,
                                  children: [
                                    if (!Responsive.isMobile(context))
                                      TitleWidget(
                                          title:
                                      'Succursale: ${widget.achatModel.succursale.toUpperCase()}'),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            reporting(profilController,
                                                venteCartController),
                                            if (roleAgent)
                                              if (double.parse(widget
                                                    .achatModel.quantity) > 0)
                                                transfertProduit()
                                          ],
                                        ),
                                        SelectableText(
                                            DateFormat("dd-MM-yyyy HH:mm")
                                                .format(
                                                    widget.achatModel.created),
                                            textAlign: TextAlign.start),
                                      ],
                                    )
                                  ],
                                ),
                                dataWidget(
                                    profilController, venteCartController),
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget dataWidget(ProfilController profilController,
      VenteCartController venteCartController) {
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          headerTitle(),
          const SizedBox(
            height: 20,
          ),
          achatTitle(),
          achats(profilController),
          const SizedBox(
            height: 20,
          ),
          ventetitle(),
          ventes(venteCartController),
          const SizedBox(
            height: 20,
          ),
          benficesTitle(),
          benfices(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget headerTitle() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SizedBox(
      width: double.infinity,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(widget.achatModel.idProduct,
            style: Responsive.isDesktop(context)
                ? const TextStyle(fontWeight: FontWeight.w600, fontSize: 30)
                : headline6),
      )),
    );
  }

  Widget achatTitle() {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        child: Text(
          'ACHATS',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
    );
  }

  Widget achats(ProfilController profilController) {
    var roleAgent = int.parse(profilController.user.role) <= 3;

    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

    var prixAchatTotal = double.parse(widget.achatModel.priceAchatUnit) *
        double.parse(widget.achatModel.quantityAchat);
    var margeBenifice = double.parse(widget.achatModel.prixVenteUnit) -
        double.parse(widget.achatModel.priceAchatUnit);
    var margeBenificeTotal =
        margeBenifice * double.parse(widget.achatModel.quantityAchat);

    var margeBenificeRemise = double.parse(widget.achatModel.remise) -
        double.parse(widget.achatModel.priceAchatUnit);
    var margeBenificeTotalRemise =
        margeBenificeRemise * double.parse(widget.achatModel.quantityAchat);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Quantités entrant',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Text(
                    '${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(widget.achatModel.qtyLivre).toStringAsFixed(2)))} ${widget.achatModel.unite}',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            if (roleAgent)
              Divider(
                color: mainColor,
              ),
            if (roleAgent)
              Row(
                children: [
                  Text('Prix d\'achats unitaire',
                      style: Responsive.isDesktop(context)
                          ? const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)
                          : bodyText2,
                      overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Text(
                      '${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(widget.achatModel.priceAchatUnit).toStringAsFixed(2)))} ${monnaieStorage.monney}',
                      style: Responsive.isDesktop(context)
                          ? const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)
                          : bodyText2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            if (roleAgent)
              Divider(
                color: mainColor,
              ),
            if (roleAgent)
              Row(
                children: [
                  Text('Prix d\'achats total',
                      style: Responsive.isDesktop(context)
                          ? const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)
                          : bodyText2,
                      overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Text(
                      '${NumberFormat.decimalPattern('fr').format(double.parse(prixAchatTotal.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                      style: Responsive.isDesktop(context)
                          ? const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)
                          : bodyText2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            Divider(
              color: mainColor,
            ),
            Row(
              children: [
                Text('TVA',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Text('${widget.achatModel.tva} %',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Divider(
              color: mainColor,
            ),
            Row(
              children: [
                Text('Prix de vente unitaire',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Text(
                    '${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(widget.achatModel.prixVenteUnit).toStringAsFixed(2)))} ${monnaieStorage.monney}',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Divider(
              color: mainColor,
            ),
            Row(
              children: [
                Text('Prix de Remise',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Text(
                    '${double.parse(widget.achatModel.remise).toStringAsFixed(2)} ${monnaieStorage.monney}',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Divider(
              color: mainColor,
            ),
            Row(
              children: [
                Text('Qtés pour la remise',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Text(
                    '${widget.achatModel.qtyRemise} ${widget.achatModel.unite}',
                    style: Responsive.isDesktop(context)
                        ? const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)
                        : bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            if (roleAgent)
              Divider(
                color: mainColor,
              ),
            if (roleAgent)
              const SizedBox(
                height: 20.0,
              ),
            if (roleAgent)
              Responsive.isDesktop(context)
                  ? Row(
                      children: [
                        Text('Marge bénéficiaire unitaire / Remise',
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.orange)
                                : bodyText2,
                            overflow: TextOverflow.ellipsis),
                        const Spacer(),
                        Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(margeBenifice.toStringAsFixed(2)))} ${monnaieStorage.monney} / ${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeRemise.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.orange)
                                : bodyText2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Marge bénéficiaire unitaire / Remise',
                            textAlign: TextAlign.left,
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.orange)
                                : bodyText2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(margeBenifice.toStringAsFixed(2)))} ${monnaieStorage.monney} / ${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeRemise.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                            textAlign: TextAlign.left,
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.orange)
                                : bodyText2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
            if (roleAgent)
              Divider(
                color: mainColor,
              ),
            if (roleAgent)
              Responsive.isDesktop(context)
                  ? Row(
                      children: [
                        Text('Marge bénéficiaire total / Remise',
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFFE64A19))
                                : bodyText1,
                            overflow: TextOverflow.ellipsis),
                        const Spacer(),
                        Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeTotal.toStringAsFixed(2)))} ${monnaieStorage.monney} / ${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeTotalRemise.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFFE64A19))
                                : bodyText1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Marge bénéficiaire total / Remise',
                            textAlign: TextAlign.left,
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFFE64A19))
                                : bodyText1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeTotal.toStringAsFixed(2)))} ${monnaieStorage.monney} / ${NumberFormat.decimalPattern('fr').format(double.parse(margeBenificeTotalRemise.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                            textAlign: TextAlign.left,
                            style: Responsive.isDesktop(context)
                                ? const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xFFE64A19))
                                : bodyText1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
          ],
        ),
      ),
    );
  }

  Widget ventetitle() {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        child: Text(
          'VENTES',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
    );
  }

  Widget ventes(VenteCartController venteCartController) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

    double qtyVendus = 0;
    double prixTotalVendu = 0;

    var ventesQty = venteCartController.livraisonHistoryVenteCartList
        .where((element) {
          String v1 = element.idProductCart;
          String v2 = widget.achatModel.idProduct;
          int date1 = element.created.millisecondsSinceEpoch;
          int date2 = widget.achatModel.created.millisecondsSinceEpoch;
          return v1 == v2 && date2 >= date1;
        })
        .map((e) => double.parse(e.quantityCart))
        .toList();

    for (var item in ventesQty) {
      qtyVendus += item;
    }

    var ventesPrix = venteCartController.livraisonHistoryVenteCartList
        .where((element) {
          var v1 = element.idProductCart;
          var v2 = widget.achatModel.idProduct;
          var date1 = element.created.millisecondsSinceEpoch;
          var date2 = widget.achatModel.created.millisecondsSinceEpoch;
          return v1 == v2 && date2 >= date1;
        })
        .map((e) => double.parse(e.priceTotalCart))
        .toList();

    for (var item in ventesPrix) {
      prixTotalVendu += item;
    }

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quantités vendus',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)
                      : bodyText2),
              Text('Montant vendus',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)
                      : bodyText2),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${NumberFormat.decimalPattern('fr').format(double.parse(qtyVendus.toStringAsFixed(0)))} ${widget.achatModel.unite}',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText1),
              Text(
                  '${NumberFormat.decimalPattern('fr').format(double.parse(prixTotalVendu.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText1),
            ],
          ),
        ],
      ),
    ));
  }

  Widget benficesTitle() {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        child: Text(
          'EN STOCKS',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
    );
  }

  Widget benfices() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

    var prixTotalRestante = double.parse(widget.achatModel.quantity) *
        double.parse(widget.achatModel.prixVenteUnit);

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Restes des ${widget.achatModel.unite}',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)
                      : bodyText2),
              Text('Revenues',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)
                      : bodyText2),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(widget.achatModel.quantity).toStringAsFixed(0)))} ${widget.achatModel.unite}',
                  style: Responsive.isDesktop(context)
                      ? const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)
                      : bodyText1),
              Text(
                  '${NumberFormat.decimalPattern('fr').format(double.parse(prixTotalRestante.toStringAsFixed(2)))} ${monnaieStorage.monney}',
                  style: Responsive.isDesktop(context)
                      ? TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.green[800])
                      : bodyText1),
            ],
          ),
        ],
      ),
    ));
  }

  Widget transfertProduit() {
    return IconButton(
      color: Colors.red,
      icon: const Icon(Icons.assistant_direction),
      tooltip: 'Restitution de la quantité en stocks',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Restituer de la quantité',
              style: TextStyle(color: mainColor)),
          content: const Text(
              'Cette action permet de restitutuer la quantité dans le stock global.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed(ComRoutes.comRestitutionStock,
                    arguments: widget.achatModel);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget reporting(ProfilController profilController,
      VenteCartController venteCartController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PrintWidget(onPressed: () async {
          await AchatPdf.generate(widget.achatModel, profilController.user,
              venteCartController.livraisonHistoryVenteCartList, monnaieStorage);
        })
      ],
    );
  }
}
