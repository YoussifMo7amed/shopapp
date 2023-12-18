
import 'package:shopapp/models/shop_Login/Login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterinitialState extends ShopRegisterStates{}

class ShopRegisterLodingState extends ShopRegisterStates{}

class ShopRegisterSuccesState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccesState(this.loginModel);

}

class ShopRegisterErrorState extends ShopRegisterStates{
   final String error;

  ShopRegisterErrorState(this.error);

}
class ShopRegisterchangepasswordState extends ShopRegisterStates{}
