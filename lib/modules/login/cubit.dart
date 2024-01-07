import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibility()
  {

    isPasswordVisible = !isPasswordVisible;

    emit(PasswordVisibilityState());
  }

  void userLogin({required String email, required String password})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}