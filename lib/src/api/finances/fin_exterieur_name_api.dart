// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';  
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/finances/fin_exterieur_name_model.dart'; 

class FinExterieurNameApi extends GetConnect {
  var client = http.Client();
  Future<List<FinExterieurNameModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(finExterieurNameUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<FinExterieurNameModel> data = [];
      for (var u in bodyList) {
        data.add(FinExterieurNameModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<FinExterieurNameModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/finances/transactions/fin-exterieur-name/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return FinExterieurNameModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<FinExterieurNameModel> insertData(FinExterieurNameModel name) async {
    Map<String, String> header = headers;

    var data = name.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addFinExterieurNameUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return FinExterieurNameModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(name);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<FinExterieurNameModel> updateData(FinExterieurNameModel name) async {
    Map<String, String> header = headers;

    var data = name.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/finances/transactions/fin-exterieur-name/update-transaction-banque/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return FinExterieurNameModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/finances/transactions/fin-exterieur-name/delete-transaction-banque/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
 
}
