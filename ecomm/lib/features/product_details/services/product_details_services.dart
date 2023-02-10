import 'dart:convert';

import 'package:ecomm/constants/error_handling.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/models/product.dart';
import 'package:ecomm/models/user.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // porque está usando express
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSucces: () {
            showSnackBar(context, 'Product rated');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // porque está usando express
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSucces: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
