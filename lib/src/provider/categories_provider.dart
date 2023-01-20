import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maslindapp/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:maslindapp/src/api/environment.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class CategoriesProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/categories';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<ResponseApi> create(Category category) async{
    try
    {
      Uri url = Uri.http(_url,'$_api/create');
      String bodyParams = json.encode(category);
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