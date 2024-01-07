abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class PasswordVisibilityState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}