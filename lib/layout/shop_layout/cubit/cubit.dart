
// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/Home/home_model.dart';
import 'package:shopapp/models/categories/categories_model.dart';
import 'package:shopapp/models/favorites/fav_mod.dart';
import 'package:shopapp/models/favorites/favorites_model.dart';
import 'package:shopapp/models/shop_Login/login_model.dart';
import 'package:shopapp/modules/shop_app/categories/categories.dart';
import 'package:shopapp/modules/shop_app/favorites/favorites.dart';
import 'package:shopapp/modules/shop_app/products/products.dart';
import 'package:shopapp/modules/shop_app/settengs/settengs.dart';
import 'package:shopapp/network/endpoints.dart';
import 'package:shopapp/network/remote/dio_helpear.dart';
import 'package:shopapp/shared/components.dart/constants.dart';


class shopcubit extends Cubit<shopstates> {
  shopcubit() : super(shopinitialstate());
  static shopcubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Homemodel? homemodel;
  Categoriesmodel? categoriesmodel;
  FavoritesModel?favoritesModel;
  FavoriteModel? favoriteModel;
  ShopLoginModel? UserModel;
  List<Widget> bottomscreens = [
    const productsScreen(),
    const categoriesScreen(),
    const favoritessScreen(),
    SettengsScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeShopButtomnavbarState());
  }
Map<int,bool> favorites={};
  void getData() { 
    emit(ShopLoadingState());
    DioHelper.getData(
      url: HOME,
      Token: Token,
      lang: 'en'
    ).then((value) {
      homemodel = Homemodel.fromjson(value.data);
 homemodel!.data!.products.forEach((element) {
   favorites.addAll(
    {
      element.id:element.in_favorites!
    }
   );
  
 },);
      emit(ShopSuccessState());
    }).catchError(( error) {
      emit(ShopErrorState(error));
    });
  }
  void getCategories() { 
    DioHelper.getData(
      url: Get_Categories,
   
      lang: 'en'
    ).then((value) {
      categoriesmodel = Categoriesmodel.fromjson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError(( error) {
      emit(ShopErrorCategoriesState(error));
    });
  }

void ChangeFavorites(int productId){
  favorites[productId]=! favorites[productId]!;
  emit(ShopChangeFavoritesState());
DioHelper.postData(
  url: FAVORITES,
   data: {
'product_id':productId
   },
   Token: Token
   ).then((value) {
    favoritesModel=FavoritesModel.fromjson(value.data);
    if(!favoritesModel!.status!)
    {
      favorites[productId]=! favorites[productId]!;
    }else
    {
      GetFavorites();
    }
emit(ShopSuccessChangeFavoritesState(favoritesModel!));
   }).catchError((error){
    favorites[productId]=! favorites[productId]!;
emit(ShopErrorChangeFavoritesState(error));
   });
}

 void GetFavorites() { 
  emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
   Token: Token,
      lang: 'en'
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError(( error) {
      emit(ShopErrorGetFavoritesState(error));
    });
  }

void Getprofile() { 
  emit(ShopLoadingUserState());
    DioHelper.getData(
      url: PROFILE,
   Token: Token,
      lang: 'en'
    ).then((value) {
      UserModel = ShopLoginModel.fromjson(value.data);

      emit(ShopSuccessUserState());
    }).catchError(( error) {
      emit(ShopErrorUserState(error));
    });
  }
void Updateprofile({
 required String ?name,
 required String ? email,
 required String ? phone,
}) { 
  emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
'name':name,
'email':email,
'phone':phone
      },
   Token: Token,
      lang: 'en'
    ).then((value) {
      UserModel = ShopLoginModel.fromjson(value.data);

      emit(ShopSuccessUpdateUserState());
    }).catchError(( error) {
      emit(ShopErrorUpdateUserState(error));
    });
  }

}
