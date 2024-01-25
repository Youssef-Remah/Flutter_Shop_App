import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
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

  List<Widget> bottomNavScreens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  Map<int, bool> favorites = {};

  void changeBottomNavIndex(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel;

  bool isHomeDataReceived = false;

  void getHomeData()
  {

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {

      homeModel = HomeModel.fromJson(value.data);

      isHomeDataReceived = true;

      homeModel.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      //print(favorites.toString());
      //print(homeModel.data!.banners[0].image);

      emit(ShopSuccessHomeDataState());
    }).catchError((error){

      print('inside get home data');
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  late CategoriesModel categoriesModel;

  bool isCategoriesDataReceived = false;

  void getCategories()
  {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);

      isCategoriesDataReceived = true;

      emit(ShopSuccessCategoriesState());

    }).catchError((error){

      print('inside get categories');
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
        token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);

      if(!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId]!;
      }
      else
      {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }


  late FavoritesModel favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES, token: token).then((value)
    {

      favoritesModel = FavoritesModel.fromJson(value.data);


      emit(ShopSuccessGetFavoritesState());

    }).catchError((error)
    {
      print('inside get Favorites');
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  late ShopLoginModel userModel;

  bool isUserDataReceived = false;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value)
    {

      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data!.name);

      emit(ShopSuccessUserDataState());

      isUserDataReceived = true;

    }).catchError((error)
    {
      print('inside get user data');
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {

      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data!.name);

      emit(ShopSuccessUpdateUserState(userModel));

      isUserDataReceived = true;

    }).catchError((error)
    {
      print('inside get user data');
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}