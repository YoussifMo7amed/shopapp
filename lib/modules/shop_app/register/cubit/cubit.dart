// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/register/cubit/states.dart';
import 'package:shopapp/network/endpoints.dart';
import 'package:shopapp/network/remote/dio_helpear.dart';

import '../../../../models/shop_Login/Login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterinitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
 ShopLoginModel? loginModel;

  void UserRegister({
    required String name,
    required String email,
    required String password,
     required String phone,
  }) {
    emit(ShopRegisterLodingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'name':name,
      'password': password,
      'phone':phone
    }).then((value) {
     
      loginModel=ShopLoginModel.fromjson(value.data);
 emit(ShopRegisterSuccesState(loginModel!));
    
    }).catchError((error) {
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changepassword() {
    ispassword = !ispassword;
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterchangepasswordState());
  }
}
