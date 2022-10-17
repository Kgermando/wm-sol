// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';  
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/finances/banque_name_model.dart';

class BanqueNameApi extends GetConnect {
  var client = http.Client();
  Future<List<BanqueNameModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(banqueNameUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BanqueNameModel> data = [];
      for (var u in bodyList) {
        data.add(BanqueNameModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<BanqueNameModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/finances/transactions/banques-name/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return BanqueNameModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<BanqueNameModel> insertData(BanqueNameModel name) async {
    Map<String, String> header = headers;

    var data = name.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addBanqueNameUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return BanqueNameModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(name);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<BanqueNameModel> updateData(BanqueNameModel name) async {
    Map<String, String> header = headers;

    var data = name.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques-name/update-transaction-banque/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return BanqueNameModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques-name/delete-transaction-banque/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
 
}
