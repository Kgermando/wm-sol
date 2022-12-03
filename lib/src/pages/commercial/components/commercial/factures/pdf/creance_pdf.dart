import 'dart:convert';
import 'dart:io';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/creance_cart_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// Ce format n'est pas utiliser
class CreancePDF {
  static Future<File> generate(
      CreanceCartModel creanceCartModel, String monnaie) async {
    final pdf = Document();

    final user = await AuthApi().getUserId();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(creanceCartModel, user),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(creanceCartModel),
        buildInvoice(creanceCartModel, monnaie),
        Divider(),
        buildTotal(creanceCartModel, monnaie),
      ],
      footer: (context) => buildFooter(user),
    ));
    return PdfApi.saveDocument(name: 'creance', pdf: pdf);
  }

  static Widget buildHeader(
          CreanceCartModel creanceCartModel, UserModel user) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(user),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: InfoSystem().nameClient(),
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(user),
              buildInvoiceInfo(creanceCartModel, user),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(UserModel user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.succursale.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold)), 
        ],
      );

  static Widget buildInvoiceInfo(
      CreanceCartModel creanceCartModel, UserModel user) {
    final titles = <String>[
      'RCCM:',
      'N° Impôt:',
      'ID Nat.:',
      'Facture numero:',
      'Date:',
    ];
    final data = <String>[
      InfoSystem().rccm(),
      InfoSystem().nImpot(),
      InfoSystem().iDNat(),
      creanceCartModel.client,
      DateFormat("dd/MM/yy HH:mm").format(creanceCartModel.created),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(UserModel user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(InfoSystem().nameClient(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(InfoSystem().nameAdress()),
        ],
      );

  static Widget buildTitle(CreanceCartModel creanceCartModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facture créance'.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(CreanceCartModel creanceCartModel, monnaie) {
    final headers = ['Quantité', 'Designation', 'PVU', 'TVA', 'Montant'];

    final jsonList = jsonDecode(creanceCartModel.cart) as List;
    List<CartModel> cartItemList = [];

    for (var element in jsonList) {
      cartItemList.add(CartModel.fromJson(element));
    }

    final data = cartItemList.map((item) {
      double priceTotal = 0;

      var qtyRemise = double.parse(item.qtyRemise);
      var quantity = double.parse(item.quantityCart);

      if (quantity >= qtyRemise) {
        priceTotal +=
            double.parse(item.remise) * double.parse(item.quantityCart);
      } else {
        priceTotal +=
            double.parse(item.priceCart) * double.parse(item.quantityCart);
      }

      return [
        '${NumberFormat.decimalPattern('fr').format(double.parse(item.quantityCart))} ${item.unite}',
        item.idProductCart,
        (double.parse(item.quantityCart) >= double.parse(item.qtyRemise))
            ? '${NumberFormat.decimalPattern('fr').format(double.parse(item.remise))} $monnaie'
            : '${NumberFormat.decimalPattern('fr').format(double.parse(item.priceCart))} $monnaie',
        '${item.tva} %',
        '${priceTotal.toStringAsFixed(2)} $monnaie',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellStyle: const TextStyle(fontSize: 8),
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerLeft,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(CreanceCartModel creanceCartModel, monnaie) {
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var tva;
    double sumCart = 0;
    final jsonList = jsonDecode(creanceCartModel.cart) as List;

    List<CartModel> cartItemList = [];

    for (var element in jsonList) {
      cartItemList.add(CartModel.fromJson(element));
    }

    for (var item in jsonList) {
      // TVA
      tva = double.parse(item.tva);

      var qtyRemise = double.parse(item.qtyRemise);
      var quantity = double.parse(item.quantityCart);

      if (quantity >= qtyRemise) {
        sumCart += double.parse(item.remise) * double.parse(item.quantityCart);
      } else {
        sumCart +=
            double.parse(item.priceCart) * double.parse(item.quantityCart);
      }
    }
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildText(
                //   title: 'TVA',
                //   value: '$tva %',
                //   unite: true,
                // ),
                Divider(),
                buildText(
                  title: 'Total ($monnaie)',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: sumCart.toStringAsFixed(2),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(UserModel user) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Address', value: invoice.supplier.address),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
         pw.Text('Les marchandises vendues ne sont ni reprises ni echangées.',
              style: const TextStyle(fontSize: 10))
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
