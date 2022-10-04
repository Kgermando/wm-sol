// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/logistiques/carburant_model.dart';
import 'package:http/http.dart' as http;

class CarburantApi extends GetConnect {
  var client = http.Client();
  Future<List<CarburantModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(carburantsUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CarburantModel> data = [];
      for (var u in bodyList) {
        data.add(CarburantModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<CarburantModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/carburants/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return CarburantModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CarburantModel> insertData(CarburantModel carburantModel) async {
    Map<String, String> header = headers;

    var data = carburantModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addCarburantsUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return CarburantModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(carburantModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<CarburantModel> updateData(CarburantModel carburantModel) async {
    Map<String, String> header = headers;

    var data = carburantModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse("$mainUrl/carburants/update-carburant/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return CarburantModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse("$mainUrl/carburants/delete-carburant/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
