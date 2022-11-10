// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';
import 'package:http/http.dart' as http;

class AdminDepartementNotifyApi extends GetConnect {
  var client = http.Client();

  var budgetUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-budget/");
  var commUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-comm/");
  var marketingUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-marketing/");
  var comptabiliteUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-comptabilite/");
  var exploitationUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-exploitation/");
  var financeUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-finance/");
  var logistiqueUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-logistique/");
  var rhUrl =
      Uri.parse("$adminDepartementNotifyUrl/get-count-admin-departement-rh/");
  var devisUrl = Uri.parse(
      "$adminDepartementNotifyUrl/get-count-admin-departement-devis/");

  Future<NotifySumModel> getCountBudget() async {
    Map<String, String> header = headers;

    var resp = await client.get(budgetUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountCom() async {
    Map<String, String> header = headers;

    var resp = await client.get(commUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountMarketing() async {
    Map<String, String> header = headers;

    var resp = await client.get(marketingUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountComptabilite() async {
    Map<String, String> header = headers;

    var resp = await client.get(comptabiliteUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountFinance() async {
    Map<String, String> header = headers;

    var resp = await client.get(financeUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountExploitation() async {
    Map<String, String> header = headers;

    var resp = await client.get(exploitationUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountLogistique() async {
    Map<String, String> header = headers;

    var resp = await client.get(logistiqueUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountRh() async {
    Map<String, String> header = headers;

    var resp = await client.get(rhUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<NotifySumModel> getCountDevis() async {
    Map<String, String> header = headers;

    var resp = await client.get(devisUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }
}
