import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  Widget startWidget;

  if(onBoarding != null)
  {
    if(token != null)
    {
      startWidget = ShopLayout();
    }
    else
    {
      startWidget = ShopLoginScreen();
    }
  }
  else
  {
    startWidget = OnBoardingScreen();
  }


  runApp(MyApp(startWidget: startWidget,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createLightTheme(),
      home: startWidget,
    );
  }
}
