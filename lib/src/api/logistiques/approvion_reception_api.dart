// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart'; 
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';

class ApprovisionReceptionApi extends GetConnect {
  var client = http.Client();

  Future<List<ApprovisionReceptionModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(approvisionReceptionsUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<ApprovisionReceptionModel> data = [];
      for (var u in bodyList) {
        data.add(ApprovisionReceptionModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<ApprovisionReceptionModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/approvision-receptions/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return ApprovisionReceptionModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<ApprovisionReceptionModel> insertData(ApprovisionReceptionModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addApprovisionReceptionsUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return ApprovisionReceptionModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(dataItem);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<ApprovisionReceptionModel> updateData(ApprovisionReceptionModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse("$mainUrl/approvision-receptions/update-approvision-reception/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return ApprovisionReceptionModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse("$mainUrl/approvision-receptions/delete-approvision-reception/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
 
}
