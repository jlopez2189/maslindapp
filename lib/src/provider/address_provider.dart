import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maslindapp/src/models/address.dart';
import 'package:flutter/material.dart';
import 'package:maslindapp/src/api/environment.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class AddressProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/address';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  // Future<List<Category>> getAll() async {
  //   try
  //   {
  //     Uri url = Uri.http(_url,'$_api/getAll');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Authorization': sessionUser.sessionToken
  //     };
  //     final res =  await http.get(url, headers: headers);
  //     if (res.statusCode == 401) {
  //       Fluttertoast.showToast(msg: 'Sesion experida');
  //       new SharedPref().logout(context,sessionUser.id);
  //     }
  //     final data = json.decode(res.body);
  //     Category category = Category.fromJsonList(data);
  //     return category.toList;
  //
  //   }
  //   catch(e)
  //   {
  //     print('Error: $e');
  //     return [];
  //   }
  // }

  Future<ResponseApi> create(Address address) async{
    try
    {
      Uri url = Uri.http(_url,'$_api/create');
      String bodyParams = json.encode(address);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res =  await http.post(url, headers: headers, body: bodyParams);
      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion experida');
        new SharedPref().logout(context,sessionUser.id);
      }
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e)
    {
      print('Error: $e');
      return null;
    }

  }
}