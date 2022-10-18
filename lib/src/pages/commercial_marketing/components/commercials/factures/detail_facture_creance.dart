import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/creance_cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/facture_cart_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/cart/table_creance_cart.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/pdf/creance_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailFactureCreance extends StatefulWidget {
  const DetailFactureCreance({super.key, required this.creanceCartModel});
  final CreanceCartModel creanceCartModel;

  @override
  State<DetailFactureCreance> createState() => _DetailFactureCreanceState();
}

class _DetailFactureCreanceState extends State<DetailFactureCreance> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";

  @override
  Widget build(BuildContext context) {
    final FactureCreanceController controller = Get.put(FactureCreanceController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.creanceCartModel.client),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Ajouter une personne"),
                tooltip: "Ajout personne à la liste",
                icon: const Icon(Icons.person_add),
                onPressed: () {},
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
                                          title:
                                              'Facture n° ${widget.creanceCartModel.client}'),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              PrintWidget(
                                                  tooltip:
                                                      'Imprimer le document',
                                                  onPressed: () async {
                                                    final pdfFile =
                                                        await CreanceCartPDF
                                                            .generate(
                                                                widget
                                                                    .creanceCartModel,
                                                                "\$");
                                                    PdfApi.openFile(
                                                        pdfFile);
                                                  })
                                            ],
                                          ),
                                          SelectableText(
                                              DateFormat("dd-MM-yy HH:mm")
                                                  .format(widget
                                                      .creanceCartModel
                                                      .created),
                                              textAlign: TextAlign.start),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: mainColor,
                                  ),
                                  dataWidget(),
                                  Divider(
                                    color: mainColor,
                                  ),
                                  TableCreanceCart(
                                      factureList: jsonDecode(widget
                                          .creanceCartModel
                                          .cart) as List),
                                  const SizedBox(height: p20),
                                  totalCart()
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: SelectableText(widget.creanceCartModel.signature,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget totalCart() {
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >= 1100) {
      width = MediaQuery.of(context).size.width / 2;
    } else if (MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 650) {
      width = MediaQuery.of(context).size.width / 1.3;
    } else if (MediaQuery.of(context).size.width < 650) {
      width = MediaQuery.of(context).size.width / 1.2;
    }

    List<dynamic> cartItem;
    // cartItem = facture!.cart.toList();
    cartItem = jsonDecode(widget.creanceCartModel.cart) as List;

    List<CartModel> cartItemList = [];

    for (var element in cartItem) {
      cartItemList.add(CartModel.fromJson(element));
    }

    double sumCart = 0;
    for (var data in cartItemList) {
      var qtyRemise = double.parse(data.qtyRemise);
      var quantity = double.parse(data.quantityCart);
      if (quantity >= qtyRemise) {
        sumCart += double.parse(data.remise) * double.parse(data.quantityCart);
      } else {
        sumCart +=
            double.parse(data.priceCart) * double.parse(data.quantityCart);
      }
    }
    return Card(
      elevation: 5,
      color: mainColor.withOpacity(.5),
      child: Container(
        width: width,
        margin: const EdgeInsets.all(p20),
        child: Text(
          'Total: ${NumberFormat.decimalPattern('fr').format(sumCart)} \$',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
