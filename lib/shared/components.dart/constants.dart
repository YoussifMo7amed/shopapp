// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shopapp/modules/shop_app/login/login.dart';
import 'package:shopapp/network/local/cache.dart';

void logout(context){
 casheHealper.RemoveData(Key: 'Token').then((value) {
 if(value){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                 }
 });
}
 dynamic Token ='';
