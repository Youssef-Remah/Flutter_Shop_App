import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool isHomeDataReceived = false;

  List<Widget> bottomNavScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavIndex(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel;

  void getHomeData()
  {

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {

      homeModel = HomeModel.fromJson(value.data);

      isHomeDataReceived = true;

      //print(homeModel.data!.banners[0].image);

      emit(ShopSuccessHomeDataState());
    }).catchError((error){

      print('inside get home data');
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

}