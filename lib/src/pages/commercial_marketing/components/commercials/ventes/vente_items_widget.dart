import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/achat_model.dart'; 
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/cart/cart_controller.dart';
import 'package:wm_solution/src/utils/regex.dart';
import 'package:intl/intl.dart';

class VenteItemWidget extends StatefulWidget {
  const VenteItemWidget(
      {Key? key,
      required this.controller,
      required this.achat,
      required this.profilController, required this.cartController})
      : super(key: key);
  final AchatController controller;
  final AchatModel achat;
  final ProfilController profilController;
  final CartController cartController;

  @override
  State<VenteItemWidget> createState() => _VenteItemWidgetState();
}

class _VenteItemWidgetState extends State<VenteItemWidget> {
  TextEditingController controllerQuantityCart = TextEditingController();

  // Après ajout au panier le produit quite la liste
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Visibility(
      visible: isActive,
      child: Responsive.isDesktop(context)
          ? Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.shopping_basket_sharp,
                        color: Colors.green.shade700, size: 40.0),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width / 2,
                            child: Text(
                              widget.achat.idProduct,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 2,
                            child: Text(
                              'Stock: ${NumberFormat.decimalPattern('fr').format(double.parse(widget.achat.quantity))} ${widget.achat.unite} / ${NumberFormat.decimalPattern('fr').format(double.parse(widget.achat.prixVenteUnit))} \$',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.green.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Form(
                          key: widget.controller.formKey,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: qtyField()),
                              Expanded(child: onChanged())
                            ],
                          ),
                        ))
                  ],
                ),
              ))
          : Card(
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.shopping_basket_sharp,
                      color: Colors.green.shade700, size: 40.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: AutoSizeText(
                                widget.achat.idProduct,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                'Stock: ${NumberFormat.decimalPattern('fr').format(double.parse(widget.achat.quantity))} ${widget.achat.unite} / ${NumberFormat.decimalPattern('fr').format(double.parse(widget.achat.prixVenteUnit))} \$',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                    color: Colors.green.shade700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Form(
                        key: widget.controller.formKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(child: qtyField()),
                            Expanded(child: onChanged())
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  Widget qtyField() {
    return SizedBox(
      width: Responsive.isDesktop(context) ? 100 : 50,
      height: 40,
      child: TextFormField(
        style: Responsive.isDesktop(context)
            ? const TextStyle(
                fontSize: 16,
              )
            : const TextStyle(
                fontSize: 12,
              ),
        controller: controllerQuantityCart,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: const InputDecoration(
          hintText: 'Qtés...',
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Check Qtés';
          } else if (RegExpIsValide().isValideVente.hasMatch(value!)) {
            return 'chiffres obligatoire';
          } else if (double.parse(value) >
              double.parse(widget.achat.quantity)) {
            return 'Qtés insuffisantes';
          } else {
            return null;
          }
        },
        onSaved: (value) => controllerQuantityCart.text,
      ),
    );
  }

  Widget onChanged() {
    return IconButton(
        tooltip: 'Ajoutez au panier',
        iconSize: Responsive.isDesktop(context) ? 24.0 : 18.0,
        onPressed: () {
          if (widget.controller.formKey.currentState!.validate()) {
           widget.cartController.addCart(widget.achat);
            setState(() {
              isActive = !isActive;
            });
          }
        },
        icon:
            Icon(Icons.add_shopping_cart_sharp, color: Colors.green.shade700));
  }
}
