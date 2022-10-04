// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/comptabilites/compte_resultat_model.dart';
import 'package:http/http.dart' as http;

class CompteResultatApi extends GetConnect {
  var client = http.Client();

  Future<List<CompteResulatsModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(comptesResultatUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CompteResulatsModel> data = [];
      for (var u in bodyList) {
        data.add(CompteResulatsModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<CompteResulatsModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/comptabilite/comptes_resultat/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return CompteResulatsModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CompteResulatsModel> insertData(
      CompteResulatsModel compteResulatsModel) async {
    Map<String, String> header = headers;

    var data = compteResulatsModel.toJson();
    var body = jsonEncode(data);

    var resp =
        await client.post(addComptesResultatUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return CompteResulatsModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(compteResulatsModel);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CompteResulatsModel> updateData(
      CompteResulatsModel compteResulatsModel) async {
    Map<String, String> header = headers;

    var data = compteResulatsModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/comptabilite/comptes_resultat/update-compte-resultat/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return CompteResulatsModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/comptabilite/comptes_resultat/delete-compte-resultat/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
