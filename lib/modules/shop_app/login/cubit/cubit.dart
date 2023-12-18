// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_Login/login_model.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/network/endpoints.dart';
import 'package:shopapp/network/remote/dio_helpear.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLogininitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel ?loginModel;

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLodingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
     
      loginModel=ShopLoginModel.fromjson(value.data);
  
      emit(ShopLoginSuccesState(loginModel!));
    
    }).catchError((error) {
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepassword() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginchangepasswordState());
  }
}
