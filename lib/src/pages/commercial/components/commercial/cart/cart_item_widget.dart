import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/cart/cart_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({Key? key, required this.cart, required this.controller})
      : super(key: key);
  final CartModel cart;
  final CartController controller;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  
  @override
  Widget build(BuildContext context) {
    // var role = int.parse(user.role) <= 3;
    double sum = 0;
    var qtyRemise = double.parse(widget.cart.qtyRemise);
    var quantity = double.parse(widget.cart.quantityCart);
    if (quantity >= qtyRemise) {
      sum = double.parse(widget.cart.quantityCart) *
          double.parse(widget.cart.remise);
    } else {
      sum = double.parse(widget.cart.quantityCart) *
          double.parse(widget.cart.priceCart);
    }

    return Responsive.isDesktop(context)
        ? Card(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ComRoutes.comCartDetail,
                    arguments: widget.cart);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  size: 30.0,
                ),
                title: Text(widget.cart.idProductCart,
                    style: Theme.of(context).textTheme.bodyText1),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: (double.parse(widget.cart.quantityCart) >=
                              double.parse(widget.cart.qtyRemise))
                          ? Text(
                              '${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.remise))} x ${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.quantityCart))} ${widget.cart.unite}',
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          : Text(
                              '${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.priceCart))} x ${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.quantityCart))} ${widget.cart.unite}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                    ),
                  ],
                ),
                trailing: ConstrainedBox(
                  constraints: const BoxConstraints.expand(width: 200),
                  child: Row(
                    children: [
                      Text(
                          'Total: ${NumberFormat.decimalPattern('fr').format(sum)} ${monnaieStorage.monney}',
                          style: Theme.of(context).textTheme.bodyText1),
                      onCancel(),
                    ],
                  ),
                ),
                dense: true,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            ),
          )
        : Card(
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart,
                    color: Colors.teal, size: 40.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.idProductCart,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    (double.parse(widget.cart.quantityCart) >
                            double.parse(widget.cart.qtyRemise))
                        ? Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.priceCart))} x ${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.quantityCart))} ${widget.cart.unite}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                                color: Colors.teal),
                          )
                        : Text(
                            '${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.priceCart))} x ${NumberFormat.decimalPattern('fr').format(double.parse(widget.cart.quantityCart))} ${widget.cart.unite}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                                color: Colors.teal),
                          ),
                  ],
                ),
                const Spacer(),
                Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            '${NumberFormat.decimalPattern('fr').format(sum)} ${monnaieStorage.monney}',
                            style: Theme.of(context).textTheme.bodyText1),
                        onCancel(),
                      ],
                    ))
              ],
            ),
          );
  }

  Widget onCancel() {
    return Obx(() => widget.controller.isLoadingCancel ? loadingMini() : IconButton(
      tooltip: 'Annuler',
      onPressed: () {
        setState(() {
          widget.controller.updateAchat(widget.cart);
        });
      },
      icon: const Icon(Icons.cancel, color: Colors.red)));
  }
}
