import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clothing_store/model/getProductById.dart' as GetProductByIdModel;
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getOptionValueById.dart' as GetOptionValueByIdModel;
import 'package:clothing_store/model/cart/getCart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/pages/cart/cart_page.dart';

import '../../provider/app_localizations.dart';
import 'color_widget.dart';
import 'list_size_widget.dart';


String linkImage = '';
int indexThumbnail = 0;

int idColor = -1, idSize = -1;

int userId = 0;
int cartId = 0;
int idProductViant = 0;

Future<List<String>> fetchThumbnails(int idProduct) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/OptionValue/GetOptionValueByProductId?id=$idProduct';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final getOptionValueById = GetOptionValueByIdModel.GetOptionValueById.fromJson(json.decode(response.body));
    if (getOptionValueById.result != null && getOptionValueById.result!.isNotEmpty) {
      return getOptionValueById.result!.map((result) => result.thumbnail ?? '').toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load option values');
  }
}
Color hexColor(String code) {
  return Color(int.parse(code, radix: 16) + 0xFF000000);
}
