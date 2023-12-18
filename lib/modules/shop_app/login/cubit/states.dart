

import 'package:shopapp/models/shop_Login/login_model.dart';

abstract class ShopLoginStates{}

class ShopLogininitialState extends ShopLoginStates{}

class ShopLoginLodingState extends ShopLoginStates{}

class ShopLoginSuccesState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccesState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
   final String error;

  ShopLoginErrorState(this.error);

}
class ShopLoginchangepasswordState extends ShopLoginStates{}
