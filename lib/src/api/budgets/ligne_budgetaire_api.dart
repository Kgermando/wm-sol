// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/charts/courbe_budget_model.dart';

class LIgneBudgetaireApi extends GetConnect {
  var client = http.Client();

  Future<List<LigneBudgetaireModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(ligneBudgetairesUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<LigneBudgetaireModel> data = [];
      for (var u in bodyList) {
        data.add(LigneBudgetaireModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  
  Future<List<CourbeBudgetModel>> getAllDataBanqueMouth() async {
    Map<String, String> header = headers;

    var resp = await client.get(ligneBudgetaireBanqueUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CourbeBudgetModel> data = [];
      for (var u in bodyList) {
        data.add(CourbeBudgetModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<List<CourbeBudgetModel>> getAllDataCaisseMouth() async {
    Map<String, String> header = headers;

    var resp = await client.get(ligneBudgetaireCaisseUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CourbeBudgetModel> data = [];
      for (var u in bodyList) {
        data.add(CourbeBudgetModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<List<CourbeBudgetModel>> getAllDataFinExterieurMouth() async {
    Map<String, String> header = headers;

    var resp = await client.get(ligneBudgetaireFinExterieurUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CourbeBudgetModel> data = [];
      for (var u in bodyList) {
        data.add(CourbeBudgetModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<LigneBudgetaireModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/budgets/ligne-budgetaires/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return LigneBudgetaireModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<LigneBudgetaireModel> insertData(
      LigneBudgetaireModel ligneBudgetaireModel) async {
    Map<String, String> header = headers;

    var data = ligneBudgetaireModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addbudgetLigneBudgetairesUrl,
        headers: header, body: body);
    if (resp.statusCode == 200) {
      return LigneBudgetaireModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(ligneBudgetaireModel);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<LigneBudgetaireModel> updateData(
    LigneBudgetaireModel ligneBudgetaireModel) async {
    Map<String, String> header = headers;

    var data = ligneBudgetaireModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/budgets/ligne-budgetaires/update-ligne-budgetaire/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return LigneBudgetaireModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/budgets/ligne-budgetaires/delete-ligne-budgetaire/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
