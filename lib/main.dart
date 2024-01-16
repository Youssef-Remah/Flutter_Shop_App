import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  Widget startWidget;

  if(onBoarding != null)
  {
    if(token != null)
    {
      startWidget = const ShopLayout();
    }
    else
    {
      startWidget = const ShopLoginScreen();
    }
  }
  else
  {
    startWidget = const OnBoardingScreen();
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
    return MultiBlocProvider(

      providers:
      [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: createLightTheme(),
        home: startWidget,
      ),
    );
  }
}
