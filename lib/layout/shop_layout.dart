import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({super.key});

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salla', style: TextStyle(color: Colors.black),),
      ),

      body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                CacheHelper.removeData(key: 'token').then((value){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute (builder: (BuildContext context) => const ShopLoginScreen()),
                          (route) => false
                  );
                });
              },
              child: Text('Sign Out'),
            ),
          )
      ),
    );
  }

}
