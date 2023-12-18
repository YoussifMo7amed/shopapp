// ignore_for_file: camel_case_types



import 'package:shopapp/models/favorites/favorites_model.dart';

abstract class shopstates{}

class shopinitialstate extends shopstates{}

class ChangeShopButtomnavbarState extends shopstates{}

class ShopLoadingState extends shopstates{}

class ShopSuccessState extends shopstates{}

class ShopErrorState extends shopstates{
  final dynamic error;

  ShopErrorState(this.error);

}
class ShopSuccessCategoriesState extends shopstates{}

class ShopErrorCategoriesState extends shopstates{
  final dynamic error;

  ShopErrorCategoriesState(this.error);

}


class ShopSuccessChangeFavoritesState extends shopstates{
  final FavoritesModel favoritesModel;

  ShopSuccessChangeFavoritesState(this.favoritesModel);
}
class ShopChangeFavoritesState extends shopstates{}

class ShopErrorChangeFavoritesState extends shopstates{
  final dynamic error;

  ShopErrorChangeFavoritesState(this.error);

}
class ShopLoadingGetFavoritesState extends shopstates{}
class ShopSuccessGetFavoritesState extends shopstates{}

class ShopErrorGetFavoritesState extends shopstates{
  final dynamic error;

  ShopErrorGetFavoritesState(this.error);

}
class ShopLoadingUserState extends shopstates{}
class ShopSuccessUserState extends shopstates{}

class ShopErrorUserState extends shopstates{
  final dynamic error;

  ShopErrorUserState(this.error);

}
class ShopLoadingUpdateUserState extends shopstates{}
class ShopSuccessUpdateUserState extends shopstates{}

class ShopErrorUpdateUserState extends shopstates{
  final dynamic error;

  ShopErrorUpdateUserState(this.error);

}



