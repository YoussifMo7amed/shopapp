
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/shop_layout.dart';
import 'package:shopapp/modules/shop_app/login/login.dart';
import 'package:shopapp/modules/shop_app/on_boarding.dart';
import 'package:shopapp/network/local/cache.dart';
import 'package:shopapp/network/remote/dio_helpear.dart';
import 'package:shopapp/shared/bloc_observe.dart';
import 'package:shopapp/shared/components.dart/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await casheHealper.init();
  bool? isdark = casheHealper.get(key: 'isdark');
  bool? onboarding = casheHealper.get(key: 'onBoarding');
     
     Token = casheHealper.get(key: 'Token');

      Widget? widget;
if(onboarding!=null)
{
if(Token!=null)
{
  widget =const ShopLayout();
}else {
  widget=LoginScreen();
}
}
else{
  
  widget =const onBoardingSCreen();
}
  runApp(MainApp(isdark: isdark,
  widget: widget,
  ));
}

class MainApp extends StatelessWidget {
  bool ?isdark = true;
 Widget ?widget;

  MainApp({super.key, 
    this.widget,
    this.isdark, }
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              Appcubit()
        ),
      
         BlocProvider(
          create: (BuildContext context) =>
              shopcubit()..getData()..getCategories()..GetFavorites()..Getprofile()
        ),
      ],
      child: BlocConsumer<Appcubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
             home: widget,
             // themeMode: Appcubit.get(context).isdark
              //    ? ThemeMode.dark
               //   : ThemeMode.light,
              theme:ThemeData(   
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
                textTheme: const TextTheme(
                  
                    bodyLarge: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                
                useMaterial3: true,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    surfaceTintColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(color: Colors.black)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                  selectedItemColor: Colors.deepOrange,
                ), ),
              //darkTheme:darktheme,
              debugShowCheckedModeBanner: false,
             );
        },
      ),
    );
  }
}
