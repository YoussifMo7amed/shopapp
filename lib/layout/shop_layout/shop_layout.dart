
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/modules/shop_app/Search/search.dart';
import 'package:shopapp/shared/components.dart/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit, shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = shopcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('salla'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, searchScreen());
              }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomscreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items:const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settengs'),
            ],
          ),
        );
      },
    );
  }
}
