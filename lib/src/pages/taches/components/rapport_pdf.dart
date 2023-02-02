// import 'dart:io';
// import 'package:wm_solution/src/api/auth/auth_api.dart';
// import 'package:wm_solution/src/helpers/pdf_api.dart';
// import 'package:wm_solution/src/models/taches/rapport_model.dart'; 
// import 'package:wm_solution/src/models/users/user_model.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

// class RapportPDF {
//   static Future<File> generate(
//       RapportModel rapportModel) async {
//     final pdf = Document();

//     final user = await AuthApi().getUserId();

//     pdf.addPage(MultiPage(
//       build: (context) => [   
//         buildRapport(rapportModel), 
//       ],
//       footer: (context) => buildFooter(user),
//     ));
//     return PdfApi.saveDocument(name: 'rapport_${rapportModel.signature}', pdf: pdf);
//   }

//   static Widget buildRapport(RapportModel rapportModel) { 
//     return pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         mainAxisAlignment: pw.MainAxisAlignment.start,
//         children: [
//           buildSimpleText1(
//               title: 'Titre', value: rapportModel.nom),
//           SizedBox(height: 2 * PdfPageFormat.mm), 
//            flutter_quill.QuillEditor.basic(
//             controller: controller.quillControllerRead,
//             readOnly: true,
//             locale: const Locale('fr'),
//           ),
//           SizedBox(height: 3 * PdfPageFormat.mm),
 
//         ]);
//   }

//   static Widget buildFooter(UserModel user) => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Entreprise', value: user.succursale),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'RCCM', value: "1234567821"),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'ID Nat.', value: "87975132152"),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'N° Impôt', value: "568972132"),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//         ],
//       );

//   static buildSimpleText1({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         // SizedBox(width: 4 * PdfPageFormat.mm),
//         pw.Spacer(),
//         Text(value),
//       ],
//     );
//   }

//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
