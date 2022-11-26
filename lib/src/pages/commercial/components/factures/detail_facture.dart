import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/facture_cart_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/factures/cart/table_facture_cart.dart';
import 'package:wm_solution/src/pages/commercial/components/factures/pdf/facture_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailFacture extends StatefulWidget {
  const DetailFacture({super.key, required this.factureCartModel});
  final FactureCartModel factureCartModel;

  @override
  State<DetailFacture> createState() => _DetailFactureState();
}

class _DetailFactureState extends State<DetailFacture> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";

  @override
  Widget build(BuildContext context) {
    final FactureController controller = Get.find();
    return Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.factureCartModel.client),
              drawer: const DrawerMenu(),
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
                                                title:
                                                    'Facture n° ${widget.factureCartModel.client}'),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    PrintWidget(
                                                        tooltip:
                                                            'Imprimer le document',
                                                        onPressed: () async {
                                                          final pdfFile =
                                                              await FactureCartPDF
                                                                  .generate(
                                                                      widget
                                                                          .factureCartModel,
                                                                      "\$");
                                                          PdfApi.openFile(
                                                              pdfFile);
                                                        })
                                                  ],
                                                ),
                                                SelectableText(
                                                    DateFormat("dd-MM-yy HH:mm")
                                                        .format(widget
                                                            .factureCartModel
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
                                        TableFactureCart(
                                            factureList: jsonDecode(widget
                                                .factureCartModel
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
              ),) 
            ); 
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
                child: SelectableText(widget.factureCartModel.signature,
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
    cartItem = jsonDecode(widget.factureCartModel.cart) as List;

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
