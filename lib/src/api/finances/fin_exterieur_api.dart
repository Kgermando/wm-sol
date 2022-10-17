// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_model.dart';
import 'package:http/http.dart' as http;

class FinExterieurApi extends GetConnect {
  var client = http.Client();

  Future<List<FinanceExterieurModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(finExterieurUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<FinanceExterieurModel> data = [];
      for (var u in bodyList) {
        data.add(FinanceExterieurModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<FinanceExterieurModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl =
        Uri.parse("$mainUrl/finances/transactions/financements-exterieur/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return FinanceExterieurModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<FinanceExterieurModel> insertData(
      FinanceExterieurModel financeExterieurModel) async {
    Map<String, String> header = headers;

    var data = financeExterieurModel.toJson();
    var body = jsonEncode(data);

    var resp =
        await client.post(addfinExterieurUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return FinanceExterieurModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(financeExterieurModel);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<FinanceExterieurModel> updateData(FinanceExterieurModel financeExterieurModel) async {
    Map<String, String> header = headers;

    var data = financeExterieurModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques/update-transaction-finExterieur/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return FinanceExterieurModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques/delete-transaction-finExterieur/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
