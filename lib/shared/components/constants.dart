import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String? token = '';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute (builder: (BuildContext context) => const ShopLoginScreen()),
              (route) => false
      );
    }
  });
}