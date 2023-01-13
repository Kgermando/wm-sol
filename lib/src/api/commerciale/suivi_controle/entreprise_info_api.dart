// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';

class EntrepriseInfoApi extends GetConnect {
  var client = http.Client();

  Future<List<EntrepriseInfoModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(entrepriseInfoUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<EntrepriseInfoModel> data = [];
      for (var u in bodyList) {
        data.add(EntrepriseInfoModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<EntrepriseInfoModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/entreprise-infos/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return EntrepriseInfoModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<EntrepriseInfoModel> insertData(EntrepriseInfoModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addEntrepriseInfoUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return EntrepriseInfoModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(dataItem);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<EntrepriseInfoModel> updateData(EntrepriseInfoModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse("$mainUrl/entreprise-infos/update-entreprise-info/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return EntrepriseInfoModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse("$mainUrl/entreprise-infos/delete-entreprise-info/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(res.statusCode);
    }
  }
}
