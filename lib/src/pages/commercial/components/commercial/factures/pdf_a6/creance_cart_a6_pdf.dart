// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/creance_cart_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// Local import
// import 'package:wm_solution/src/helpers/save_file_mobile_pdf.dart'
//     if (dart.library.html) 'src/helpers/save_file_web.dart' as helper;

class CreanceCartPDF {
  static Future<File> generate(
      CreanceCartModel factureCartModel, MonnaieStorage monnaieStorage) async {
    final pdf = Document();

    final user = await AuthApi().getUserId();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a6,
      build: (context) => [
        buildInvoiceInfo(factureCartModel, user, monnaieStorage),
        buildTitle(factureCartModel),
        buildInvoice(factureCartModel, monnaieStorage),
        Divider(),
        buildTotal(factureCartModel, monnaieStorage),
      ],
      footer: (context) => buildFooter(user),
    ));
    return PdfApi.saveDocument(name: 'creance', pdf: pdf);
  }


  static Widget buildInvoiceInfo(CreanceCartModel factureCartModel,
      UserModel user, MonnaieStorage monnaieStorage) {
    final titles = <String>[
      'Entreprise:', 
      'N° Facture:',
      'Date:',
      'Monnaie:',
    ];
    final data = <String>[
      InfoSystem().name(), 
      factureCartModel.client,
      DateFormat("dd/MM/yy HH:mm").format(factureCartModel.created),
      monnaieStorage.monney
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


  static Widget buildTitle(CreanceCartModel factureCartModel) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Facture créance'.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ), 
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static Widget buildInvoice(CreanceCartModel creanceCartModel, monnaie) {
    final headers = ['Qté', 'Designation', 'PVU', 'TVA', 'Montant'];

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
      headerStyle: const TextStyle(fontSize: 8),
      cellStyle: const TextStyle(fontSize: 8),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      // cellHeight: 30,
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
    var tva = 0.0;
    double sumCart = 0;
    final jsonList = jsonDecode(creanceCartModel.cart) as List;

    List<CartModel> cartItemList = [];

    for (var element in jsonList) {
      cartItemList.add(CartModel.fromJson(element));
    }

    for (var item in cartItemList) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          buildText(
            title: 'Total ($monnaie)',
            titleStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            value: sumCart.toStringAsFixed(2),
            unite: true,
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
      buildSimpleText(title: 'Address', value: InfoSystem().nameAdress()),
      pw.Text('Merçi.')
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    const style = TextStyle(fontSize: 8);

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
    final style = titleStyle ?? const TextStyle(fontSize: 8);

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
