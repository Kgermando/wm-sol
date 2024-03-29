import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/cart/cart_item_widget.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/cart/cart_controller.dart'; 
import 'package:wm_solution/src/widgets/loading.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final CartController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Panier";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: (controller.cartList.isNotEmpty)
          ? speedialWidget(controller)
          : Container(),
      body:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child:  controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Le panier est vide.'),
          onError: (error) => loadingError(context, error!),
          (state) => SingleChildScrollView(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.getList();
                                        },
                                        icon: const Icon(Icons.refresh,
                                            color: Colors.green))
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state!.length,
                                    itemBuilder: (context, index) {
                                      final cart = state[index];
                                      return CartItemWidget(
                                          cart: cart, controller: controller);
                                    }),
                                SizedBox(
                                    height: p50, child: totalCart(controller))
                              ],
                            ),
                          ))) )
                ],
              )
      
      
    ,
    );
  }

  Widget totalCart(CartController controller) {
    // Montant a Vendre
    double sumCart = 0.0;

    var dataPriceCart = controller.cartList
        .map((e) => (double.parse(e.quantityCart) >= double.parse(e.qtyRemise))
            ? double.parse(e.remise) * double.parse(e.quantityCart)
            : double.parse(e.priceCart) * double.parse(e.quantityCart))
        .toList();

    for (var data in dataPriceCart) {
      sumCart += data;
    }

    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text(
        'Total: ${NumberFormat.decimalPattern('fr').format(sumCart)} ${monnaieStorage.monney}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700),
      ),
    );
  }

  SpeedDial speedialWidget(CartController controller) {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
            child: const Icon(Icons.inventory_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            label: 'Vente',
            onPressed: () {
              controller.submitFacture();
            }),
        SpeedDialChild(
            child: const Icon(Icons.print),
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal.shade700,
            label: 'Générer facture',
            onPressed: () {
              controller.submitFacture();
              controller.createFacturePDF();
            }),
        SpeedDialChild(
            child: const Icon(Icons.money_off),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange.shade700,
            label: 'Vente à crédit',
            onPressed: () {
              controller.submitFactureCreance();
            }),
        SpeedDialChild(
            child: const Icon(Icons.print),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange.shade700,
            label: 'Générer facture créance',
            onPressed: () {
              controller.submitFactureCreance();
              controller.createPDFCreance();
            }),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }
}
